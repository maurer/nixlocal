{vim_configurable, racerRust, hoogle, git, vim, python, lib, buildEnv}:

let vim = vim_configurable.customize {
    name = "vim";
    vimrcConfig = {
      customRC = ''
      set backspace=indent,eol,start
      set ruler
      set cc=80
      set hidden
      match ErrorMsg "\s\+$"
      let mapleader=","
      let maplocalleader=";"
      nnoremap <Leader>tw :%s/\s\+$//e<CR>
      let g:ghcmod_ghc_options = ['-g', '-O0']
      set omnifunc=syntaxcomplete#Complete
      autocmd BufWritePost *.hs GhcModCheckAndLintAsync
      autocmd FileType haskell nnoremap <LocalLeader>c
      \ :GhcModCheckAndLintAsync<CR>
      set tabstop=2 shiftwidth=2 expandtab
      '';
      vam.pluginDictionaries = [
        #"vimproc"
        #"fugitive"
        #"racer"
      ];
    };
  }; in

lib.lowPrio (buildEnv rec {
  name = "vim-env";
  ignoreCollisions = true;
  paths = [
    #python
    #git
    vim
    #racerRust
  ];
})
