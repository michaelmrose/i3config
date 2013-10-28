function vi3_start-vi3
    vi3_define-vars
    vi3_setup-keyboard
    autostart.sh
end

function vi3_define-vars
    set -U vi3_targetMode default # valid values default and command
    set -U vi3_currentDesktop 1
    set -U vi3_lastDesktop 1
    set -U vi3_workspaceOperation # valid values lws sws saw law
end

function vi3_setup-keyboard
    xmodmap ~/.i3/keys
    xcape -e 'Control_L=Page_Down'
    xcape -e 'Super_L=XF86LaunchB'
    xcape -e 'Alt_L=Page_Up'
    xcape -e 'Shift_L=parenleft'
    xcape -e 'Shift_R=parenright'
end

function vi3_workspace
    if test $vi3_currentDesktop = $argv
        vi3_workspace $vi3_lastDesktop
    else
        i3-msg workspace $argv
        set -U vi3_lastDesktop $vi3_currentDesktop
        set -U vi3_currentDesktop $argv
    end
end

function vi3_save-workspace
    i3-msg rename workspace to $argv
    i3-msg workspace $vi3_currentDesktop
end

function vi3_load-workspace
    i3-msg workspace $argv
    i3-msg rename workspace to $vi3_currentDesktop
end


function vi3_target-command
    set -U vi3_targetMode command
end

function vi3_target-default
    set -U vi3_targetMode default
end

function vi3_switch-to-target-mode
    i3-msg mode $vi3_targetMode
end

# short alias to longer commands
alias ws vi3_workspace
alias sws vi3_save-workspace
alias lws vi3_load-workspace
alias saw vi3_save-all-workspaces
alias law vi3_load-all-workspaces
alias perf vi3_perform-operation
alias logout logout
