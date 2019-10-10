#!/usr/bin/env zsh

function append_date() { 
  # Prepend "info" to the command line and run it.
  BUFFER="$BUFFER-$(date '+%Y-%m-%d')"
  zle end-of-line
}

# Define a widget called "run_info", mapped to our function above.
zle -N append_date

# Bind it to ESC-i.
#bindkey "" append_date
