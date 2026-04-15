import { handlePageControlMessage } from '../agent/RemotePageController.background';
import { handleTabControlMessage, setupTabEventsPort } from '../agent/TabsController.background';

export default defineBackground(() => {
  console.log('Hello background!', { id: browser.runtime.id });
  chrome.sidePanel.setPanelBehavior({ openPanelOnActionClick: true }).catch(() => {});

  setupTabEventsPort();

  chrome.runtime.onMessage.addListener((message, sender, sendResponse): true | undefined => {
    if (message.type === 'TAB_CONTROL') {
      return handleTabControlMessage(message, sender, sendResponse);
    } else if (message.type === 'PAGE_CONTROL') {
      return handlePageControlMessage(message, sender, sendResponse);
    } else {
      sendResponse({ error: 'Unknown message type' });
      return;
    }
  });
});
