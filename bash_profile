set -o vi
export PATH=/opt/local/bin:/usr/local/bin:$PATH

### Environment Variables ###
export PATH=/usr/local/bin:$PATH
export MANPATH=`manpath`:/usr/local/man
export EDITOR=vim

# ec2 stuff
if [[ -d $HOME/.ec2 ]]
then
  export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
  export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.3-45758/jars"
  export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.4.4.1/jars"

  export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
  export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
  export EC2FILE=~/.ec2/ec2-keypair
  export AWS_ACCESS_KEY_ID=$(<$HOME/.ec2/.aws_access_key_id)
  export AWS_SECRET_ACCESS_KEY=$(<$HOME/.ec2/.aws_secret_access_key)
  export AWS_SSH_KEY_ID=$(<$HOME/.ec2/.aws_ssh_key_id)

  # chef
  export OPSCODE_USER=$(<$HOME/.ec2/.opscode_user)
  export ORGNAME=$(<$HOME/.ec2/.opscode_orgname)

  if [[ -d $HOME/.ec2/mmx ]]
  then
    function mmxaws() {
      export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/mmx/pk-*.pem)"
      export EC2_CERT="$(/bin/ls $HOME/.ec2/mmx/cert-*.pem)"
      export AWS_ACCESS_KEY_ID=$(<$HOME/.ec2/mmx/.aws_access_key_id)
      export AWS_SECRET_ACCESS_KEY=$(<$HOME/.ec2/mmx/.aws_secret_access_key)
      export AWS_SSH_KEY_ID=$(<$HOME/.ec2/mmx/.aws_ssh_key_id)
      unset AWS_SSH_KEY_ID
    }
  fi

  export PATH=$PATH:$EC2_HOME/bin
fi

### Aliases ###
#general
alias vi='vim'
alias d='vim -c NERDTree'
alias h='clear;cd ~'
alias l='clear; ls -l'
alias ll='clear; ls -l | less'
alias al='clear; ls -al'
alias all='clear; ls -al | less'
alias ltr='clear; ls -ltr'
alias altr='clear; ls -altr'
alias c='clear'
alias u='cd ..'
alias plist='open ~/Library/Preferences/.GlobalPreferences.plist'
alias dfh='clear; df -H'
alias spi='sudo port install'
alias dfh='clear; df -H'
alias r='fc -e -'
alias bp='vi ~/.bash_profile'
alias ar='sudo apachectl restart'
alias gir='grep -ir --binary-files=without-match --exclude="*.log*"'
alias gr='grep -r --binary-files=without-match --exclude="*.log*"'
alias dot='cd ~/.dotfiles'
alias psg='psgrep -a'

#projects
alias localgems="export MMX_GEMS_DIR=$HOME/workspace"
alias w='clear;cd ~/workspace'
alias proj='clear; cd ~/projects'
alias p='clear; cd ~/projects'
alias zap='clear; cd ~/projects/zapidoo'
alias z='zap'
alias 5j='clear; cd ~/projects/html5jive'
alias cof='clear; cd ~/projects/coffee'
alias sam='clear; cd ~/projects/sample_app'
alias w='clear; cd ~/workspace'
alias af='clear; cd ~/workspace/affiliate'
alias mm='clear; cd ~/workspace/affiliate/metromix'
alias ext='clear; cd ~/workspace/affiliate/extrovert'
alias cms='clear; cd ~/workspace/affiliate/cms'
alias exp='clear; cd ~/workspace/express'
alias dm='clear; cd ~/workspace/deals-mgmt'
alias sub='clear; cd ~/workspace/mmx-subdomains'
alias mo='clear; cd ~/workspace/mobile'
alias ci='ssh continuum@ci'

export CATALINA_BASE="$HOME/workspace/solr"
alias solrstart="cd $CATALINA_BASE; bin/solr.sh start; cd -"
alias solrstop="cd $CATALINA_BASE; bin/solr.sh stop 2>/dev/null; cd -"
alias solrfull="solrstop; rm $CATALINA_BASE/indexes/extrovert/data && ln -s $CATALINA_BASE/indexes/extrovert/data_full $CATALINA_BASE/indexes/extrovert/data && solrstart"
alias solrbare="solrstop; rm $CATALINA_BASE/indexes/extrovert/data && ln -s $CATALINA_BASE/indexes/extrovert/data_bare $CATALINA_BASE/indexes/extrovert/data && solrstart"
alias solrinfo="psgrep -a solr; ls -l $CATALINA_BASE/indexes/extrovert"
alias ts="tail -f $CATALINA_BASE/logs/catalina.$(ruby -e 'print Time.now.strftime("%Y-%m-%d")').log"

#git
# Git tab completion
[[ -s ~/.git-completion.bash ]] && source ~/.git-completion.bash
# Show branch in status line
PS1='[\W$(__git_ps1 " (%s)")]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
alias g='git'
alias gb='clear; git branch'
alias gba='clear; git branch -a'
alias gbr='git branch -r'
alias gsb='git show-branch'
alias gst='clear; git status'
alias ga='git add'
alias gaa='git add .'
alias gai='git add -i'
alias gap='git add -p'
alias gd='git diff --color'
alias gds='git diff --color --staged'
alias gdw='git diff --color --word-diff'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gl='git log --decorate'
alias gld='git log --decorate'
alias glp='git log --decorate -p'
alias glo='git log --pretty=oneline --abbrev-commit'
alias gls='git log --pretty=short'
alias glm='git log --pretty=medium'
alias glf='git log --pretty=fuller'
alias gs='git stash'
alias gsl='git stash list'
alias gss='git stash show'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gpu='git push'
alias gpom='git pull origin master'
alias gf='git fetch'

#ruby
alias gi='gem install --no-rdoc --no-ri'
alias gu='gem uninstall'
alias rc='rdebug -c'

#bundler
alias be='bundle exec'

#rails
alias sc='clear;script/console'
alias sg='clear;script/generate'
alias rrg='clear;rake routes | grep'
alias td='clear;tail -f log/development.log'

#autotest
alias at='unset AUTOFEATURE;clear;autotest'
alias atf='export AUTOFEATURE=true;clear;autotest'

#rspec
alias sp='clear; bundle exec spec --color --format nested'
alias as='clear; export AUTOFEATURE=false; autospec'
alias asf='clear; export AUTOFEATURE=true; autospec'

#cucumber
alias cu='clear; bundle exec cucumber'
alias cuf='clear; bundle exec cucumber -r features'

#celerity
export JRUBY_INVOCATION="$(readlink "$(which celerity_jruby)")"

#subversion
alias sup='clear; svn update'
alias sst='clear; svn status'

#postgres
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

#node
export NODE_PATH='/usr/local/lib/node:/usr/local/lib/node_modules'

# RVM stuff
alias r186='rvm use 1.8.6'
alias r187='rvm use 1.8.7'
alias r192='rvm use 1.9.2'
alias r193='rvm use 1.9.3'
alias r186m='rvm use 1.8.6@metromix'
alias r187m='rvm use 1.8.7@metromix'
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Add the following to your ~/.bashrc or ~/.zshrc
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'
# Uncomment to persist pair info between terminal instances
hitch
