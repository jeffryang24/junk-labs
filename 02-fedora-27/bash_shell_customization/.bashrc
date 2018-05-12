# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Alias
alias pip-update-force="pip install -U --ignore-installed -r <(pip list --outdated --format=freeze | sed 's/==/>=/')"
alias pip-update="pip install -U -r <(pip list --outdated --format=freeze | sed 's/==/>=/')"
# User specific aliases and functions
export GOPATH=$HOME/go

# added by Anaconda3 installer
export PATH="/home/jeffryangtoni/anaconda3/bin:$PATH"

# added Laravel
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Customize bash shell
orange=$(tput setaf 202);
white=$(tput setaf 231);
yellow=$(tput setaf 228);
lime=$(tput setaf 118);
bold=$(tput bold);
reset=$(tput sgr0);

PS1="\[${bold}\]\n";
PS1+="\[${orange}\]\u";
PS1+="\[${white}\] at ";
PS1+="\[${yellow}\]\h";
PS1+="\[${white}\] in ";
PS1+="\[${lime}\]\w";
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]";
export PS1;
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# added by Anaconda3 installer
export PATH="/home/jeffryangtoni/anaconda3/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/jeffryangtoni/.sdkman"
[[ -s "/home/jeffryangtoni/.sdkman/bin/sdkman-init.sh" ]] && source "/home/jeffryangtoni/.sdkman/bin/sdkman-init.sh"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Force vagrant to use vbox
export VAGRANT_DEFAULT_PROVIDER=virtualbox
