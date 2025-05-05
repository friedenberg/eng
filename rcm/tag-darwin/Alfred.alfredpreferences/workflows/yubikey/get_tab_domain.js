#! /usr/bin/env /Users/sasha/Zettelkasten/1560e60.js

const lib = require("~/Zettelkasten/fde749d.js");

function main(argv) {
  const chrome = Application("Google Chrome");
  chrome.includeStandardAdditions = true

  const windows = chrome.windows();

  if (chrome.windows.length == 0) {
    return
  }

  //when iterating via for..in, arrays are 1-indexed
  //when accessing via [] syntax, arrays are 0-indexed
  const w = chrome.windows[0];
  const activeTabIndex = w.activeTabIndex();
  const url = w.tabs[activeTabIndex - 1].url();
  const matches = url.match(/^https?\:\/\/([^\/?#]+)(?:[\/?#]|$)/i);
  const domain = matches && matches[1];
  const elements = domain.split(".");
  const bare = elements[elements.length - 2];
  lib.log(bare.toLowerCase());
}

exports.main = main;
