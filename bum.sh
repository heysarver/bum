#!/bin/bash

bum () {
  case $1 in

  help)
    echo "Help Messages"
    ;;
  
  update)
    case $2 in

    $3)
      brew upgrade $3
      ;;
    
    *)
      brew upgrade
      ;;
    esac
    ;;

  list)
    case $2 in

    installed)
      brew list
      ;;
    
    *)
      echo "unknown"
      ;;
    esac
    ;;
  
  install)
    # This should be better
    brew install --cask $2
    brew install $2
    ;;
  
  reinstall)
    # This should be better
    brew reinstall --cask $2
    brew reinstall $2
    ;;
  
  search)
    brew search $2
    ;;

  *)
    echo -n "unknown"
    ;;
esac
}

bum $@
