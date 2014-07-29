_snippets: snippets
	ln -s $(shell pwd)/$< $(HOME)/.vim/snippets

.vimrc: vimrc
	mkdir -p $(HOME)/.vim
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	ln -s $(shell pwd)/$< $(HOME)/$@

install: .vimrc snippets
	vim +PluginInstall +qall

uninstall:
	rm $(HOME)/.vimrc
	rm -rf $(HOME)/.vim
