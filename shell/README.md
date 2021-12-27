# shell

## zsh

```sh
sudo apt install zsh
```

## oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## template

To have some greet plugins and beautiful theme use
[.zshrc](/shell/zsh/.zshrc)
config file and run bellow commands for installing them.

### plugins

```sh
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-dircolors-solarized
git clone --recursive https://github.com/joel-porquet/zsh-dircolors-solarized ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-dircolors-solarized

# zsh-better-npm-completion
git clone https://github.com/lukechilds/zsh-better-npm-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-better-npm-completion
```

### theme

```sh
curl https://raw.githubusercontent.com/alisalemmi/config/master/shell/zsh/alisalemmi.zsh-theme -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/alisalemmi.zsh-theme
```

## install system wide

1. do above steps as `root`
2. copy `.oh-my-zsh` and `.zshrc` to `/etc/skel`
3. set `SHELL=/bin/zsh` in `/etc/default/useradd`
4. set `DSHELL=/bin/zsh` in `/etc/adduser.conf`
