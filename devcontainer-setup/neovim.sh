mkdir neovim

curl -o neovim/nvim -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage 

chmod a+x neovim/nvim 
cd neovim 
./nvim --appimage-extract 
cd squashfs-root/usr 
rsync -rv . /usr/ 
rm -rf /tmp/nvim 
rm -rf /tmp/squashfs-root/usr

apt install unzip
