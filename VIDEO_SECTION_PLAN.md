# "See it in Action" Video Content Strategy

The "See it in action" section currently features a simulated terminal interface that textually describes what the Oryonix AI agent is doing. To elevate this section and make it truly captivating, you should replace or supplement this static UI with a high-fidelity video demonstration. 

Here is a detailed plan of what the video in this section should contain:

## 1. The Core Concept: "Split-Screen Autonomy"
The most effective way to showcase an AI browser agent is to show the **"Brain"** alongside the **"Action"**. 
The video should have a split-screen or picture-in-picture layout:
- **Left Side (The Brain):** A sleek, dark-themed terminal (similar to the current UI design) showing the agent's real-time thoughts and logs (e.g., `[Thinking...] Locating search bar`, `[Action] Typing "AirPods Pro"`).
- **Right Side (The Action):** A clean, borderless browser window showing the actual webpage moving autonomously. The cursor should move smoothly, and elements should highlight briefly before being clicked.

## 2. Suggested Video Scenarios

### Scenario A: The E-Commerce Comparison (Matches current UI)
- **Prompt:** "Compare prices for AirPods Pro on Amazon and Best Buy."
- **Visuals:** 
  1. The browser opens Amazon.com.
  2. The search bar is highlighted, and "AirPods Pro" is typed autonomously.
  3. The page scrolls down, and the price of the first legitimate result is highlighted.
  4. The browser opens a new tab for BestBuy.com and repeats the process.
  5. A sleek notification or popup appears summarizing the result: *"Best Buy is $10 cheaper."*

### Scenario B: Data Extraction & Form Filling
- **Prompt:** "Extract the top 5 trending repositories on GitHub and put them in a Google Sheet."
- **Visuals:**
  1. Browser navigates to GitHub Trending.
  2. The AI visually "scans" the list (perhaps a subtle scanning laser effect or highlights over the repository names).
  3. Browser switches to a blank Google Sheet.
  4. The cells populate automatically with the Repository Name, Star Count, and Language.

### Scenario C: Complex Workflow (Travel Booking)
- **Prompt:** "Find the cheapest direct flight from NYC to London next Friday."
- **Visuals:**
  1. The browser opens Google Flights.
  2. The departure, destination, and dates are filled in rapidly.
  3. The filter for "Non-stop" is clicked.
  4. The cheapest flight is highlighted and the booking page is opened.

## 3. Aesthetic Guidelines for the Video
To match the premium, glassmorphic aesthetic of the landing page:
- **No Clutter:** Hide browser bookmarks, extensions, and OS taskbars. The browser should look like a clean, minimal "sandbox".
- **Smooth Cursor:** The mouse movements should be rendered using bezier curves (smooth, easing in and out) rather than jerky, human-like movements. It should feel like a highly advanced machine.
- **High Resolution:** The video must be rendered in 4K or at least 1080p at 60FPS to ensure the smooth scrolling (Lenis) of your website isn't interrupted by a choppy video.
- **Glow Effects:** When the AI "clicks" an element on the screen, add a subtle orange ripple or glow effect that matches the site's primary accent color (`#f97316`).

## 4. Implementation Details
- **Format:** Export the video as an MP4 (H.264) for maximum compatibility, but also provide a WebM version for faster loading on modern browsers.
- **Autoplay:** The video should be set to `autoplay`, `loop`, `muted`, and `playsinline` so it plays automatically without requiring user interaction as soon as they scroll to the "See it in action" section.
