<p align="center" style="color:grey">

![image](./docs/assets/desktop.png)

<div align="center">
<table>
<tbody>
<td align="center">
<img width="2000" height="0"><br>

These dotfiles are for **[Arch Linux](https://archlinux.org)** based systems and **[Hyprland](https://hyprland.org)** as window manager<br>
If you liked the repo, give a star ⭐ — found a bug? Open an [issue](https://github.com/SNKYNinja/.dotfiles/issues/new)!

![GitHub repo size](https://img.shields.io/github/repo-size/SNKYNinja/.dotfiles)
![GitHub Org's stars](https://img.shields.io/github/stars/SNKYNinja/.dotfiles)
![GitHub forks](https://img.shields.io/github/forks/SNKYNinja/.dotfiles)
![GitHub last commit](https://img.shields.io/github/last-commit/SNKYNinja/.dotfiles)

<img width="2000" height="0">
</td>
</tbody>
</table>
</div>
</p>

### Prerequisites

> [!Note]
> Tools that are required to get the config working.<br>
> You can prefer `-git` version of the packages if something is not working.

##### Required:

```bash
yay -S \
  # Hyprland Packages
  hyprland hyprlock hypridle hyprpicker-git hyprshade xdg-desktop-portal-hyprland \
  # Terminal & Shell Related
  kitty fish starship aurutils eza sesh-bin \
  # Utility Packages
  pipewire dart-sass cliphist grimblast-git jq brightnessctl fastfetch fcitx5 \
  # DE Widgets / UI Tools
  waybar rofi-lbonn-wayland-git mako btop cava pavucontrol swww waypaper wlogout \
  # Theming / Appearance
  catppuccin-gtk-theme-mocha kvantum qt5ct qt6ct nwg-look ttf-jetbrains-mono \
  # File Managers
  yazi nautilus
```

> [!Important]
> Config uses **[SF Pro Font](https://developer.apple.com/fonts/)** mostly so its recommended to install it<br> 
> Put the font in `/usr/share/fonts`

##### Optional

```bash 
yay -S batsignal dua-cli gnome-calendar rofimoji udiskie vimiv zathura
```

### Setup

```bash
git clone https://github.com/SNKYNinja/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x ./install.sh && ./install.sh
```

### [Bibata Cursor](https://github.com/ful1e5/Bibata_Cursor)

Copy the cursor assets from `.icons` to `~/.icons/`

```bash
cp -r ./.icons/Bibata-Modern-Classic/ ~/.icons/

```

> [!Note]
> This is a patched version of the original font for wayland
> You can also use the updated font from there [website](https://github.com/ful1e5/bibata)

### [Zen Browser](https://github.com/zen-browser/desktop)

```bash
flatpak install flathub app.zen_browser.zen
```

#### Mods

- [Floating Status Bar](https://github.com/AmirhBeigi/zen-floating-statusbar/)
- [SuperPins](https://github.com/CosmoCreeper/Zen-Themes/tree/main/SuperPins)
- [Nebula Theme](https://github.com/JustAdumbPrsn/Zen-Nebula)

#### Extensions

- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
- [Refined Github](https://addons.mozilla.org/en-US/firefox/addon/refined-github-/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [Material Icons for Github](https://addons.mozilla.org/en-US/firefox/addon/material-icons-for-github/)
- [Bonjourr Startpage](https://addons.mozilla.org/en-US/firefox/addon/bonjourr-startpage/)
- [Pinterest Save Button](https://addons.mozilla.org/en-US/firefox/addon/pinterest/)
- [Pinterest Dark Mode](https://addons.mozilla.org/en-US/firefox/addon/pinterest-dark-theme/)
- [Keepa Amazon Tracker](https://addons.mozilla.org/en-US/firefox/addon/keepa/)


### Previews

![image](./docs/assets/neovim.png)

| ![image](./docs/assets/wallpaper.png) | ![image](./docs/assets/lockscreen.png) |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |

| ![image](./docs/assets/vscode.png) | ![image](./docs/assets/browser.png) |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |

![image](./docs/assets/spotify.png)

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>

