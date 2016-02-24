install:
	rm -rf "$(HOME)/#_my_config" $(HOME)/.vim $(HOME)/.vimrc
	mv "vim" "$(HOME)/.vim"
	mv "vimrc" "$(HOME)/.vimrc"
	mv "#_my_config" "$(HOME)/#_my_config"
	mv "zshrc" "$(HOME)/.zshrc"
	rm  ~/Library/Fonts/Meslo\ LG\ S\ Regular\ for\ Powerline.otf
	cp Meslo\ LG\ S\ Regular\ for\ Powerline.otf ~/Library/Fonts
