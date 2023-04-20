#!/bin/sh

gb() {
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


gcm() {
  local push=false message="checkpoint"

  # Parse command line arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
      -p|--push)
        push=true
        shift ;;
      -m|--message)
        message="$2"
        shift 2 ;;
      *)
        echo "Unknown option: $1"
        return 1 ;;
    esac
  done

  # Exit if there are no changes
  if [[ -z $(git status -s) ]]; then
    echo "No changes to commit. Exiting."
    return 0
  fi

  # Perform Git commands
  git add .
  git commit -m "$message"
  if $push; then
    git push
  fi
}

gps() {
  git push
}


# Append the gb function to the ~/.bashrc file
echo "# Add the gb function to the command line" >> ~/.bashrc
echo "function gb() {" >> ~/.bashrc
echo "  if [ \"\$1\" = \"-a\" ] || [ \"\$1\" = \"--all\" ]; then" >> ~/.bashrc
echo "    git branch" >> ~/.bashrc
echo "  elif [ \"\$1\" = \"-c\" ] || [ \"\$1\" = \"--current\" ]; then" >> ~/.bashrc
echo "    git rev-parse --abbrev-ref HEAD" >> ~/.bashrc
echo "  else" >> ~/.bashrc
echo "    git branch | grep -v '^  __'" >> ~/.bashrc
echo "  fi" >> ~/.bashrc
echo "}" >> ~/.bashrc

# Print a message to confirm that the function was added to the ~/.bashrc file
echo "The gb function has been added to the ~/.bashrc file"