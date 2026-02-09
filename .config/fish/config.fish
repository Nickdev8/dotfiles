if status is-interactive
    # Commands to run in interactive sessions can go here
end

# --- Android SDK (single source of truth) ---
set -gx ANDROID_HOME /home/nick/Android/Sdk
set -e ANDROID_SDK_ROOT

# fnm
fnm env --use-on-cd | source


# Auto-start Hyprland on tty1
#if status is-login
#    if test -z "$WAYLAND_DISPLAY"
#        if test "$XDG_VTNR" = "1"
#            exec Hyprland
#        end
#    end
#end


# --- Java PATH cleanup (Arch Linux) ---
set -l clean_path
for p in $PATH
    if not string match -q "/usr/lib/jvm/*/bin" $p
        set clean_path $clean_path $p
    end
end
set -gx PATH $clean_path
