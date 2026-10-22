use std::collections::BTreeMap;
use std::fmt;

use base64::Engine;
use base64::engine::general_purpose::STANDARD as b64;

#[derive(Debug)]
pub struct LunaError {
    pub status: u16,
    pub detail: String,
}

impl fmt::Display for LunaError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "lunaux error {}: {}", self.status, self.detail)
    }
}
impl std::error::Error for LunaError {}

pub struct LunaUXClient {
    base: String,
    agent: ureq::Agent,
}

impl LunaUXClient {
    pub fn new() -> Self {
        LunaUXClient::with_base("https://lunaux-decompiler.dev")
    }

    pub fn with_base(base: &str) -> Self {
        LunaUXClient {
            base: base.trim_end_matches('/').to_string(),
            agent: ureq::AgentBuilder::new().user_agent("lunaux-rust/1.0").build(),
        }
    }

    pub fn decompile(&self, bytecode: &[u8], options: Option<&BTreeMap<String, bool>>) -> Result<String, LunaError> {
        let mut body = serde_json::json!({ "bytecode": b64.encode(bytecode) });
        if let Some(o) = options {
            body["options"] = serde_json::json!(o);
        }
        self.post(&format!("{}/api/decompile", self.base), body.to_string(), "application/json")
    }

    pub fn disassemble(&self, bytecode: &[u8]) -> Result<String, LunaError> {
        let body = serde_json::json!({ "bytecode": b64.encode(bytecode) }).to_string();
        self.post(&format!("{}/api/disassemble", self.base), body, "application/json")
    }

    pub fn cfg(&self, bytecode: &[u8]) -> Result<String, LunaError> {
        self.post(&format!("{}/api/cfg", self.base), b64.encode(bytecode), "text/plain")
    }

    fn post(&self, url: &str, body: String, ctype: &str) -> Result<String, LunaError> {
        match self.agent.post(url).set("Content-Type", ctype).send_string(&body) {
            Ok(r) => r.into_string().map_err(|e| LunaError { status: 0, detail: e.to_string() }),

            Err(ureq::Error::Status(code, r)) => {
                let text = r.into_string().unwrap_or_default();
                let detail = serde_json::from_str::<serde_json::Value>(&text)
                    .ok()
                    .and_then(|v| v["detail"].as_str().map(str::to_string))
                    .unwrap_or(text);
                Err(LunaError { status: code, detail })
            }

            Err(e) => Err(LunaError { status: 0, detail: e.to_string() }),
        }
    }
}