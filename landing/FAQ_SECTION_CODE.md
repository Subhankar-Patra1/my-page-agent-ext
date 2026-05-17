# Oryonix AI — Premium FAQ Section Code

This document contains the high-fidelity, Bento-style FAQ interface code implemented for the Oryonix landing page.

## 1. React Component (`App.tsx`)

```tsx
/* ─── FAQ Data ─── */
const FAQS = [
  { 
    question: "Is Oryonix AI free to use?", 
    answer: <>Yes, the browser extension is completely open-source and free to install. You can check out our <a href={SITE.github} target="_blank" rel="noreferrer" style={{color: 'var(--color-accent-primary)', textDecoration: 'none'}}>GitHub repository</a>.</> 
  },
  { 
    question: "Do I need my own API key?", 
    answer: <>Oryonix allows you to <strong>Bring Your Own Key (BYOK)</strong> or connect to a local <a href="https://ollama.com/" target="_blank" rel="noreferrer" style={{color: 'var(--color-accent-primary)', textDecoration: 'none'}}>Ollama</a> instance, giving you complete control over your usage and privacy.</> 
  },
  { question: "What data does the agent collect?", answer: "Oryonix is privacy-first. It runs locally in your browser and only accesses the active tab when you explicitly trigger it." },
  { question: "Can it bypass CAPTCHAs?", answer: "While highly capable, Oryonix relies on standard web accessibility. Heavy bot protection or complex CAPTCHAs may require human intervention." },
  { question: "How is this different from standard browser automation?", answer: <>Instead of rigid, easily broken scripts (like <code style={{background: 'rgba(255,255,255,0.1)', padding: '2px 6px', borderRadius: '4px', fontSize: '0.9em'}}>Puppeteer</code>), Oryonix uses AI to understand natural language. It 'sees' the page like a human and adapts to layout changes automatically.</> },
  { question: "Does it work on any website?", answer: "Yes. Oryonix is designed to interact with the DOM directly, meaning it can navigate and perform actions on virtually any website, from simple blogs to complex web apps." },
  { question: "Can I use it with multiple Chrome profiles?", answer: "Absolutely. Oryonix installs as a standard Chrome extension and maintains separate settings and history for each of your browser profiles." },
  { question: "Is it available on other browsers?", answer: "Currently, Oryonix is optimized for Chrome and Chromium-based browsers (Edge, Brave). A Firefox version is on our roadmap for future release." },
  { question: "How secure is my browsing history?", answer: "Extremely secure. Since Oryonix runs locally (BYOK or Ollama), your commands and browsing data never touch our servers. You have 100% data sovereignty." }
];

/* ─── FAQ Component ─── */
function FAQ() {
  const [openIndices, setOpenIndices] = useState<number[]>([]);
  const [searchQuery, setSearchQuery] = useState("");

  const toggleFAQ = (index: number) => {
    setOpenIndices(prev => 
      prev.includes(index) ? prev.filter(i => i !== index) : [...prev, index]
    );
  };

  const filteredFAQs = FAQS.map((faq, originalIndex) => ({ ...faq, originalIndex }))
    .filter(f => f.question.toLowerCase().includes(searchQuery.toLowerCase()));

  return (
    <section id="faq" className="section container" style={{ paddingBottom: '120px' }}>
      <div className="section__head">
        <h2 style={{ textAlign: 'center', marginBottom: '64px' }}>
          Frequently Asked <span className="accent-text">Questions</span>
        </h2>
      </div>

      <div className="faq-search-wrapper">
        <Search size={20} style={{ position: 'absolute', left: '20px', top: '50%', transform: 'translateY(-50%)', color: 'var(--color-text-tertiary)' }} />
        <input 
          type="text" 
          placeholder="Search questions..." 
          className="faq-search-input"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
      </div>

      <div className="faq-card-grid">
        <AnimatePresence mode="popLayout">
          {filteredFAQs.map((faq) => {
            const isOpen = openIndices.includes(faq.originalIndex);
            return (
              <motion.div
                layout
                key={faq.originalIndex}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.95 }}
                transition={{ duration: 0.3 }}
                className={`faq-modern-card ${isOpen ? 'faq-modern-card--active' : ''}`}
                onClick={() => toggleFAQ(faq.originalIndex)}
              >
                <div className="faq-card-header">
                  <h3 className="faq-card-question">{faq.question}</h3>
                  <div className="faq-card-icon">
                    <ChevronDown size={20} />
                  </div>
                </div>

                <AnimatePresence>
                  {isOpen && (
                    <motion.div
                      initial={{ height: 0, opacity: 0 }}
                      animate={{ height: 'auto', opacity: 1 }}
                      exit={{ height: 0, opacity: 0 }}
                      transition={{ duration: 0.3, ease: [0.16, 1, 0.3, 1] }}
                      style={{ overflow: 'hidden' }}
                    >
                      <div className="faq-card-answer">
                        {faq.answer}
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </motion.div>
            );
          })}
        </AnimatePresence>
      </div>

      {filteredFAQs.length === 0 && (
        <div style={{ textAlign: 'center', padding: '64px', color: 'var(--color-text-tertiary)' }}>
          No results found for "{searchQuery}"
        </div>
      )}

      {/* Extended Footer CTA */}
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ delay: 0.4, duration: 0.6, ease: [0.16, 1, 0.3, 1] }}
        className="faq-footer-cta"
      >
        <div className="faq-footer-cta__text">
          <MessageSquare size={20} className="faq-footer-cta__icon" />
          <p>Still have questions? Can't find the answer you're looking for?</p>
        </div>
        <a href={SITE.github} className="btn btn--sm btn--glass faq-footer-cta__btn" target="_blank" rel="noopener noreferrer">
          <GithubIcon size={16} style={{marginRight: '8px'}} /> Read Documentation
        </a>
      </motion.div>
    </section>
  );
}
```

