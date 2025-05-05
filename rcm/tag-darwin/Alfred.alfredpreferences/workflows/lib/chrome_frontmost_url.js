#! /usr/bin/osascript -l JavaScript

function run(argv) {
  const chrome = Application("Google Chrome");
  const windows = chrome.windows();
  const frontmostWindow = windows[0].get();
  const activeTab = frontmostWindow.activeTab.get();
  return activeTab.url();
}
