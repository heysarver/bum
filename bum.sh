#!/bin/bash

brew_yum() {
  local prefix=$1
  local command=$2
  shift 2

  case $command in
    install|remove|update|search)
      brew $prefix $command "$@"
      ;;
    list)
      brew $command "$@"
      ;;
    *)
      echo "Invalid command: $command"
      ;;
  esac
}

bum() {
  if [ $# -lt 2 ]; then
    echo "Usage: bum <option> <command>"
    return 1
  fi
  
  local option=$1
  local command=$2
  shift 2

  case $option in
    --cask-only|--no-formula|--no-forumlae)
      brew_yum "cask" "$command" "$@"
      ;;
    --formula-only|--formulae-only|--no-cask)
      brew_yum "" "$command" "$@"
      ;;
    list)
      brew_yum "" "$command" "$@"
      ;;
    *)
      brew_yum "" "$option" "$command" "$@"
      brew_yum "cask" "$option" "$command" "$@"
      ;;
  esac
}

bum "$@"
