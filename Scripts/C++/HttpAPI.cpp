#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "httplib.h"
#include <map>
#include <stdexcept>
#include <string>

static std::string b64(const std::string& in) {
    static const char* t = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    std::string out;
    int val = 0, bits = -6;
    for (unsigned char c : in) {
        val = (val << 8) + c;
        bits += 8;
        while (bits >= 0) {
            out.push_back(t[(val >> bits) & 0x3f]);
            bits -= 6;
        }
    }
    if (bits > -6) out.push_back(t[((val << 8) >> (bits + 8)) & 0x3f]);
    while (out.size() % 4) out.push_back('=');
    return out;
}

class LunaUXClient {
public:
    LunaUXClient(const std::string& base = "https://lunaux-decompiler.dev") : cli(base) {
        cli.set_default_headers({ {"User-Agent", "lunaux-cpp/1.0"} });
    }

    std::string Decompile(const std::string& bytecode, const std::map<std::string, bool>& options = {}) {
        std::string body = "{\"bytecode\":\"" + b64(bytecode) + "\"";
        if (!options.empty()) {
            body += ",\"options\":{";
            bool first = true;
            for (auto& [k, v] : options) {
                if (!first) body += ",";
                body += "\"" + k + "\":" + (v ? "true" : "false");
                first = false;
            }
            body += "}";
        }
        body += "}";
        return post("/api/decompile", body, "application/json");
    }

    std::string Disassemble(const std::string& bytecode) {
        std::string body = "{\"bytecode\":\"" + b64(bytecode) + "\"}";
        return post("/api/disassemble", body, "application/json");
    }

    std::string CFG(const std::string& bytecode) {
        return post("/api/cfg", b64(bytecode), "text/plain");
    }

private:
    httplib::Client cli;
    std::string post(const std::string& path, const std::string& body, const char* ctype) {
        auto res = cli.Post(path.c_str(), body, ctype);
        if (!res)
            throw std::runtime_error("request failed: " + httplib::to_string(res.error()));
        if (res->status != 200)
            throw std::runtime_error("server " + std::to_string(res->status) + ": " + res->body);
        return res->body;
    }
};