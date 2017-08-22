# git
alias gsi='git submodule init'
alias gsir='git submodule update --init --recursive'
alias gsu='git submodule update'
alias gsur='git submodule update --recursive'

alias gdc='git diff --cached'

alias glol="git log --graph --pretty=format:'%Cred%h%Creset %G? -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an> %C(bold red)[%GS]%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset %G? -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an> %C(bold red)[%GS]%Creset' --abbrev-commit --all"

# correct htop display in tmux
alias htopx='TERM=screen htop'

# mysql dev
alias mysqlroot='mysql -u root -proot'

# ctags
alias ctagsr='ctags -f .ctags -R --extra=+f .'

# docker as root
alias socker='sudo -E docker'
