# git
alias gsta='git stash push'

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
alias sop='sudo -E docker compose'

# kubectl with named config
kube() {
    config_name="$1"
    shift
    kubectl --kubeconfig "$HOME/.kube/config-$config_name" "$@"
}

# open latest capybara screenshot
capshot() { xdg-open tmp/screenshots/*.png(om[1]) }
capshotold() { xdg-open tmp/capybara/*.png(om[1]) }

# Open vim in Notes folder
alias nv='cd ~/Meins/Notizen && vim'

# todo.txt
alias media='todo-txt -d ~/.todo-txt/config_media'
alias t='TODOTXT_SORT_COMMAND=~/.dotfiles/scripts/todo-txt/filter/sortCommand TODOTXT_FINAL_FILTER=~/.dotfiles/scripts/todo-txt/filter/finalFilter todo-txt $TODOTXT_FLAGS'
alias tcal='TODOTXT_SORT_COMMAND=~/.dotfiles/scripts/todo-txt/filter/showByThresholdDate todo-txt $TODOTXT_FLAGS'
alias tvim='vim ~/.todo-txt/todo.txt'
alias tvd='vim ~/.todo-txt/done.txt'
alias tx='t xp 5'
ta() { t ls @Agenda $@ | grep -e ' [^ ]*: ' | perl -n -e '/(^[0-9]+ )([0-9-]+ |\+Work )*([^:]+)(: .*)$/ && print "$1$2\e[1m\e[94m$3\e[0m$4\n"' }
tap() { t ls @Agenda $@ | perl -n -e '/^[0-9]+ ([0-9-]+ |\+Work )*([^:]+): / && print "$2\n"' | sort -u }
taa() { t a $@ @Agenda }
twa() { t ls @Warten $@ | grep -e ' [^ ]*: ' | perl -n -e '/(^[0-9]+ )([0-9-]+ |\+Work )*([^:]+)(: .*)$/ && print "$1$2\e[1m\e[94m$3\e[0m$4\n"' }
twap() { t ls @Warten $@ | perl -n -e '/^[0-9]+ ([0-9-]+ |\+Work )*([^:]+): / && print "$2\n"' | sort -u }
twaa() { t -t a $@ @Warten }

tp() { twa $@; echo -e '\e[90m-------------------------\e[0m'; ta $@ }
tpp() {
    waiting=$(twap $@)
    agenda=$(tap $@)
    while IFS= read -r person
    do
        if (echo "$waiting" | grep -qx "$person")
        then
            echo -en '\e[94m'
        else
            echo -en '\e[90m'
        fi
        echo -en '\e[0m  '
        if (echo "$agenda" | grep -qx "$person")
        then
            echo -en '\e[94m'
        else
            echo -en '\e[90m'
        fi
        echo -en '\e[0m  '
        echo "$person"
    done < <((echo $waiting && echo $agenda) | sort -u)
}

alias taw='ta +Work'
alias tah='ta -+Work'
alias tapw='tap +Work'
alias taph='tap -+Work'
alias twaw='twa +Work'
alias twah='twa -+Work'
alias twapw='twap +Work'
alias twaph='twap -+Work'
alias tpw='tp +Work'
alias tph='tp -+Work'
alias tppw='tpp +Work'
alias tpph='tpp -+Work'

alias te='t lsp A-B -+Work'
alias ts='t lsp -+Work'
alias tw='t ls +Work'
alias tb='t ls @Besorgungen'
alias to='t ls @Office'
alias th='t ls @Home'

TODO_CONTEXT_FILE="$HOME/.config/todo-current-context"
# Set and read and clear global todo context
tcs() { echo "$@" > "$TODO_CONTEXT_FILE" }
tcr() { cat "$TODO_CONTEXT_FILE" }
tcc() { rm -f "$TODO_CONTEXT_FILE" }

# Append thought to Inbox
THOUGHT_INBOX="$HOME/Meins/Notizen/Inbox/QuickNote.md"
think() { echo -e -n "\n- $@" >> "$THOUGHT_INBOX" }

# List todos for current context
# Either global todo context or via $TODO_CONTEXT
tt() { t ls ${TODO_CONTEXT:-$(tcr)} $@ }
tte() { t lsp A-B ${TODO_CONTEXT:-$(tcr)} $@ }
ttcal() { tcal ls ${TODO_CONTEXT:-$(tcr)} $@ }
tts() { t lsp ${TODO_CONTEXT:-$(tcr)} $@ }
ttp() { t lsp ${TODO_CONTEXT:-$(tcr)} $@ }
tta() { t a $@ ${TODO_CONTEXT:-$(tcr)} }

# List recurring tasks by next scheduled date
trs() { t ice_recur -s | awk '{split($0,a," -- "); printf "%s   %-50s   %s\n", a[3],a[4],a[2]}' | sort }

# Generate and open maybe-matrix
alias mm="xdg-open $HOME/.cache/maybe-matrix.html && ls $HOME/Meins/Notizen/Irgendwann-Vielleicht.md | entr $HOME/.dotfiles/scripts/maybe-matrix"
#
# Frequently used clearmodes
alias cm='clearmode with'
alias cmo='clearmode on'
alias cmoff='clearmode off'
alias cmt='clearmode with tt'
alias cme='clearmode with te'
alias cms='clearmode with ts'
alias cmte='clearmode with tte'
alias cmtcal="clearmode with ttcal"
alias cmtc="clearmode with ttcal"
alias cmts='clearmode with tts'
alias cmtp='clearmode with ttp'
alias cmth='clearmode with th'
alias cmtb='clearmode with tb'
alias cma='clearmode with ta'
alias cmw='clearmode with twa'

tcsb() { tcs @Besorgungen }
tcsd() { tcs @Desk }
tcsh() { tcs @Home }
tcsp() { tcs '@Home\|@Desk' }
tcso() { tcs '@Office' }

# udisksctl mounting and unmounting
function udls {
    udisksctl status
    echo '============================================'
    lsblk | grep -E -v 'loop +/snap'
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
