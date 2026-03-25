#!/usr/bin/env bash

# Colors
RED='\x1B[0;31m'
GREEN='\x1B[0;32m'
ORANGE='\x1B[0;33m'
BLUE='\x1B[0;34m'
PURPLE='\x1B[0;35m'
CYAN='\x1B[0;36m'
RED_LIGHT='\x1B[1;30m'

# Bold Colors
RED_BOLD='\x1B[1;31m'
GREEN_BOLD='\x1B[1;32m'
YELLOW_BOLD='\x1B[1;33m'
BLUE_BOLD='\x1B[1;34m'
PURPLE_BOLD='\x1B[1;35m'
CYAN_BOLD='\x1B[1;36m'

NC='\x1B[0m' # No Color

colors() {
  echo "${RED}RED${NC}"
  echo "${GREEN}GREEN${NC}"
  echo "${ORANGE}ORANGE${NC}"
  echo "${BLUE}BLUE${BLUE}"
  echo "${PURPLE}PURPLE${NC}"
  echo "${CYAN}CYAN${NC}"

  echo "${RED_BOLD}RED_BOLD${NC}"
  echo "${GREEN_BOLD}GREEN_BOLD${NC}"
  echo "${YELLOW_BOLD}YELLOW_BOLD${NC}"
  echo "${BLUE_BOLD}BLUE_BOLD${BLUE}"
  echo "${PURPLE_BOLD}PURPLE_BOLD${NC}"
  echo "${CYAN_BOLD}CYAN_BOLD${NC}"
}

DEBUG_T=$CYAN
debug () {
  local text=${DEBUG_T}$1${NC}
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

INFO_T=$PURPLE_BOLD
info () {
  local text=${INFO_T}$1${NC}
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

WARN_T=$YELLOW_BOLD
warn () {
  local text=${WARN_T}$1${NC}
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

SUCCESS_T=$GREEN_BOLD
success () {
  local text=${SUCCESS_T}$1${NC}
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

ERR_T=$RED_BOLD
err () {
  local text=${ERR_T}$1${NC}
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

CODE_T=$PURPLE
code () {
  local text=${CODE_T}$1${NC}
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

plain () {
  local text=$1
  [[ $2 ]] && local pad=$2 || pad=0
  echo_padded "$text" $pad
}

echo_padded () {
  local text=$1
  local padding=$2

  if [[ $padding ]]; then
    case $padding in
    0) echo $text;;
    1) echo "\t$text";;
    2) echo "\t\t$text";;
    3) echo "\t\t\t$text";;
    4) echo "\t\t\t\t$text";;
    *) echo $text;;
    esac
  else
    echo "\t$text"
  fi
}

ln () {
  echo ""
}

check_command() {
    local name=$1
    local command=$2
    local is_err=$3

    echo "Check $name is installed:"
    if ! [ -x "$(command -v $command)" ]; then
        if [[ $is_err ]]; then
            err "> [ERROR]: $name is not found!"
        else 
            warn "> [WARNING]: $name is not found!"
        fi
        exit 1
    else
        success "> [SUCCESS] OK, $name is installed"
        exit 0
    fi
}

check_var() {
    local name=$1
    local var=$2
    local is_err=$3 || false
    
    echo "Check $name is installed:"
    if [ -z $var ]; then
        if [[ $is_err ]]; then
            err "> [ERROR]: $name is not found!"
        else 
            warn "> [WARNING]: $name is not found!"
        fi
        exit 1
    else
        success "> [SUCCESS] OK, $name is installed"
        exit 0
    fi
}

block() {
  local text=$1
  if [[ -z $text ]]; then
    exit 1
  fi

  [[ $2 ]] && local ch=$2 || local ch="="
  [[ $3 ]] && local style=$3 || local style="info"

  local text_len=${#text}
  [[ -z $TERM ]] && local cols=$(tput cols) || local cols=100
  local min_len=$((80 > $cols ? $cols : 80))
  local len=$(($min_len > $text_len ? $min_len : $text_len))

  # x/y = (x+y-1)/y
  # x/2 = (x+1)/2
  local free_space=$(($len-$text_len-2))
  local left_offset_len=$((($free_space+1)/2))
  local right_offset_len=$(($free_space/2))

  if [[ $style ]]; then
    case $style in
    "info") printf $INFO_T;;
    "debug") printf "$DEBUG_T";;
    "warn") printf $WARN_T;;
    "err") printf $ERR_T;;
    "success") printf $SUCCESS_T;;
    *) ;;
    esac
  fi 

  printf '%*s' "$len" | tr ' ' "$ch"
  ln
  printf '%*s' "$(($left_offset_len))" | tr ' ' "$ch"
  printf " $text "
  printf '%*s' "$(($right_offset_len))" | tr ' ' "$ch"
  ln
  printf '%*s' "$len" | tr ' ' "$ch"
  ln
  if [[ $style ]]; then
    printf $NC
  fi
}

separate() {
  local text=$1
  
  [[ $2 ]] && local ch=$2 || local ch="="
  [[ $3 ]] && local style=$3 || local style="info"

  local text_len=${#text}
  
  [[ -z $TERM ]] && local cols=$(tput cols) || local cols=100
  
  local min_len=$((80 > $cols ? $cols : 80))
  local len=$(($min_len > $text_len ? $min_len : $text_len))
  
  if [[ $text ]]; then
    local free_space=$(($len-$text_len-2))
    local display_text=" $text "
  else
    local free_space=$len
    local display_text=""
  fi
  local left_offset_len=$((($free_space+1)/2))
  local right_offset_len=$(($free_space/2))

  if [[ $style ]]; then
    case $style in
    "info") printf $INFO_T;;
    "debug") printf "$DEBUG_T";;
    "warn") printf $WARN_T;;
    "err") printf $ERR_T;;
    "success") printf $SUCCESS_T;;
    *) ;;
    esac
  fi 

  printf '%*s' "$(($left_offset_len))" | tr ' ' "$ch"
  printf "$display_text"
  printf '%*s' "$(($right_offset_len))" | tr ' ' "$ch"
  if [[ $style ]]; then
    printf $NC
  fi
  ln
}
