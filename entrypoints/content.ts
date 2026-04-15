import { initPageController } from '../agent/RemotePageController.content';

export default defineContentScript({
  matches: ['<all_urls>'],
  runAt: 'document_end',

  main() {
    console.debug('[Content] Loaded on', window.location.href);
    initPageController();
  },
});
