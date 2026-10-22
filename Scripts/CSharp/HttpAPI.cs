#nullable enable
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Text.Json;

namespace LunaUX;

public class LunaUXException : Exception {
    public int StatusCode;
    public LunaUXException(string message, int statusCode = 0) : base(message) {
        StatusCode = statusCode;
    }
}

public sealed class LunaUXClient : IDisposable {
    const string DefaultBase = "https://lunaux-decompiler.dev";
    HttpClient http;
    bool ownsHttp;
    string baseUrl;

    public LunaUXClient(string url = DefaultBase, HttpClient? client = null) {
        baseUrl = url.TrimEnd('/');
        http = client ?? new HttpClient();
        ownsHttp = client == null;
        http.DefaultRequestHeaders.UserAgent.ParseAdd("lunaux-csharp/1.0");
    }

    public string Decompile(byte[] bytecode, IDictionary<string, bool>? options = null, string? filename = null) {
        var body = new Dictionary<string, object?>();
        body["bytecode"] = Convert.ToBase64String(bytecode);
        if (options != null) body["options"] = options;
        if (filename != null) body["filename"] = filename;
        return PostJson("/api/decompile", body);
    }

    public string Disassemble(byte[] bytecode, string? filename = null) {
        var body = new Dictionary<string, object?>();
        body["bytecode"] = Convert.ToBase64String(bytecode);
        if (filename != null) body["filename"] = filename;
        return PostJson("/api/disassemble", body);
    }

    public string CFG(byte[] bytecode) {
        var req = new HttpRequestMessage(HttpMethod.Post, baseUrl + "/api/cfg");
        req.Content = new StringContent(Convert.ToBase64String(bytecode), Encoding.UTF8, "text/plain");
        return Send(req);
    }

    string PostJson(string path, object body) {
        string json = JsonSerializer.Serialize(body);
        var req = new HttpRequestMessage(HttpMethod.Post, baseUrl + path);
        req.Content = new StringContent(json, Encoding.UTF8, "application/json");
        return Send(req);
    }

    string Send(HttpRequestMessage req) {
        using var resp = http.Send(req);
        string text = new StreamReader(resp.Content.ReadAsStream()).ReadToEnd();
        if (!resp.IsSuccessStatusCode) {
            string detail = text;
            try {
                using var doc = JsonDocument.Parse(text);
                if (doc.RootElement.TryGetProperty("detail", out var d))
                    detail = d.ToString();
            }
            catch { }
            throw new LunaUXException(detail, (int)resp.StatusCode);
        }
        return text;
    }

    public void Dispose() {
        if (ownsHttp)
            http.Dispose();
    }
}
