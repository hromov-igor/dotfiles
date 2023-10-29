# Headless new machine preparation

Copy a key to a remote machine to never use password

`ssh-copy-id <path-to-remote-machine>`

Update remote machine if possible and needed
```bash
sudo apt update
sudo apt upgrade
```

Install some necessary apps from apt/brew
```bash
sudo apt install neofetch tmux zsh

sudo apt install navi (* optional)
```

Install some frameworks and whistles from github
```
ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

ohmyzsh autoupdate
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate

zsh autosuggetion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
scp -r ~/.config/nvim pi@192.168.2.48:/home/pi/.config/nvim
```


Special for a raspberry pi

```
homebridge
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
sudo apt-get update
sudo apt-get install homebridge

nvim from source
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```
