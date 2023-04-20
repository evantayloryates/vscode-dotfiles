

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
  local push=false message="checkpoint" filelist=()

  # Check if the current branch is master or production
  local branch=$(git rev-parse --abbrev-ref HEAD)
  if [[ $branch == "master" || $branch == "production" ]]; then
    read -p "You are on the $branch branch. Proceed? (y/n) " confirm
    if [[ $confirm != "y" && $confirm != "Y" ]]; then
      echo "Exiting."
      return 1
    fi
  fi

  # Parse command line arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
      -p|--push)
        push=true
        shift ;;
      -m|--message)
        message="$2"
        shift 2 ;;
      -f|--files)
        # Parse the list of files
        while [[ $# -gt 1 && $2 != -* ]]; do
          filelist+=("$2")
          shift
        done
        # Add the files to Git
        git add "${filelist[@]}"
        ;;
      *)
        echo "Unknown option: $1"
        return 1 ;;
    esac
  done

  # If no file list was specified, add all changes
  if [[ ${#filelist[@]} -eq 0 ]]; then
    # Exit if there are no changes
    if [[ -z $(git status -s) ]]; then
      echo "No changes to commit. Exiting."
      return 0
    fi
    git add .
  fi

  # Perform Git commands
  git commit -m "$message"
  if $push; then
    git push
  fi
}


gps() {
  git push
}
