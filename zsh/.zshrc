##           ##
## CONSTANTS ##
##           ##

# Shortcut for xmonad.hs
XMO=$HOME/.xmonad/xmonad.hs

# Shortcut for .zsh
ZSH=$HOME/.zsh

# Shortcut for .zshrc
ZSHRC=$HOME/.zshrc

# Zsh Theme
ZSH_THEME="kevin"

# plugins=(git)

## OH MY ZSH options ##
DISABLE_AUTO_UPDATE="true"

##        ##
## SOURCE ##
##        ##

source $ZSH/oh-my-zsh.sh

##          ##
## SETTINGS ##
##          ##

# Check if X window is running.
if [ "`ps aux | grep startx | head -n -1 | tail -c 16`" = "/usr/bin/startx" ];then
  # Everything in here will only be executed when X window is running.

  ##                  ##
  ## X WINDOW ALIASES ##
  ##                  ##

  alias emacs='emacs -nw'
else
  # Everything in here will only be executed when X window is NOT running.

  ##                 ##
  ## CONSOLE ALIASES ##
  ##                 ##

  # Swaps a few keys
  echo "Password to swap keys\n"
  alias loadall='sudo loadkeys ~/.dotfiles/keymap/keymap.map'
  sudo loadkeys ~/.dotfiles/keymap/keymap.map
fi

##         ##
## ALIASES ##
##         ##

# Suspend
alias suspend='sudo pm-suspend'

# Git pull
alias pull='git pull'

# Git push
alias push='git push'

# Clear
alias c='clear'

# Scan for bluetooth devices
alias sblue='hcitool scan'

# Reset database and seed
alias reseed='rake db:migrate:reset && rake db:seed'

# Reset database and seed on Heroku server
alias hereseed='heroku pg:reset SHARED_DATABASE_URL --confirm && heroku run rake db:migrate && heroku run rake db:seed'

# Shutdown
alias shutdown='sudo shutdown -h now'

# Reboot
alias reboot='sudo reboot'

# Connect to my iPhone using MyWi
alias cphone='/lib/udev/ipheth-pair && sudo dhcpcd eth1'

# Vagrant
alias vagrant='~/.vagrant/bin/vagrant'

# Create a new kvm machine (without installing an os)
# arguments: Name, size (Arch_linux 10G)
alias newkvm='qemu-img create -f qcow2'

##           ##
## FUNCTIONS ##
##           ##

# Install a new kvm machine
function installkvm {
  qemu-kvm -hda $1 -m 512 -cdrom $2 -boot d -vga std
}

# Run a rvm machine
function runkvm {
  qemu-kvm -hda $1 -m 512 -vga std
}

# I compile the C file into an output file and then run it, afterwards I call the
# remove_output_file to remove it. I do this because the file doesn't exist yet when
# running the first function, which is why I'm using 2 functions.
function runc {
  if [ -z "$1" ]
  then
    echo "Please select a C file."
  else
    gcc $1 -o sdiuf8hf83h2gh97dj2037f && ./sdiuf8hf83h2gh97dj2037f ${@:2}
    remove_selected_file sdiuf8hf83h2gh97dj2037f
  fi
}

# The next two functions are meant to be able to start and stop multiple rails servers in one window.
# Start rails server with custom port as background process
function ras {
  rails s -p $1 &
}

# Kill the rails server background process, by giving the port it kills that server
function killrails {
  the_rails_server=`ps | grep 'rails s -p' | grep $1 | awk '{print $1}' | head -1`
  kill -9 $the_rails_server
}

# function get_paclist {
#   pacman -Qqe > crtb467tb8tgfrf486c2g
#   (tr "\n" " " < crtb467tb8tgfrf486c2g) > my_pacman_list
#   remove_selected_file crtb467tb8tgfrf486c2g
#   substract_yaourt my_pacman_list
# }

# function substract_yaourt {
#   cat $1 > my_pacman_list_0
#   yaourt=( dropbox esound msn-pecan package-query spark urxvt-clipboard yaourt youtube-downloader )
#   (sed -e "s/${yaourt[0]}//g" my_pacman_list_0) > my_pacman_list_1

  # for ((i=0; i<${#yaourt[*]}; i++)) do
  #   o=($i + 1)
  #   cat my_pacman_list_$i > my_pacman_list_$o
  #   sed -e "s/${yaourt[$i]}//g" > my_pacman_list_$i
  # done
# }

# This function is meant to remove files that are created in a function
# When trying to remove a file that was created in the same function it won't find it.
# This is why we need a seperate function to remove a file.
function remove_selected_file {
 rm $1
}

function store_emacs_backups {
  mkdir emacs_backup_files
  find ./* | grep "#" | while read line;do mv $line ./emacs_backup_files/;done
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting