function gb() {
  # List all branches
  if [ "$1" = "-a" ] || [ "$1" = "--all" ]; then
    git branch
  # Print current branch
  elif [ "$1" = "-c" ] || [ "$1" = "--current" ]; then
    git rev-parse --abbrev-ref HEAD
  # List non "stashed" branches
  else
    git branch | grep -v '^  __'
  fi
}
