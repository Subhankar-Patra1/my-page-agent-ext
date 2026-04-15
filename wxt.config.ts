import { defineConfig } from 'wxt';

// See https://wxt.dev/api/config.html
export default defineConfig({
  modules: ['@wxt-dev/module-react'],
  vite: () => ({
    build: {
      rollupOptions: {
        onwarn: function (message, handler) {
          // Suppresses the annoying [EVAL] warning we were seeing in the terminal
          if (message.code === 'EVAL') return;
          handler(message);
        },
      },
    },
  }),
  manifest: {
    permissions: ['tabs', 'storage', 'activeTab', 'scripting', 'sidePanel', 'tabGroups'],
    host_permissions: ['<all_urls>'],
    side_panel: {
      default_path: 'sidepanel/index.html'
    }
  },
});
