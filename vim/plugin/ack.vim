" vim-ack integration
"
" taken from http://blog.ant0ine.com/2007/03/ack_and_vim_integration.html
"
" usage:
" (the same as ack, except that the path is required)
" examples: 
" :Ack TODO .
" :Ack sub Util.pm

function! Ack(args)
    let grepprg_bak=&grepprg
    set grepprg=ack\ -H\ --nocolor\ --nogroup
    execute "silent! grep " . a:args
    botright copen
    let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)

" Now :cnext is your friend!


