# ~/.config/fish/config.fish

# If not running interactively, exit
status is-interactive || exit

# Aliases
alias vi="nvim"
alias ls="ls --color=auto"

# PATH additions
fish_add_path ~/bin
fish_add_path ~/.local/bin

# Prompt
function fish_prompt
    # Colors converted to closest fish equivalents
    set_color blue
    printf "%s" (whoami)

    set_color brgreen --bold
    printf " at "

    set_color brcyan
    printf "%s" (hostname)

    set_color brgreen --bold
    printf " in "

    set_color yellow
    printf "%s " (prompt_pwd)

    set_color normal
    set_color -o
    printf "%s" (fish_git_prompt)

    set_color -o bryellow
    printf '$ '

    set_color normal
end

# Custom binding
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function fish_user_key_bindings
    bind ! bind_bang
end


# Disable default greeting
set fish_greeting 

# Toilet banner (runs only in interactive shells)
if status is-interactive
    toilet -f mono9 -F rainbow Edgar
end
