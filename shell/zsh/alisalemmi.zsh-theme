local LC_ALL="" LC_CTYPE="en_US.UTF-8"

SEGMENT_SEPARATOR=$'\ue0b0'
SEPARATOR=$'\ue0b1'
CHIP_LEFT=$'\ue0b6'
CHIP_RIGHT=$'\ue0b4'

ICON_PROMPT=$'\u276f'

ICON_HOME=$'\uf015 '
ICON_PC=$'\uf26c '
ICON_DOTS=$'\uf6d7'

ICON_BRANCH=$'\ue0a0'

ICON_SETTING=$'\uf013 '
ICON_FAIL=$'\uf00d'
ICON_ROOT=$'\uf0e7'
ICON_CLOUD=$'\uf0c2 '

ICON_TIMER=$'\uf608'
ICON_CLOCK=$'\uf017'

# rendering functions
function prompt_segment() {
  local bg fg
  [[ -n $2 ]] && bg="%K{$2}" || bg="%k"
  [[ -n $3 ]] && fg="%F{$3}" || fg="%f"

  if [[ $1 == 'NONE' && $2 != 'black' ]]; then
    echo -n "%{$bg%F{$black}%}$SEGMENT_SEPARATOR%{$fg%} "
  elif [[ $1 != 'NONE' && $2 != $1 ]]; then
    echo -n " %{$bg%F{$1}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  [[ -n $4 ]] && echo -n $4
}

function prompt_end() {
  if [[ -n $1 ]]; then
    echo -n " %{%k%F{$1}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
}

function prompt_chip() {
  echo -n " %{%F{$1}%k%}$CHIP_LEFT%{%F{$2}%K{$1}%}$3%{%F{$1}%k%}$CHIP_RIGHT%{%k%f%}"
}

# Util functions
function prompt_length() {
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
  local left_len=`prompt_length $1`
  local right_len=`prompt_length $2`
  local pad_len=$((COLUMNS - left_len - right_len ))
  local pad=${(pl.$pad_len.. .)}  # pad_len spaces
  echo ${1}${pad}${2}
}

# get components
# top left
function prompt_user() {
  prompt_segment 'NONE' 'white' 'black' "`whoami`@`hostname`"
}

function prompt_dir() {
  dir=`python3 <<- EOF
	import re

	user = '$(whoami)'
	dir = '$(pwd)/'

	# home
	if dir.startswith(f'/home/{user}/'):
	  dir = dir.replace(f'/home/{user}/', '$ICON_HOME/', 1)

	# wsl drive
	elif dir.startswith('/mnt/'):
	  drive, path = dir.replace('/mnt/', '', 1).split('/', 1)

	  if drive == 'c':
	    path = re.sub('^Users/[^/]+/', '$ICON_HOME/', path)

	  dir = f'{drive.capitalize()}:/{path}'

	# linux drive
	elif dir.startswith(f'/media/{user}/'):
	  dir = dir.replace(f'/media/{user}/', '', 1).replace('/', ':/', 1)

	# root
	else:
	  dir = f'$ICON_PC{dir}'

	# prevent long nested path overflow line
	root, *paths = dir.rstrip('/').split('/')
	dir = ''

	availableWidth = $AVAILABLE_WIDTH - (len(root) + 3)
	while len(paths) != 0 and len(paths[-1]) + 6 < availableWidth:
	  availableWidth -= len(paths[-1]) + 3
	  dir = f'{paths.pop()}/{dir}'

	if len(paths) != 0:
	  root += '/$ICON_DOTS'

	dir = f'{root}/{dir}'.rstrip('/').replace('/', ' $SEPARATOR ')
	print(dir)
	EOF
	`

  prompt_segment 'white' 'blue' 'black' "$dir"
}

function prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi

  local ref dirty mode repo_path color

  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      color=yellow
    else
      color=green
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
    prompt_segment 'blue' "$color" 'black' "${ref/refs\/heads\//$ICON_BRANCH }${vcs_info_msg_0_%% }${mode}"
    prompt_end "$color"
  fi
}

# top right
function prompt_flags() {
  local -a symbols

  [[ `jobs -l | wc -l` -gt 0 ]] && symbols+="%{%F{white}%}$ICON_SETTING"
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$ICON_FAIL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$ICON_ROOT"
  [[ `pstree -p | grep -e "sshd.*$PPID"` ]] && symbols+="%{%F{cyan}%}$ICON_CLOUD"

  echo "$symbols"
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

  prompt_chip '#424242' '#76ff03' "$ICON_TIMER ${elapsed}"
}

function prompt_time() {
  prompt_chip '#424242' 'magenta' "$ICON_CLOCK `date +'%H:%M:%S'`"
}

function prompt_battery() {
  battery_dir=`find /sys/class/power_supply -maxdepth 1 -iname 'bat*' | head -n 1`
  
  [[ ! -d $battery_dir || `cat $battery_dir/present` -ne 1 ]] && return

  percent=`cat $battery_dir/capacity`
  stat=`cat $battery_dir/status`
  icons=('\uf58d' '\uf579' '\uf57a' '\uf57b' '\uf57c' '\uf57d' '\uf57e' '\uf57f' '\uf580' '\uf581' '\uf578')

  case $stat in
    Full)
      icon=$icons[11]
      color='green'
      ;;

    'Not charging')
      icon='\uf58e'
      color='green'
      ;;

    Charging)
      icon='\uf583'
      color='cyan'
      ;;

    Discharging)
      icon=$icons[((percent / 10 + 1))]
      [[ $percent -gt 20 ]] && color='cyan' || color='red'
      ;;

    *)
      icon='\uf590'
      color='yellow'
      ;;

  esac

  prompt_chip '#424242' $color "$icon $percent"
}

# build
function build_top_left() {
  local user=`prompt_user`
  local git=`prompt_git`

  (( AVAILABLE_WIDTH = AVAILABLE_WIDTH - `prompt_length "$user$git"` - 8 ))
  local dir=`prompt_dir`

  echo -n "$user""$dir""$git"`[[ -n $git ]] || prompt_end blue`
}

function build_top_right() {
  local flags=`prompt_flags`
  local execution_time=`prompt_execution_time`
  local time=`prompt_time`
  local battery=`prompt_battery`

  echo -n "$flags""$execution_time""$time""$battery"
}

function build_bottom_left() {
  echo -n "%{%F{magenta}%}$ICON_PROMPT%{%F{reset}%} "
}

function build() {
  local top_right=`build_top_right`
  (( AVAILABLE_WIDTH = AVAILABLE_WIDTH - `prompt_length "$top_right"` ))

  local top_left=`build_top_left`
  local bottom_left=`build_bottom_left`

  [[ $not_first -eq 1 ]] && echo ""
  not_first=1

  PROMPT="%{%f%b%k%}`fill-line "$top_left" "$top_right"`"$'\n'$bottom_left
}

## Hooks
autoload -Uz vcs_info

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  RETVAL=$?
  AVAILABLE_WIDTH=`tput cols`

  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    unset timer
  else
    elapsed=0
  fi

  build
}
