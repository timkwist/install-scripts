# install-scripts

What to install:

* Rectangle (https://rectangleapp.com/)
* Sublime Text (https://www.sublimetext.com/)
* iTerm (https://www.iterm2.com/)
* Slack (https://slack.com/)
* Homebrew (https://brew.sh/)


From: https://gist.github.com/ganapativs/e571d9287cb74121d41bfe75a0c864d7

- Install iTerm2 from https://www.iterm2.com/
- Install oh-my-zsh from https://ohmyz.sh/ or https://github.com/robbyrussell/oh-my-zsh
- Set iTerm2 theme tab theme to Dark - `Preferences | Appearance | Tabs | Theme > Dark`
- Install Fira Code fonts from https://github.com/tonsky/FiraCode (Clone and navigate to `dstr > ttf`, install all font files by double clicking)
- Install Powerline fonts from https://github.com/powerline/fonts
- Set fonts for iTerm2 - `Preferences | Profiles | Text`
     - Change `Font` to `14pt Fira code regular` and Check `Use Ligatures` checkbox
     - Change `Non ASCII Font` to `14pt Fira mono` and Check `Use Ligatures` checkbox
- Install iTerm2 snazzy theme from https://github.com/sindresorhus/iterm2-snazzy
     - Navigate to `Preferences | Profiles | Color Presets > Snazzy`
- Install Pure prompt for iTerm2 from https://github.com/sindresorhus/pure#oh-my-zsh
```sh
# .zshrc
ZSH_THEME=""

npm install --global pure-prompt

# oh-my-zsh overrides the prompt, so Pure must be activated after `source $ZSH/oh-my-zsh.sh`
# .zshrc
autoload -U promptinit; promptinit
prompt pure
```
- Install awesome `z` tool for autojumping between recent folders(Check usage here - https://github.com/rupa/z/)
     - Use brew `brew install z` (This should take care of everything for you)
     - Or to setup manually, Download 'z' from https://github.com/rupa/z/blob/master/z.sh and move to `~/` and add following snippet to `~/.zshrc`
```sh
# .zshrc
# include Z, yo
. ~/z.sh
```
- Install `zsh-syntax-highlighting` oh-my-zsh plugin
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
- Install `zsh-autosuggestions` oh-my-zsh plugin
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```
- Install `pygments` package, a pre-requisite for `colorize` plugin(`cat` with syntax highlight support, alias `ccat`)
```sh
pip install pygments

# OR
pip3.6 install pygments
```
- Install `trash` command as safter alternative for `rm` command
```sh
npm install --global trash-cli

trash ./folder/file.txt # Should move to trash instead of permanently deleting it
```
- Finally update plugins list for oh-my-zsh in `~/.zshrc`
```sh
# .zshrc
plugins=(
  git
  brew
  common-aliases
  node
  npm
  rand-quote
  sudo
  yarn
  z
  colored-man-pages
  colorize
  cp
  zsh-syntax-highlighting
  zsh-autosuggestions
  timer
)
```

**Screenshot**

<img width="1536" alt="Screenshot 2021-03-01 at 5 36 16 PM" src="https://user-images.githubusercontent.com/4010960/109494977-a2dc9880-7ab4-11eb-884c-960890c381eb.png">

**Bonus**

Try https://starship.rs/ or https://github.com/denysdovhan/spaceship-prompt

Useful links:
- https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview
- https://commandlinepoweruser.com/
- https://medium.freecodecamp.org/jazz-up-your-zsh-terminal-in-seven-steps-a-visual-guide-e81a8fd59a38
- https://hackernoon.com/oh-my-zsh-made-for-cli-lovers-bea538d42ec1
- https://www.smashingmagazine.com/2015/07/become-command-line-power-user-oh-my-zsh-z/