## 2. Styles (`App.css`)

```css
/* ═══════════ GRID FAQ ═══════════ */
.faq-search-wrapper {
  max-width: 600px;
  margin: 0 auto 64px;
  position: relative;
}

.faq-search-input {
  width: 100%;
  padding: 16px 20px 16px 52px;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 99px;
  color: white;
  font-size: 1rem;
  outline: none;
  transition: all 0.3s var(--ease-out-expo);
}

.faq-search-input:focus {
  border-color: rgba(249, 115, 22, 0.4);
  background: rgba(255, 255, 255, 0.05);
  box-shadow: 0 0 20px rgba(249, 115, 22, 0.1);
}

.faq-card-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  max-width: 1200px;
  margin: 0 auto;
  align-items: start;
}

@media (max-width: 1024px) {
  .faq-card-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 640px) {
  .faq-card-grid { grid-template-columns: 1fr; }
}

.faq-modern-card {
  background: rgba(26, 20, 16, 0.6);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(249, 115, 22, 0.15);
  border-radius: 20px;
  padding: 24px 22px;
  cursor: pointer;
  transition: all 0.4s var(--ease-out-expo);
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  min-height: 100px;
  height: fit-content;
  align-self: start;
  position: relative;
  overflow: hidden;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3), 0 0 20px rgba(249, 115, 22, 0.02);
}

.faq-modern-card:hover {
  background: rgba(32, 24, 20, 0.8);
  border-color: rgba(249, 115, 22, 0.3);
  transform: translateY(-4px);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5), 0 0 40px rgba(249, 115, 22, 0.05);
}

.faq-modern-card--active {
  background: rgba(38, 28, 24, 0.95) !important;
  border-color: rgba(249, 115, 22, 0.5);
  box-shadow: 0 25px 80px rgba(0, 0, 0, 0.6), 0 0 50px rgba(249, 115, 22, 0.1);
}

.faq-card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
  width: 100%;
}

.faq-card-question {
  font-size: 1rem;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.95);
  margin: 0;
  line-height: 1.4;
}

.faq-card-icon {
  color: rgba(249, 115, 22, 0.4);
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  transform-origin: center;
}

.faq-modern-card--active .faq-card-icon {
  transform: rotate(180deg);
  color: var(--color-accent-primary);
}

.faq-card-answer {
  color: var(--color-text-secondary);
  font-size: 0.95rem;
  line-height: 1.6;
  margin-top: 16px;
}

/* ═══════════ FAQ FOOTER CTA ═══════════ */
.faq-footer-cta {
  max-width: 850px;
  margin: 100px auto 0;
  padding: 16px 32px;
  background: rgba(26, 20, 16, 0.4);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(249, 115, 22, 0.15);
  border-radius: 100px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 24px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
  transition: all 0.4s var(--ease-out-expo);
}

.faq-footer-cta:hover {
  background: rgba(32, 24, 20, 0.6);
  border-color: rgba(249, 115, 22, 0.3);
  transform: translateY(-2px);
  box-shadow: 0 15px 50px rgba(0, 0, 0, 0.4), 0 0 30px rgba(249, 115, 22, 0.05);
}

.faq-footer-cta__text {
  display: flex;
  align-items: center;
  gap: 16px;
  color: var(--color-text-secondary);
}

.faq-footer-cta__text p {
  margin: 0;
  font-size: 0.95rem;
  font-weight: 500;
  letter-spacing: 0.01em;
}

.faq-footer-cta__icon {
  color: var(--color-accent-primary);
  filter: drop-shadow(0 0 8px rgba(249, 115, 22, 0.3));
}

.faq-footer-cta__btn {
  background: rgba(255, 255, 255, 0.03) !important;
  border-color: rgba(255, 255, 255, 0.08) !important;
  color: var(--color-text-secondary) !important;
  border-radius: 100px !important;
}

.faq-footer-cta__btn:hover {
  background: rgba(249, 115, 22, 0.06) !important;
  border-color: rgba(249, 115, 22, 0.3) !important;
  color: var(--color-text-primary) !important;
  transform: translateY(-1px);
}

@media (max-width: 768px) {
  .faq-footer-cta {
    border-radius: 24px;
    padding: 24px;
    justify-content: center;
    text-align: center;
  }
  .faq-footer-cta__text { flex-direction: column; gap: 12px; }
}
```
