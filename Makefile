$(HOME)/.vim/bundle/Vundle.vim:
	mkdir -p $(HOME)/.vim
	git clone https://github.com/gmarik/Vundle.vim.git $@

$(HOME)/.vimrc: vimrc
	ln -s $(shell pwd)/$< $@

$(HOME)/.vim/snippets: snippets
	ln -s $(shell pwd)/$< $@

install: $(HOME)/.vim/bundle/Vundle.vim $(HOME)/.vimrc $(HOME)/.vim/snippets
	vim +PluginInstall +qall

uninstall:
	rm $(HOME)/.vimrc
	rm -rf $(HOME)/.vim
