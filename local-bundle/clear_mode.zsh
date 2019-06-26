CLEAR_MODE_ENABLED=false

function clearmode {
  case "$1" in
    on)
      CLEAR_MODE_ENABLED=true
      echo "Clearmode enabled"
      ;;
    off)
      CLEAR_MODE_ENABLED=false
      echo "Clearmode disabled"
      ;;
    *)
      echo "Usage: '$0 [on, off]'"
      return 1
  esac 
}

function preexec {
  if $CLEAR_MODE_ENABLED
  then
    clear
    print -Pn "$PROMPT" | sed 's/32m➜/34m➜/'
    echo "$1"
  fi
}
