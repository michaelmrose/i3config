#vi3.fish provides helper functions to provide vi like keybindings for the i3 window manager

function vi3_start-vi3
    vi3_define-vars
    vi3_setup-keyboard
end

function vi3_define-vars
    set -U vi3_targetMode default # valid values default and command
    set -U vi3_currentDesktop 1
    set -U vi3_lastDesktop 1
    set -U vi3_workspaceOperation # valid values lws sws saw law
    set -U vi3_currentmode default
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

function vi3_layout_windows
    xdotool mousemove 1890 0
    i3-msg move down
    xdotool mousemove 0 0
    i3-msg move left
end

function vi3_rotate_windows
    xdotool mousemove 0 0
    i3-msg move down
    sleep 0.3
    xdotool mousemove 0 540
    i3-msg move left
    sleep 0.3
    xdotool mousemove 1890 0
    i3-msg move down
    xdotool mousemove 0 0
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
    set -U combolist $combolist $argv[1]
    if test (count $combolist) = 2
        vi3_get-workspace $combolist[1]
        vi3_get-workspace $combolist[2]
        set -e combolist
        i3-msg mode "default"
    else
       echo "not yet"
    end
end

function vi3_rearrange-workspaces
    set -U relist $relist $argv[1]
    if test (count $relist) = 2
        set -l myworkspace (getCurrentWorkspace) 
        vi3_workspace $relist[2]
        vi3_get-workspace $relist[1]
        vi3_workspace $myworkspace 
        set -e relist
        i3-msg mode "default"
    else
       echo "not yet"
       #i3-msg mode "rearrange workspaces"
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

function vi3_mode
    set nextmode $argv
    set endfunc {$vi3_currentmode}leave
    set enterfunc {$nextmode}enter
    eval $endfunc
    i3-msg mode $nextmode
    set -U vi3_currentmode $argv
    eval $enterfunc
end

function defaultleave
    notify-send "leaving default mode"
end

function defaultenter
    notify-send "entering default mode"
end

function commandenter
    notify-send "entering command mode"
end

function commandleave
    notify-send "leaving command mode"
end
# short alias to longer commands
