FROM debian

ENV DEBIAN_FRONTEND=noninteractive

# install vim, tmux, fish
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y vim && \
    apt-get install -y tmux && \
    apt-get install -y software-properties-common && \
    apt-add-repository ppa:fish-shell/release-3 && \
    apt-get install -y fish 

# install powerline fonts for oh-my-vim, 
# oh-my-tmux, and bobthefish
RUN apt-get install -y fonts-powerline
RUN fc-cache -vf
    

#######################################
# install my favorite developer tools
#######################################

# system tools
RUN apt-get install -y fzf && \
    apt-get install -y tree && \
    apt-get install -y neofetch && \
    apt-get install -y procps

# networking utilities
RUN apt-get install -y nmap && \
    apt-get install -y netcat && \
    apt-get install -y nload && \
    apt-get install -y nethogs && \
    apt-get install -y bmon && \
    apt-get install -y cbm

# install node & npm
RUN apt-get install -y npm

# install node tools 
RUN npm install -g gtop && \
    npm install -g fkill-cli && \
    npm install -g cfonts


########## WIP #############
# install nix pkg mgr, to install 
# more awesome developer tools
# 
# RUN curl https://nixos.org/nix/install | sh
# RUN nix-env -i bat && \
#     nix-env -i exa
############################

# x86 assembly docs
# RUN go get github.com/bnagy/cgasm

######## WIP ##########
# install oh-my-vim
RUN curl -L https://raw.github.com/liangxianzhe/oh-my-vim/master/tools/install.sh | sh

#   oh my vim
#   post build mods
# -------------------
# /root/.oh-my-vim/packages/basic.vimrc
# line  153:
# E185: Cannot find color scheme 'molokai256'
# 
# Error detected while processing /root/.oh-my-vim/vimrc:
# -- More --
# line  255:
# -- More --
# E117: Unknown function: unite#filters#matcher_default#use
# -- More --
# line  256:
# -- More --
# E117: Unknown function: unite#filters#sorter_default#use
# -- More --
# line  258:
# -- More --
# E117: Unknown function: unite#custom#source

# add to .vimrc
# set norelativenumber
##########################

# install oh-my-tmux
WORKDIR /root
RUN git clone https://github.com/gpakosz/.tmux.git && \
    ln -s -f .tmux/.tmux.conf && \
    cp .tmux/.tmux.conf.local .

######### WIP ###########
# install & configure a better diff
# 
# RUN git clone https://github.com/so-fancy/diff-so-fancy.git
# RUN cp diff-so-fancy/diff-so-fancy /usr/local/bin/diff-so-fancy
# ENV PATH "$PATH:/root/diff-so-fancy/diff-so-fancy"
# RUN git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
#########################

# install oh-my-fish & configure
RUN git clone https://github.com/oh-my-fish/oh-my-fish
RUN cd oh-my-fish && bin/install --offline --noninteractive
RUN ["/usr/bin/fish", "-c", "omf update && omf install bobthefish"]

# set bobthefish settings
RUN ["/usr/bin/fish", "-c", "set -g theme_display_git yes"]
RUN ["/usr/bin/fish", "-c", "set -g theme_powerline_fonts yes"]



