function git-lazy-commit-and-push
  if test (count $argv) -gt 0
    git add $argv
  end

  set -l diff_status (git diff --cached 2>&1)

  if test -n "$diff_status"
    echo "committing..." >&2

    if not git commit -m update
      return 1
    end
  else
    echo "no changes, just pushing" >&2
  end

  echo "pushing..." >&2
  git push
end
