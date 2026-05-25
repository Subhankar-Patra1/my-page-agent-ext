# Privacy Policy

**Last Updated:** May 2026

**Oryonix AI** ("the Software," including the core JavaScript library and browser extension) operates under a **local-first** security model. In strict adherence to the principles of **Data Minimization**, **User Sovereignty**, and **Regulatory Compliance** (such as GDPR and the EU AI Act), we do not track or aggregate your personal data.

---

### 1. Core Privacy Philosophy & Zero Telemetry
We believe your browsing data and search queries are yours alone. The Software is engineered with the following absolute privacy guarantees:
* **Zero Telemetry:** We do not track, aggregate, or sell your personal information, browsing history, or AI search queries. We have no centralized database or cloud logging system.
* **100% Data Sovereignty:** Your credentials, task configurations, execution history, and AI configurations are stored securely inside your browser's private local sandbox.
* **Direct Connections:** When cloud-based AI providers are configured, Oryonix AI connects directly to their respective endpoints (e.g., OpenAI, Gemini, Anthropic). Your keys and prompts never pass through any intermediate server managed by us.

---

### 2. Chrome Extension Permissions & Data Access Audit
To provide autonomous multi-tab browser automation, the extension requires specific Chromium permissions. Here is exactly what data is accessed and why:
* **`storage`:** Persists your settings, session history, configured LLM endpoints, and API credentials securely inside `chrome.storage.local`.
* **`tabs` & `tabGroups`:** Allows the agent to open new tabs, switch active tabs, group tabs, and navigate URLs to fulfill tasks.
* **`activeTab`:** Allows the agent to perceive the current web structure, click elements, and enter text *only* on the page you trigger it on.
* **`sidePanel`:** Displays the extension panel interface where you type commands, read active execution logs, and manage history.
* **`alarms`:** Coordinates minor heartbeat events and periodic task checking.
* **`audioCapture`:** Enables microphone access via the Web Speech API for voice command input directly within the extension panel.

---

### 3. Local Storage Schema & Data Control
Oryonix AI stores all task records and AI configs directly in your browser's private sandbox:
* **`local:oryonix_history`:** Stores your search queries, completed tasks, and execution logs.
* **`local:oryonix_live_session`:** Manages transient, real-time runtime state and active agent coordinates.
* **`llmConfig` & `advancedConfig`:** Stores your configured API key credentials, Ollama endpoints, and preference tokens.
* **`language`:** Persists your interface and speech recognition settings.

**Your Right to Deletion (GDPR Article 17):** Because all data is stored locally on your machine, you have absolute control over your digital footprint. You can instantly wipe all local data, configuration details, and execution logs at any time by clicking "Clear History" inside the sidepanel settings or uninstalling the extension.

---

### 4. AI Prompt Routing & Security Architecture
Oryonix AI routes data depending entirely on your configured AI provider settings:
* **Local LLM / Ollama (Offline Mode - Planned Future Feature):** When configured to use Ollama in the future (e.g., `http://localhost:11434`), Oryonix AI will operate entirely offline inside your local network. 100% of your prompts, dynamic page snapshots, and action logic will be processed locally on your machine.
* **Bring Your Own Key (BYOK) Cloud Routing (Planned Future Feature):** **Once the BYOK feature is active**, when cloud APIs (OpenAI, Gemini, Anthropic, Groq, Mistral) are selected, Oryonix AI will issue direct HTTPS queries to the respective official APIs. Your credentials will be saved only in local storage, and we will not log, intercept, or proxy your prompts.
* **Public Testing API (Web Demo & Sandbox Only):** In the rapid web evaluation sandbox or demo CDN scripts, Oryonix AI leverages a public testing API for research. **Do not enter confidential data** when using the testing API, as queries are processed on temporary instances located in Mainland China.

---

### 5. GDPR & Compliance Guardrails
We fully enforce legal and ethical AI guardrails, ensuring data protection by design:
* **Data Minimization:** Oryonix AI reads *only* the web structures necessary to achieve the task. It does not scan background tabs or collect general browsing behavior.
* **Mandatory Consent:** The agent remains idle until you explicitly trigger a task or direct it to read a page.
* **Emergency Halt:** You maintain physical control. You can sever connections and stop execution immediately by closing the side panel or active tab.

---

### Chrome Web Store Developer Verification Notice
This Privacy Policy page is the designated official legal policy for **Oryonix AI**. It is host-verified and published publicly for Chromium-based ecosystem developer audits, security evaluations, and Chrome Web Store listing approvals.
