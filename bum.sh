#!/bin/bash

brew_yum() {
  local command=$1
  local prefix=$2
  shift 2

  case $command in
    install|remove|search)
      brew $command $prefix "$@"
      ;;
    update)
      brew upgrade $prefix "$@"
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
  if [ $# -lt 1 ]; then
    echo "Usage: bum <command> [cask_option] <package>"
    return 1
  fi
  
  local command=""
  local cask_option=""

  command=$1
  if [[ $2 == --cask ]]; then
    cask_option=$2
    shift 2
  else
    shift 1
  fi

  if [[ $command == "install" ]]; then
    case $cask_option in
      --cask-only|--no-formula|--no-formulae)
        brew_yum "$command" "--cask" "$@"
        ;;
      --formula-only|--formulae-only|--no-cask)
        brew_yum "$command" "" "$@"
        ;;
      *)
        if [ -z "$cask_option" ]; then
          brew_yum "$command" "" "$@"
        else
          brew_yum "$command" "" "$@"
          brew_yum "$command" "--cask" "$@"
        fi
        ;;
    esac
  else
    brew_yum "$command" "" "$@"
  fi
}

bum "$@"
