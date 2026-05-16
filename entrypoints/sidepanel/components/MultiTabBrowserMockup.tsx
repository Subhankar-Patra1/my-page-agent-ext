import { useEffect, useRef, useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'

type CursorState = 'arrow' | 'hand' | 'scroll'

interface Phase {
  cursorX: number
  cursorY: number
  state: CursorState
  tab: number
  scrollY: number
  ms: number
}

// Mockup dims: ~296px wide, layout heights:
//   titlebar 20px | tabs 24px | addressbar 22px | content 96px  → total 162px
// Tab centers (x):  tab0≈42  tab1≈100  tab2≈152
// Tab center (y):   20 + 12 = 32
// Content mid (y):  20 + 24 + 22 + 48 = 114
const PHASES: Phase[] = [
  { cursorX: 68,  cursorY: 108, state: 'arrow',  tab: 0, scrollY: 0,   ms: 700  },
  { cursorX: 100, cursorY: 32,  state: 'arrow',  tab: 0, scrollY: 0,   ms: 1000 },
  { cursorX: 100, cursorY: 32,  state: 'arrow',  tab: 0, scrollY: 0,   ms: 480  },
  { cursorX: 100, cursorY: 32,  state: 'hand',   tab: 1, scrollY: 0,   ms: 580  },
  { cursorX: 100, cursorY: 32,  state: 'arrow',  tab: 1, scrollY: 0,   ms: 160  },
  { cursorX: 136, cursorY: 110, state: 'arrow',  tab: 1, scrollY: 0,   ms: 950  },
  { cursorX: 136, cursorY: 110, state: 'arrow',  tab: 1, scrollY: 0,   ms: 420  },
  { cursorX: 136, cursorY: 110, state: 'scroll', tab: 1, scrollY: 0,   ms: 280  },
  { cursorX: 136, cursorY: 110, state: 'scroll', tab: 1, scrollY: -30, ms: 1300 },
  { cursorX: 136, cursorY: 110, state: 'arrow',  tab: 1, scrollY: -30, ms: 280  },
  { cursorX: 152, cursorY: 32,  state: 'arrow',  tab: 1, scrollY: -30, ms: 900  },
  { cursorX: 152, cursorY: 32,  state: 'arrow',  tab: 1, scrollY: -30, ms: 440  },
  { cursorX: 152, cursorY: 32,  state: 'hand',   tab: 2, scrollY: 0,   ms: 580  },
  { cursorX: 152, cursorY: 32,  state: 'arrow',  tab: 2, scrollY: 0,   ms: 160  },
  { cursorX: 80,  cursorY: 108, state: 'arrow',  tab: 2, scrollY: 0,   ms: 950  },
  { cursorX: 80,  cursorY: 108, state: 'arrow',  tab: 2, scrollY: 0,   ms: 800  },
]

// Tab content skeleton lines (widths as percentages) per tab
const TAB_CONTENT = [
  [72, 48, 88, 55, 92, 38, 64, 80, 44, 70],
  [55, 82, 38, 76, 60, 90, 45, 68, 85, 52],
  [88, 62, 78, 48, 95, 55, 72, 40, 82, 60],
]

const TAB_LABELS = ['shop.io', 'flights', 'wiki']
const TAB_URLS   = ['shop.io/deals', 'flights.com/search', 'wiki.org/article']

function ArrowCursor() {
  return (
    <svg width="14" height="18" viewBox="0 0 14 18" fill="none">
      <path
        d="M0.8 0.8 L0.8 13.8 L4.2 10.6 L7.2 17.2 L9.4 16.2 L6.4 9.6 L12.2 9.6 Z"
        fill="#fb923c"
        stroke="rgba(10,6,4,0.7)"
        strokeWidth="0.9"
        strokeLinejoin="round"
      />
    </svg>
  )
}

function HandCursor() {
  return (
    <svg width="13" height="17" viewBox="0 0 13 17" fill="none">
      <path
        d="M5.5 0.7C5.5 0.3 5.8 0 6.2 0C6.6 0 6.9 0.3 6.9 0.7L6.9 8.3
           C7.3 8 7.8 7.9 8.2 8.1C8.7 8.3 9 8.8 9 9.2
           C9.3 8.9 9.8 8.8 10.2 9C10.7 9.2 11 9.7 11 10.1
           C11.3 9.9 11.8 9.9 12.1 10.1C12.6 10.4 12.8 10.9 12.8 11.4
           L12.8 13C12.8 15.1 11.1 16.8 9 16.8
           L6 16.8C4.7 16.8 3.5 16 3 14.9
           L1.4 11.1C1.1 10.5 1.4 9.7 2 9.4C2.6 9.1 3.4 9.4 3.7 10
           L4.2 11.3L4.2 0.7C4.2 0.3 4.5 0 4.9 0C5.3 0 5.5 0.3 5.5 0.7Z"
        fill="#fb923c"
        stroke="rgba(10,6,4,0.7)"
        strokeWidth="0.5"
        strokeLinejoin="round"
      />
    </svg>
  )
}

function ScrollCursor() {
  return (
    <svg width="12" height="18" viewBox="0 0 12 18" fill="none">
      <rect x="1.5" y="1.5" width="9" height="15" rx="4.5"
        stroke="#fb923c" strokeWidth="1.5" />
      <rect x="4.5" y="4.5" width="3" height="5" rx="1.5"
        fill="#fb923c" />
    </svg>
  )
}

const CURSOR_MAP: Record<CursorState, React.ReactNode> = {
  arrow:  <ArrowCursor />,
  hand:   <HandCursor />,
  scroll: <ScrollCursor />,
}

export function MultiTabBrowserMockup() {
  const [phaseIdx, setPhaseIdx] = useState(0)
  const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  useEffect(() => {
    let current = 0

    const advance = () => {
      const phase = PHASES[current]
      timerRef.current = setTimeout(() => {
        current = (current + 1) % PHASES.length
        setPhaseIdx(current)
        advance()
      }, phase.ms)
    }

    advance()
    return () => { if (timerRef.current) clearTimeout(timerRef.current) }
  }, [])

  const phase = PHASES[phaseIdx]
  const lines = TAB_CONTENT[phase.tab]

  return (
    <div className="bmk-root">
      {/* Title bar */}
      <div className="bmk-titlebar">
        <span className="bmk-dot bmk-dot-r" />
        <span className="bmk-dot bmk-dot-y" />
        <span className="bmk-dot bmk-dot-g" />
      </div>

      {/* Tabs */}
      <div className="bmk-tabs">
        {TAB_LABELS.map((label, i) => (
          <div key={i} className={`bmk-tab${phase.tab === i ? ' bmk-tab-active' : ''}`}>
            {label}
          </div>
        ))}
        <div className="bmk-tab-spacer" />
      </div>

      {/* Address bar */}
      <div className="bmk-addressbar">
        <svg width="8" height="10" viewBox="0 0 8 10" fill="none" style={{ flexShrink: 0 }}>
          <rect x="1" y="4" width="6" height="5.5" rx="1" stroke="#6b7280" strokeWidth="1"/>
          <path d="M2.5 4V2.5A1.5 1.5 0 015.5 2.5V4" stroke="#6b7280" strokeWidth="1"/>
        </svg>
        <span className="bmk-url">{TAB_URLS[phase.tab]}</span>
      </div>

      {/* Content + cursor container */}
      <div className="bmk-body">
        {/* Scrollable page content */}
        <motion.div
          className="bmk-page"
          animate={{ y: phase.scrollY }}
          transition={{ type: 'spring', stiffness: 75, damping: 18 }}
        >
          {lines.map((w, i) => (
            <div
              key={i}
              className="bmk-line"
              style={{ width: `${w}%`, opacity: i % 4 === 0 ? 0.18 : 0.09 }}
            />
          ))}
        </motion.div>

        {/* Cursor — positioned absolute within bmk-root, not bmk-body */}
      </div>

      {/* Cursor lives at root level so it can roam over tabs + content */}
      <motion.div
        className="bmk-cursor"
        animate={{ x: phase.cursorX, y: phase.cursorY }}
        transition={{ type: 'spring', stiffness: 190, damping: 24 }}
      >
        <AnimatePresence mode="wait">
          <motion.div
            key={phase.state}
            initial={{ opacity: 0, scale: 0.6 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.6 }}
            transition={{ duration: 0.15, ease: 'easeOut' }}
          >
            {CURSOR_MAP[phase.state]}
          </motion.div>
        </AnimatePresence>
      </motion.div>
    </div>
  )
}
