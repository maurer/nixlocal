{vim_configurable, git, vim, python, lib, buildEnv}:

let vim = vim_configurable.customize {
    name = "vil";
    vimrcConfig = {
      customRC = ''
      set backspace=indent,eol,start
      set ruler
      set cc=80
      match ErrorMsg "\s\+$"
      let mapleader=","
      let maplocalleader=";"
      nnoremap <Leader>tw :%s/\s\+$//e<CR>
      set tabstop=2 shiftwidth=2 expandtab
      '';
      vam.pluginDictionaries = [
        "vimproc"
        "fugitive"
      ];
    };
  }; in

lib.lowPrio (buildEnv rec {
  name = "vim-env";
  ignoreCollisions = true;
  paths = [
    python
    git
    vim
  ];
})
