# FreeAgent puts the powerline style in zsh !

if [[ -z "$POWERLINE_DATE_FORMAT" ]]; then
  POWERLINE_DATE_FORMAT="%D{%Y-%m-%d}"
fi

if [[ -z "$POWERLINE_RIGHT_B" ]]; then
  POWERLINE_RIGHT_B="%D{%H:%M:%S}"
fi

if [[ "$POWERLINE_RIGHT_A" == "mixed" ]]; then
  POWERLINE_RIGHT_A=%(?."$POWERLINE_DATE_FORMAT".%F{red}✘ %?)
elif [[ "$POWERLINE_RIGHT_A" == "exit-status" ]]; then
  POWERLINE_RIGHT_A=%(?.%F{green}✔ %?.%F{red}✘ %?)
elif [[ "$POWERLINE_RIGHT_A" == "date" ]]; then
  POWERLINE_RIGHT_A="$POWERLINE_DATE_FORMAT"
fi

if [[ "$POWERLINE_HIDE_USER_NAME" != "true" ]] && [[ "$POWERLINE_HIDE_HOST_NAME" != "true" ]]; then
    POWERLINE_USER_NAME="%n@%M"
elif [[ "$POWERLINE_HIDE_USER_NAME" == "true" ]] && [[ "$POWERLINE_HIDE_HOST_NAME" != "true" ]]; then
    POWERLINE_USER_NAME="@%M"
elif [[ "$POWERLINE_HIDE_USER_NAME" != "true" ]] && [[ "$POWERLINE_HIDE_HOST_NAME" == "true" ]]; then
    POWERLINE_USER_NAME="%n"
fi

POWERLINE_CURRENT_PATH="%d"

if [[ -z "$POWERLINE_FULL_CURRENT_PATH" ]]; then
  POWERLINE_CURRENT_PATH="%1~"
fi

if [[ -z "$POWERLINE_GIT_CLEAN" ]]; then
  POWERLINE_GIT_CLEAN="✔"
fi

if [[ -z "$POWERLINE_GIT_DIRTY" ]]; then
  POWERLINE_GIT_DIRTY="✘"
fi

if [[ -z "$POWERLINE_GIT_ADDED" ]]; then
  POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
fi

if [[ -z "$POWERLINE_GIT_MODIFIED" ]]; then
  POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
fi

if [[ -z "$POWERLINE_GIT_DELETED" ]]; then
  POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
fi

if [[ -z "$POWERLINE_GIT_UNTRACKED" ]]; then
  POWERLINE_GIT_UNTRACKED="%F{yellow}✭%F{black}"
fi

if [[ -z "$POWERLINE_GIT_RENAMED" ]]; then
  POWERLINE_GIT_RENAMED="➜"
fi

if [[ -z "$POWERLINE_GIT_UNMERGED" ]]; then
  POWERLINE_GIT_UNMERGED="═"
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" \ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" $POWERLINE_GIT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN=" $POWERLINE_GIT_CLEAN"

ZSH_THEME_GIT_PROMPT_ADDED=" $POWERLINE_GIT_ADDED"
ZSH_THEME_GIT_PROMPT_MODIFIED=" $POWERLINE_GIT_MODIFIED"
ZSH_THEME_GIT_PROMPT_DELETED=" $POWERLINE_GIT_DELETED"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" $POWERLINE_GIT_UNTRACKED"
ZSH_THEME_GIT_PROMPT_RENAMED=" $POWERLINE_GIT_RENAMED"
ZSH_THEME_GIT_PROMPT_UNMERGED=" $POWERLINE_GIT_UNMERGED"
ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"

# if [[ "$(git_prompt_info)" = "" ]]; then
#   POWERLINE_GIT_INFO_LEFT=""
#   POWERLINE_GIT_INFO_RIGHT=""
# else
  if [[ "$POWERLINE_SHOW_GIT_ON_RIGHT" != "true" ]]; then
    if [[ "$POWERLINE_HIDE_GIT_PROMPT_STATUS" != "true" ]]; then
      POWERLINE_GIT_INFO_LEFT=" %F{blue}%K{white}"$'\ue0b0'"%F{white}%F{black}%K{white}"$'$(git_prompt_info)$(git_prompt_status)%F{white}'
    else
      POWERLINE_GIT_INFO_LEFT=" %F{blue}%K{white}"$'\ue0b0'"%F{white}%F{black}%K{white}"$'$(git_prompt_info)%F{white}'
    fi
    POWERLINE_GIT_INFO_RIGHT=""
  else
    POWERLINE_GIT_INFO_LEFT=""
    POWERLINE_GIT_INFO_RIGHT="%F{white}"$'\ue0b2'"%F{black}%K{white}"$'$(git_prompt_info)'" %K{white}"
  fi
# fi

POWERLINE_SEC1_BG=%K{green}
POWERLINE_SEC1_FG=%F{green}
POWERLINE_SEC1_TXT=%F{black}

if [[ $(id -u) -eq 0 ]]; then
  POWERLINE_SEC1_BG=%K{red}
  POWERLINE_SEC1_FG=%F{red}
fi

if [[ "$POWERLINE_DETECT_SSH" == "true" ]]; then
  if [[ -n "$SSH_CLIENT" ]]; then
    POWERLINE_SEC1_BG=%K{red}
    POWERLINE_SEC1_FG=%F{red}
    POWERLINE_SEC1_TXT=%F{white}
  fi
fi

# Left prompt
PROMPT=""

if [[ -n $POWERLINE_USER_NAME ]]; then
  PROMPT="$PROMPT$POWERLINE_SEC1_BG$POWERLINE_SEC1_TXT $POWERLINE_USER_NAME %k%f$POWERLINE_SEC1_FG%K{blue}"$'\ue0b0'
fi

PROMPT="$PROMPT%K{blue}%F{white} $POWERLINE_CURRENT_PATH"

if [[ -n $POWERLINE_GIT_INFO_LEFT ]]; then
  PROMPT="$PROMPT%k%F{blue}$POWERLINE_GIT_INFO_LEFT %k"$'\ue0b0'
else
  PROMPT="$PROMPT %k%F{blue}"$'\ue0b0'
fi

PROMPT="$PROMPT%k%f "

if [[ "$POWERLINE_NO_BLANK_LINE" != "true" ]]; then
  PROMPT="
"$PROMPT
fi


# Right prompt
if [[ "$POWERLINE_DISABLE_RPROMPT" != "true" ]]; then
    if [[ -z "$POWERLINE_RIGHT_A" ]]; then
        RPROMPT="$POWERLINE_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{black}%K{white} $POWERLINE_RIGHT_B %f%k"
    else
        RPROMPT="$POWERLINE_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{black}%K{white} $POWERLINE_RIGHT_B %f%F{240}"$'\ue0b2'"%f%k%K{240}%F{255} $POWERLINE_RIGHT_A %f%k"
    fi
fi
