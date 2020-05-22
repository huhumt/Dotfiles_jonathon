# This makes zsh automatically escape certain characters when typing a url
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# This does the same for pasting a url
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
