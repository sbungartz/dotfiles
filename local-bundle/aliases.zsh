# git
alias gsi='git submodule init'
alias gsir='git submodule update --init --recursive'
alias gsu='git submodule update'
alias gsur='git submodule update --recursive'

alias gdc='git diff --cached'

alias glol="git log --graph --pretty=format:'%Cred%h%Creset %G? -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an> %C(bold red)[%GS]%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset %G? -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an> %C(bold red)[%GS]%Creset' --abbrev-commit --all"

alias glfp='glol --first-parent'

# correct htop display in tmux
alias htopx='TERM=screen htop'

# mysql dev
alias mysqlroot='mysql -u root -proot'

# ctags
alias ctagsr='ctags -f .ctags -R --extra=+f .'

# docker as root
alias socker='sudo -E docker'
alias sompose='sudo -E docker-compose'
alias dod='sudo -E docker-compose -f .docker-dev/docker-compose.yml'

# open last capybara screenshot
capshot() { xdg-open tmp/capybara/*.png([${1:--1}]) }

# todo.txt
alias t='todo-txt'
alias tvim='vim ~/.todo-txt/todo.txt'
alias tw='t ls @work'
alias th='t ls @Home'

alias c='clear'

# udisksctl mounting and unmounting
function udls {
    udisksctl status
    echo '============================================'
    lsblk | grep -v 'loop /snap'
}
function udmount {
    udisksctl mount -b "/dev/$1"
}
function udunmount {
    udisksctl unmount -b "/dev/$1"
}
function udoff {
    udisksctl unmount -b "/dev/$1"
    udisksctl power-off -b "/dev/$1"
}
