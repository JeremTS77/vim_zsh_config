install:
	rm -rf "$(HOME)/#_my_config" $(HOME)/.vim $(HOME)/.vimrc
	mv "vim" "$(HOME)/.vim"
	mv "vimrc" "$(HOME)/.vimrc"
	mv "#_my_config" "$(HOME)/#_my_config"
	mv "zshrc" "$(HOME)/.zshrc"
	if [ -a ~/Library/Fonts/Meslo\ LG\ S\ Regular\ for\ Powerline.otf ] ; \
		then \
			rm  ~/Library/Fonts/Meslo\ LG\ S\ Regular\ for\ Powerline.otf; \
	fi;
	cp "$(HOME)/#_my_config/Meslo\ LG\ S\ Regular\ for\ Powerline.otf" ~/Library/Fonts

reinstall:
	git stash
	git stash clear
	make install
