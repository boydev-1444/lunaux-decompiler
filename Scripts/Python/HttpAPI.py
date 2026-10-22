import base64
import json
import urllib.request
import urllib.error

class LunaError(Exception):
    def __init__(self, status, detail):
        super().__init__(f"lunaux error {status}: {detail}")
        self.status = status
        self.detail = detail


class LunaUXClient:
    def __init__(self, base="https://lunaux-decompiler.dev"):
        self.base = base.rstrip("/")

    def decompile(self, bytecode, options=None):
        body = {"bytecode": base64.b64encode(bytecode).decode()}
        if options:
            body["options"] = options
        return self._post_json("/api/decompile", body)

    def disassemble(self, bytecode):
        body = {"bytecode": base64.b64encode(bytecode).decode()}
        return self._post_json("/api/disassemble", body)

    def cfg(self, bytecode):
        return self._send(self.base + "/api/cfg", base64.b64encode(bytecode), "text/plain")

    def _post_json(self, path, body):
        return self._send(self.base + path, json.dumps(body).encode(), "application/json")

    def _send(self, url, data, ctype):
        req = urllib.request.Request(url, data=data, method="POST", headers={"Content-Type": ctype, "User-Agent": "lunaux-py/1.0"})
        try:
            with urllib.request.urlopen(req) as r:
                return r.read().decode("utf-8", "replace")
        except urllib.error.HTTPError as e:
            text = e.read().decode("utf-8", "replace")
            try:
                detail = json.loads(text).get("detail", text)
            except Exception:
                detail = text
            raise LunaError(e.code, detail) from None
        except urllib.error.URLError as e:
            raise LunaError(0, str(e.reason)) from None