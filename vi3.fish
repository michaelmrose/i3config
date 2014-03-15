function vi3_start-vi3
    vi3_define-vars
    vi3_setup-keyboard
end

function vi3_define-vars
    set -U vi3_targetMode default # valid values default and command
    set -U vi3_currentDesktop 1
    set -U vi3_lastDesktop 1
    set -U vi3_workspaceOperation # valid values lws sws saw law
end

function vi3_setup-keyboard
    xmodmap ~/.i3/keys
    vi3_setup-xcape
end

function vi3_setup-xcape
    /opt/bin/xcape -e 'Control_L=Page_Down'
    /opt/bin/xcape -e 'Super_L=XF86LaunchB'
    /opt/bin/xcape -e 'Alt_L=Page_Up'
    /opt/bin/xcape -e 'Shift_L=XF86Launch1'
    /opt/bin/xcape -e 'Shift_R=XF86Launch2'
end

function vi3_kill-shift-keys
    killall xcape
    /opt/bin/xcape -e 'Control_L=Page_Down'
    /opt/bin/xcape -e 'Super_L=XF86LaunchB'
    /opt/bin/xcape -e 'Alt_L=Page_Up'
    /opt/bin/xcape -e 'Shift_R=XF86Launch2'
end

function vi3_restore-shift-keys
    /opt/bin/xcape -e 'Shift_L=XF86Launch1'
    /opt/bin/xcape -e 'Shift_R=XF86Launch2'
end

# function vi3_workspace
#     if test $vi3_currentDesktop = $argv
#         vi3_workspace $vi3_lastDesktop
#         #echo "disabled"
#     else
#         i3-msg workspace $argv
#         set -U vi3_lastDesktop $vi3_currentDesktop
#         set -U vi3_currentDesktop $argv
#     end
# end

function vi3_combine-workspaces
    set -U alist $alist $argv[1]
    if test (count $alist) = 2
        vi3_get-workspace $alist[1]
        vi3_get-workspace $alist[2]
        set -e alist
        i3-msg mode "default"
    else
       echo "not yet"
        i3-msg mode "combine workspaces"
    end
end

function vi3_workspace
    i3-msg workspace $argv
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

function vi3_get-workspace
    vi3_workspace $argv 
    echo "moving to " $argv
    vi3_select-all-in-workspace
    echo "focusing parent"
    i3-msg move container to workspace back_and_forth
    i3-msg workspace back_and_forth
end

function vi3_select-all-in-workspace
    i3-msg focus parent
    i3-msg focus parent
    i3-msg focus parent
    i3-msg focus parent
    i3-msg focus parent
end

# short alias to longer commands
alias ws vi3_workspace
alias getws vi3_get-workspace
alias cws vi3_combine-workspaces
alias saw vi3_select-all-in-workspace
