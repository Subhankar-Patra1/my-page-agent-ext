# Terms of Use

**Last Updated:** May 2026

Welcome to the Page Agent / Oryonix AI open-source project. By installing, configuring, or utilizing the browser extension, associated software components, or our free testing API, you agree to be bound by these Terms of Use ("Terms"). If you do not agree to these Terms, do not use the Software or the API.

---

## 1. Scope, Definitions & Open Source Foundation
* **Definitions:** "We", "us", or "our" refers to the maintainers of the open-source Page Agent / Oryonix AI project (https://github.com/alibaba/page-agent). "The Software" refers to Page Agent (the JavaScript library) and Page Agent Ext / Oryonix AI (the browser extension). "The API" refers to the free testing LLM API provided for technical evaluation.
* **Scope:** These Terms govern your use of the Software and the API. They do **not** cover any third-party products, systems, or services you configure or build with the Software.
* **Open Source:** The Software is open source under the MIT License and can be audited publicly at: https://github.com/alibaba/page-agent.

---

## 2. Core Operational Principles & Future BYOK Support
* **Client-Side Architecture:** The Software operates strictly as a client-side tool. By default, all browser perception, DOM analysis, and agentic workflows are executed locally on your machine. In a future update, we will introduce a "Bring Your Own Key" (BYOK) architecture to let you configure custom third-party LLM API credentials directly.
* **Third-Party API Costs:** **Once the BYOK feature is active**, when using cloud LLM providers (e.g., OpenAI, Anthropic, Gemini, Groq, Mistral), you will be solely responsible for all bandwidth, token usage, and billing costs generated through your configured API keys.

---

## 3. Testing API and Demo Disclaimer & Terms of Use
To facilitate rapid technical evaluation and testing, we provide a free testing LLM API. By utilizing this API (configured by default in our demo and CDN bundles), you agree to the following terms:
* **Permitted R&D Use Only:** This API is provided strictly for technical evaluation and research purposes. You must not deploy it in any production environment, integrate it into commercial services, or use it for automated web scraping at scale.
* **Sensitive Data Prohibition:** You are strictly prohibited from submitting Personal Identifiable Information (PII), confidential business data, financial records, medical records, or running the agent on web pages containing such sensitive info.
* **Localization Notice:** The testing API processes data via servers located in Mainland China. If you are located in a region with strict data localization laws (such as the EU/EEA), please do not use this testing API.
* **Age Requirement:** The Software and API are not intended for use by individuals under the age of 13 (or the minimum age of digital consent in your jurisdiction).
* **Availability:** This free API is provided on an "AS IS" and "AS AVAILABLE" basis. It may be rate-limited, degraded, or discontinued at any time without notice.

---

## 4. Operational Guardrails & Mandatory Human Supervision
The Software leverages probabilistic Large Language Models (LLMs) to interpret page layouts and generate dynamic actions (clicking, typing, scrolling, tab management).
* **No Guarantee of Flawless Execution:** The Software may misinterpret landmarks, fail to identify dynamic changes, or generate unintended browser actions.
* **Mandatory Human Supervision:** The Software is strictly an assistive tool. You are required to actively supervise the agent during active execution, particularly during workflows involving financial transactions, sensitive personal data, or system configuration changes.
* **No Financial Liability:** The maintainers are not liable for accidental purchases, incorrect bookings, data loss, or unauthorized financial transactions resulting from automated actions.
* **Emergency Halt:** You maintain immediate override control. You can terminate agent execution at any moment by closing the active browser tab or clicking the stop button in the interface.

---

## 5. Ethical Use & Platform Compliance
When utilizing the Software, you agree to abide by the following ethical guidelines:
* **Platform ToS Compliance:** You are solely responsible for ensuring that all automated browser actions and web interactions comply with the target websites' Terms of Service and scraping policies.
* **Prohibited Activities:** You agree **NOT** to use the Software to:
  * Overwhelm web servers or conduct Denial of Service (DDoS) attacks.
  * Illicitly bypass paywalls, security gates, or CAPTCHA verification unethically.
  * Harvest user credentials or proprietary data without legal authorization.
  * Automate spam distribution or fraudulent digital interactions.

---

## 6. Disclaimer of Warranties & Limitation of Liability
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
