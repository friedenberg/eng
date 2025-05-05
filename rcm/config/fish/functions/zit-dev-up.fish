function zit-dev-up
  set -l link ~/.local/bin/zit
  ln -sf ~/eng/zit/go/zit/build/zit $link
end
