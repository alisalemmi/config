<div dir='rtl'>

# &rlm;zsh

</div>

```sh
sudo apt install zsh
```

<div dir='rtl'>

## &rlm;oh-my-zsh

</div>

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

<div dir='rtl'>

## تنظیمات پیشنهادی

فایل
<span dir='ltr'>[.zshrc](/shell/zsh/.zshrc)</span>
را در پوشه home کپی کنید.

### افزونه ها

</div>

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

<div dir='rtl'>

### قالب

</div>

```sh
curl https://raw.githubusercontent.com/alisalemmi/config/master/shell/zsh/alisalemmi.zsh-theme -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/alisalemmi.zsh-theme
```

<div dir='rtl'>

## تنظیم به عنوان shell پیش فرض برای کاربران جدید

1. دستورات بالا را از طریق `root` انجام دهید
2. پوشه <span dir='ltr'>`.oh-my-zsh`</span> و فایل <span dir='ltr'>`.zshrc`</span> را در <span dir='ltr'>`/etc/skel`</span> کپی کنید
3. در فایل <span dir='ltr'>`/etc/default/useradd`</span> عبارت `SHELL=/bin/zsh` را قرار دهید
4. در فایل <span dir='ltr'>`/etc/adduser.conf`</span> عبارت `DSHELL=/bin/zsh` را قرار دهید
</div>
