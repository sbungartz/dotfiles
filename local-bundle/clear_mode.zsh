CLEAR_MODE_ENABLED=false

function clearmode {
  case "$1" in
    on)
      CLEAR_MODE_ENABLED=true
      preexec "$0 $*"
      unset CLEAR_MODE_COMMAND
      echo "Clearmode enabled"
      ;;
    off)
      CLEAR_MODE_ENABLED=false
      unset CLEAR_MODE_COMMAND
      echo "Clearmode disabled"
      ;;
    with)
      CLEAR_MODE_ENABLED=true
      preexec "$0 $*"
      shift;
      CLEAR_MODE_COMMAND=$@
      echo "Clearmode enabled. Running $CLEAR_MODE_COMMAND as default screen"
      ;;
    *)
      echo "Usage: '$0 [on, off, with <command>]'"
      return 1
  esac 
}

function precmd {
  if $CLEAR_MODE_ENABLED
  then
    if  [ ! -z "$CLEAR_MODE_COMMAND" ]
    then
      print -Pn "$PROMPT$CLEAR_MODE_COMMAND\n" | sed 's/32m➜/36m➜/'
      eval $CLEAR_MODE_COMMAND
    fi
  fi
}

function preexec {
  if $CLEAR_MODE_ENABLED
  then
    clear
    print -Pn "$PROMPT" | sed 's/32m➜/34m➜/'
    echo "$1"
  fi
}
