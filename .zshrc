# Pure
fpath=($fpath /Users/Tim/pure-theme)
autoload prompt_pure_setup
autoload async
autoload -U promptinit; promptinit
prompt pure
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL='%~ >'
PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] '$PROMPT
