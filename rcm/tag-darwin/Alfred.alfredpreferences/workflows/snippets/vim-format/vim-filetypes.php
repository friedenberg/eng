#! /usr/bin/env php
<?php

$VIMRUNTIME = trim(shell_exec("vim -Nesc '!echo \$VIMRUNTIME' -c qa"));

$filetypes = shell_exec(
  "find \"$VIMRUNTIME/syntax\" \"$VIMRUNTIME/ftplugin\" -iname '*.vim' -exec basename -s .vim {} +"
);

$filetypes = array_unique(explode("\n", $filetypes));

$filetypes = array_values($filetypes);

$filetypes = array_map(
  function ($f) {
    return ['title' => $f, 'arg' => $f, 'uid' => "vim.filetype.$f"];
  },
  $filetypes
);

echo json_encode(['items' => $filetypes]);
