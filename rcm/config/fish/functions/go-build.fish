function go-build
  go build ./... 2>&1 | grep -v "#" | cut -d : -f1
end

