# Headless new machine preparation

Copy a key to a remote machine to never use password again

`ssh-copy-id <path-to-remote-machine>`

### Update remote machine if possible and needed
```bash
sudo apt update
sudo apt upgrade
```

### Install some necessary apps from apt/brew
```bash
sudo apt install neofetch tmux zsh
sudo apt install navi (* optional)
```

### Install some frameworks and whistles from github:
[ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
[powerlevel10k](https://github.com/romkatv/powerlevel10k)
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
[ohmyzsh autoupdate](https://github.com/Pilaton/OhMyZsh-full-autoupdate)
```bash
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
```
[zsh autosuggetion](https://github.com/zsh-users/zsh-autosuggestions)
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
[tmux tpm](https://github.com/tmux-plugins/tpm)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
scp -r ~/.config/nvim pi@192.168.2.48:/home/pi/.config/nvim
```


### Special for a raspberry pi


Homebridge
```bash
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
sudo apt-get update
sudo apt-get install homebridge
```
[NeoVim](https://github.com/neovim/neovim) from source
```bash
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

------------------------------------------------------------------------

### Tmux Plugins:

Tmux plugin manager `tmux-plugins/tpm`

Vim navigation `christoomey/vim-tmux-navigator`

Better mouse in tmux `nhdaly/tmux-better-mouse-mode`

Beautifiers
```
khanghh/tmux-dark-plus-theme
joshmedeski/tmux-nerd-font-window-name
tmux-plugins/tmux-prefix-highlight
```

------------------------------------------------------------------------

### Neovim setup
