function wmake
  make $argv; and fswatch -o . | xargs -I {} make $argv
  return $status
end
