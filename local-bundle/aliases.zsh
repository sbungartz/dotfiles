# git
alias gsi='git submodule init'
alias gsir='git submodule update --init --recursive'
alias gsu='git submodule update'
alias gsur='git submodule update --recursive'

alias gdc='git diff --cached'

alias glol="git log --graph --pretty=format:'%Cred%h%Creset %G? -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an> %C(bold red)[%GS]%Creset' --abbrev-commit --date=relative"
alias glola="glol --all"

alias glfp='glol --first-parent'

# During a merge, get diffs from merge base to HEAD or MERGE_HEAD
# This helps showing the differences in the two branches in isolation
alias gdmh='gd $(git merge-base MERGE_HEAD HEAD) HEAD'
alias gdmm='gd $(git merge-base MERGE_HEAD HEAD) MERGE_HEAD'

# List files with conflicts
alias glsc='git diff --name-only --diff-filter=U'

# correct htop display in tmux
alias htopx='TERM=screen htop'

# mysql dev
alias mysqlroot='mysql -u root -proot'

# ctags
alias ctagsr='ctags -f .ctags -R --extra=f .docker-dev'

# docker as root
alias socker='sudo -E docker'
alias sop='sudo -E docker-compose'
alias dod='sudo -E docker-compose -f .docker-dev/docker-compose.yml'

# open last capybara screenshot
capshot() { xdg-open tmp/capybara/*.png([${1:--1}]) }

# todo.txt
alias t='todo-txt'
alias tvim='vim ~/.todo-txt/todo.txt'
alias tvd='vim ~/.todo-txt/done.txt'
alias tx='t xp 5'
ta() { t ls @Agenda $@ | grep -e '[^ ]*:' }
twa() { t ls @Warten $@ | grep -e '[^ ]*:' }
alias tw='t ls +Work'
alias tb='t ls @Besorgungen'
alias to='t ls @Office'
alias tm='t ls @mittag'
alias th='t ls @Home'

TODO_CONTEXT_FILE="$HOME/.config/todo-current-context"
# Set and read and clear global todo context
tcs() { echo "$@" > "$TODO_CONTEXT_FILE" }
tcr() { cat "$TODO_CONTEXT_FILE" }
tcc() { rm -f "$TODO_CONTEXT_FILE" }

# Append thought to Inbox
THOUGHT_INBOX="$HOME/Notes/QuickNote.md"
think() { echo -e -n "\n- $@" >> "$THOUGHT_INBOX" }

# List todos for current context
# Either global todo context or via $TODO_CONTEXT
tlsc() {
    t ls ${TODO_CONTEXT:-$(tcr)} $@
}

alias tt='clear; tlsc'

c() { clear && "$@" }

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
