CURRENT_BG='NONE'
CURRENT_FG='white'

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"

  SEGMENT_SEPARATOR=$'\ue0b0'
  SEPARATOR=$'\ue0b1'
  CHIP_LEFT=$'\ue0b6'
  CHIP_RIGHT=$'\ue0b4'

  ICON_PROMPT=$'\u276f'
  ICON_HOME=$'\uf7db'
  ICON_PC=$'\uf108 '
  ICON_BRANCH=$'\ue0a0'
  ICON_CLOCK=$'\uf64f'
  ICON_TIMER=$'\uf608'
}

# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
function prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  if [[ $CURRENT_BG == 'NONE' && $1 != 'black' ]]; then
    echo -n "%{$bg%F{$black}%}$SEGMENT_SEPARATOR%{$fg%} "
  elif [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

function prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

function prompt_chip() {
  echo -n " %{%F{$1}%k%}$CHIP_LEFT%{%F{$2}%K{$1}%}$3%{%F{$1}%k%}$CHIP_RIGHT%{%k%f%}"
}

## Util functions
function prompt-length() {
  emulate -L zsh
  local -i x y=${#1} m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ))
    done
    while (( y > x + 1 )); do
      (( m = x + (y - x) / 2 ))
      (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
    done
  fi
  echo $x
}

function fill-line() {
  local left_len=$(prompt-length $1)
  local right_len=$(prompt-length $2)
  local pad_len=$((COLUMNS - left_len - right_len - 1))
  local pad=${(pl.$pad_len.. .)}  # pad_len spaces
  echo ${1}${pad}${2}
}

### Prompt components
function prompt_status() {
  local -a symbols

  [[ -n $SSH_CONNECTION ]] && symbols+="%{%F{yellow}%}力"
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

function prompt_user() {
  prompt_segment 'white' 'black' "$USER $SEPARATOR $HOST"
}

function prompt_dir() {
  dir=`pwd`
  
  # home
  if [[ $dir == "/home/$USER"* ]];
  then
    dir=`echo $dir | sed "s/^\/home\/$USER/$ICON_HOME/"`

  # wsl drive
  elif [[ $dir == '/mnt/'* ]];
  then
    dir=`echo $dir | sed 's/^\/mnt\///' | sed 's/\//:\//'`
    dir="$(tr '[:lower:]' '[:upper:]' <<< ${dir:0:1})${dir:1}"
    [[ -z ${dir:1} ]] && dir+=':'

  # linux drive
  elif [[ $dir == "/media/$USER"* ]];
  then
    dir=`echo $dir | sed "s/^\/media\/$USER\///" | sed 's/\//:\//'`
    [[ `grep ':' -iq <<< $dir; echo $?` -ne 0 ]] && dir+=':'

  # root
  elif [[ $dir == '/' ]];
  then
    dir="$ICON_PC"

  # root subdir
  else
    dir=`echo $dir | sed 's/^\//$ICON_PC\//'`
  fi

  dir=`echo $dir | sed "s/\// $SEPARATOR /g"`

  prompt_segment 'blue' 'black' "$dir"
}

function prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi

  local ref dirty mode repo_path

   if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '±'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//$ICON_BRANCH }${vcs_info_msg_0_%% }${mode}"
  fi
}

function prompt_time() {
  prompt_chip '#424242' 'magenta' "$ICON_CLOCK `date +'%H:%M:%S'` "
}

function prompt_execution_time() {
  if [[ -z $elapsed ]];
  then
    elapsed=0
  fi

  ((ms = $elapsed % 1000))
  ((elapsed /= 1000))
  ((s = $elapsed % 60))
  ((elapsed /= 60))
  ((m = $elapsed % 60))
  ((elapsed /= 60))
  ((h = $elapsed % 24))
  ((d = elapsed / 24))

  elapsed=''
  [[ d -ne 0 ]] && elapsed+="${d}d "
  [[ h -ne 0 || -n $elapsed ]] && elapsed+="${h}h "
  [[ m -ne 0 || -n $elapsed ]] && elapsed+="${m}m "

  if [[ -z $elapsed && $s -eq 0 ]]; then 
    elapsed+="${ms}ms"
  elif [[ $ms -eq 0 ]]; then
    elapsed+="${s}s"
  else
    fms=`printf '%03d' $ms | sed 's/0*$//'`
    elapsed+="${s}.${fms}s"
  fi

  prompt_chip '#424242' '#76ff03' "$ICON_TIMER ${elapsed} "
}

function prompt_battery() {
  wsl=`cat /proc/version | grep 'microsoft' -iq; echo $?`

  [[ $wsl -eq 0 ]] && battery_dir=/sys/class/power_supply/battery || battery_dir=/sys/class/power_supply/BAT0

  [[ ! -d $battery_dir || `cat $battery_dir/present` -ne 1 ]] && return

  percent=`cat $battery_dir/capacity`
  stat=`cat $battery_dir/status`
  icons=(          )

  case $stat in
    Full)
      icon=''
      color='#4caf50'
      ;;

    'Not charging')
      icon=''
      color='#4caf50'
      ;;

    Charging)
      icon=''
      color='#40c4ff'
      ;;

    Discharging)
      icon=$icons[((percent / 10 + 1))]
      [[ $percent -gt 20 ]] && color='#40c4ff' || color='#ff5722'
      ;;

    *)
      icon=''
      color='#fbff22'
      ;;

  esac

  prompt_chip '#424242' $color "$icon $percent"
}

function build_top_left() {
  prompt_user
  prompt_status
  prompt_dir
  prompt_git
  prompt_end
}

function build_top_right() {
  prompt_execution_time
  prompt_time
  prompt_battery
}

function build_bottom_left() {
  echo -n "%{%F{magenta}%}$ICON_PROMPT%{%F{reset}%} "
}

function build() {
  local top_left=$(build_top_left)
  local top_right=$(build_top_right)
  local bottom_left=$(build_bottom_left)

  [[ $not_first -eq 1 ]] && echo ""
  not_first=1

  PROMPT="%{%f%b%k%}$(fill-line "$top_left" "$top_right")"$'\n'$bottom_left
}

## Hooks
autoload -Uz vcs_info

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    unset timer
  else
    elapsed=0
  fi

  build
}
