# Nick's Dotfiles (Arch Linux Rice)

Personal desktop and shell config for my Arch Linux setup.

## Included

- Hyprland: `.config/hypr/`
- Waybar: `.config/waybar/`
- Rofi/Wofi: `.config/rofi/`, `.config/wofi/`
- Notifications: `.config/dunst/`, `.config/mako/`
- i3 + i3blocks scripts: `.config/i3/`
- Fish shell: `.config/fish/`
- Extra UI config: `.config/nwg-look/`
- Home dotfiles: `.bashrc`, `.bash_profile`, `.profile`, `.Xresources`, `.gtkrc-2.0`

## Notes

- `i3/scripts/openweather` and `i3/scripts/openweather-city` use placeholder API values.
- Replace those placeholders with your own OpenWeather key/details if you use them.

## Apply (manual)

From your home directory:

```bash
cp -r .config/* ~/.config/
cp .bashrc .bash_profile .profile .Xresources .gtkrc-2.0 ~/
```
