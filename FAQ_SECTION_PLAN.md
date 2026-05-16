# Oryonix AI - FAQ Section Implementation Plan

To ensure the FAQ section perfectly mimics the existing "orange and black" UI and matches the UX of your current modal cards (like the BentoGrid feature cards), we will use the exact same CSS architecture and Framer Motion animations.

Here is the updated, highly detailed blueprint with the exact code structure we will use.

## 1. Visual Design (The "Orange & Black" Modal UI)
Each FAQ item will be built as a distinct "Modal Card" rather than a simple text list. We will reuse your exact `.feature-card` CSS logic.

* **The Black Glass Container:** 
  We will use your existing CSS variables to ensure perfect harmony:
  `background: var(--glass-bg);` (Deep translucent black)
  `border: var(--glass-border);` (Subtle white translucent edge)
  `backdrop-filter: blur(12px);`

* **The Orange Glow UX (Active/Hover States):** 
  Just like your current feature cards, when a user hovers over or clicks an FAQ card, it will physically lift up and emit your signature orange glow:
  ```css
  .faq-card:hover, .faq-card--active {
    transform: translateY(-4px);
    border-color: rgba(249, 115, 22, 0.3); /* The signature orange */
    box-shadow: 0 12px 40px rgba(0,0,0,0.4), 0 0 20px rgba(249, 115, 22, 0.1);
  }
  ```

## 2. Interaction Animation (The UX)
The UX must be incredibly fluid. When an FAQ modal card is clicked, we won't just instantly show the text. We will use Framer Motion to smoothly slide the card open, keeping the interaction identical to the rest of your site's premium animations.

* **The Icon:** A `ChevronDown` icon will sit on the right side. On click, it will smoothly rotate 180 degrees and change its color to `var(--color-accent-primary)` (Orange).
* **The Body:** The answer text will slide down gracefully using Framer Motion's `AnimatePresence`.

## 3. The Code Structure (React + Framer Motion)

Here is exactly how the component will be structured in your codebase:

```tsx
import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown } from 'lucide-react';

const FAQS = [
  { question: "Is Oryonix AI free to use?", answer: "Yes, the browser extension is completely open-source and free to install." },
  { question: "Do I need my own API key?", answer: "Oryonix allows you to Bring Your Own Key (BYOK) so you have complete control over your usage and privacy." },
  // ... more questions
];

export function FAQSection() {
  const [openIndex, setOpenIndex] = useState<number | null>(null);

  return (
    <section className="section container">
      <div className="section__header text-center">
        <h2 className="section__title">Frequently Asked <span className="accent-text">Questions</span></h2>
      </div>

      <div className="faq-grid" style={{ maxWidth: '800px', margin: '0 auto', display: 'flex', flexDirection: 'column', gap: '16px' }}>
        {FAQS.map((faq, index) => {
          const isOpen = openIndex === index;
          return (
            <div 
              key={index} 
              className={`feature-card faq-card ${isOpen ? 'faq-card--active' : ''}`}
              onClick={() => setOpenIndex(isOpen ? null : index)}
              style={{ padding: '24px', cursor: 'pointer' }}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h3 style={{ fontSize: '1.1rem', fontWeight: 500, margin: 0, color: isOpen ? 'var(--color-accent-primary)' : '#fff' }}>
                  {faq.question}
                </h3>
                <motion.div animate={{ rotate: isOpen ? 180 : 0 }} transition={{ duration: 0.3 }}>
                  <ChevronDown color={isOpen ? '#f97316' : '#888'} />
                </motion.div>
              </div>

              <AnimatePresence>
                {isOpen && (
                  <motion.div
                    initial={{ height: 0, opacity: 0, marginTop: 0 }}
                    animate={{ height: 'auto', opacity: 1, marginTop: '16px' }}
                    exit={{ height: 0, opacity: 0, marginTop: 0 }}
                    transition={{ duration: 0.3, ease: [0.16, 1, 0.3, 1] }}
                    style={{ overflow: 'hidden' }}
                  >
                    <p style={{ color: 'var(--color-text-secondary)', lineHeight: 1.6, margin: 0 }}>
                      {faq.answer}
                    </p>
                  </motion.div>
                )}
              </AnimatePresence>
            </div>
          );
        })}
      </div>
    </section>
  );
}
```

## Summary
By using the exact same `.feature-card` CSS variables, incorporating your specific `rgba(249, 115, 22)` orange glow, and leveraging `framer-motion` for the silky-smooth accordion reveal, this FAQ section will look and feel indistinguishable from your other high-end modal cards!
