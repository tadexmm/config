"alvan/vim-closetag
"let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
"let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
"let g:closetag_filetypes = 'html,xhtml,phtml'
" let g:closetag_xhtml_filetypes = 'xhtml,jsx'
" let g:closetag_emptyTags_caseSensitive = 1
"let g:closetag_shortcut = ' '
" let g:closetag_close_shortcut = '<leader>>'
"HTML tricks
augroup Web
   au!
   au! BufReadPost *.html  call Web()
   au! BufReadPost *.htm   call Web()
   au! BufReadPost *.php   call Web()
   setlocal fileencoding=utf-8
augroup END

function! Web()
    inoremap <buffer> <s-cr> <c-r>=search('>\zs','W') && ClearStack() ? '' : ''<cr>
    setlocal fdm=indent
    inoremap <buffer> " ""<c-r>=Mysp(1)<cr>
    inoreabbr <buffer> ' ''<c-r>=Mysp(1)<cr>
    inoremap <buffer> ( ()<c-r>=Mysp(3)<cr>
    inoremap <buffer> [ []<c-r>=Mysp(1)<cr>
    inoremap <buffer> { {}<c-r>=Mysp(1)<cr>
    inoremap <buffer> <expr> < CloseTag()
    silent! iunmap //

    function! CloseTag()
	inoremap <expr><buffer> <space> CloseHTMLtag(0)
	inoremap <expr><buffer> >       CloseHTMLtag(1)
	"inoremap <expr><buffer> >>      CloseHTMLtag(2)
	return '<'
    endfunction

    function! CloseHTMLtag(s)
	iunmap <buffer> <space>
	iunmap <buffer> >
	"iunmap <buffer> >>

	let l:p = searchpos('<','bn','.')[1]
	let l:text = strpart(getline('.'),l:p,getpos('.')[2]-l:p)
	if match(l:text,'^[A-z0-9]*$') == -1 | return a:s ? '>' : ' ' | endif
	"----------------------------
	let l:ret  = '></'.l:text.'>'.repeat("\<left>",len(l:text)+3).Mysp(0,"\<c-g>u\<cr>\<cr>\<Up>\<c-t>")

	return !match(l:text,'^\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|param\|source\|track\|wbr\)$')
	    \ ? a:s ?  '/>'  : ' />'.Mysp(2) 
	    \ : a:s ? l:ret : ' '  .l:ret.Mysp(1)|
	    "\ ? a:s ? ' />'  : ' />'.Mysp(2) 
    endfunction
    normal! zr
    normal! zr
    normal! zr
endfunction

fun! ClearStack()
    let g:sp_stack = []
    let g:sp_etack = []
    let g:sp2_stack = []
    let g:sp2_etack = []
    silent! call UnMa()
    silent! call UnMa2()
endfun

call ClearStack()
au! InsertLeave * call ClearStack()

fun! UnMa()
    execute 'iunmap <buffer> <cr>'
    return "\<cr>"
endfunction

fun! UnMa2()
    execute 'iunmap <buffer> <s-cr>'
    return "\<cr>"
endfunction

fun! Mysp(nsp,...)
    call add(g:sp_stack,a:nsp)
    let l:tmp = a:0 ? add(g:sp_etack,a:1) : add(g:sp_etack,'')
    inoremap <silent> <buffer> <cr> <c-r>=exists('g:sp_stack[-1]') && exists('g:sp_etack[-1]')
	\ ? repeat("\<c-v><right>",remove(g:sp_stack,-1)).remove(g:sp_etack,-1)
	\ : UnMa()<cr>
    return repeat("\<left>",a:nsp)
endfun


fun! Mysp2(nsp,...)
    call add(g:sp2_stack,a:nsp)
    let l:tmp = a:0 ? add(g:sp2_etack,a:1) : add(g:sp_etack,'')
    inoremap <silent> <buffer> <s-cr> <c-r>=exists('g:sp2_stack[-1]') && exists('g:sp2_etack[-1]')
	\ ? repeat("\<c-v><right>",remove(g:sp2_stack,-1)).remove(g:sp2_etack,-1)
	\ : UnMa2()<cr>
    return repeat("\<left>",a:nsp)
endfun

"Anna
    let g:anna_dir = 'C:\Users\Tadex\Anna20\'
    let g:anna_dev_dir = 'C:\Users\Tadiwa\Documents\anna_dev\Anna18\'
    "
    "
    "
    "
    "
    

    "------------------
"Randoms
    syn sync maxlines=240
    syn sync minlines=40
    map <F9>   :silent! !start explorer %:h<cr>
    nnoremap n nzz
    nnoremap N Nzz
    let g:tex_nospell=1
"ALE
    set nocompatible
    "filetype off

    "let &runtimepath.=',~\.vim\bundle\vim-ale'

    filetype plugin on
    "silent! helptags ALL
    let g:ale_sign_column_always = 1

"Stunos
    "let g:wits_dir = 'C:/Users/Tadiwa/Documents/Wits17'
    let g:displaymessages = 1
    let g:tex_conceal = 'abdgms'
    packadd! matchit
    nnoremap <F3> :w<cr>:source %<cr>
    inoremap <F3> <Esc>:w<cr>:source %<cr>

"Programming & Appeance
    set splitright
    command! -nargs=1 -complete=buffer B :vsplit<cr><c-r>:b <args>
    set encoding=utf-8		"Set (gvim) display encoding
    set number			"Show line numbers
    set relativenumber		"Relative numbers for noncurrent lines
    set cursorline		"Highlight the line we're on
    set autoindent		"AutoTab" new lines
    "set backspace=indent,eol,start	"Allow backspacing over those 3
    set backspace=start	"Allow backspacing over those 3
    set path=.,**		"Look in sub-directories	 
    set shiftwidth=4		"Perhaps Python is growing on me
    syntax on			"Colour my code
    "set laststatus=1			"Status bar only if many windows
    set laststatus=2
    colorscheme turtles
    hi Error guifg=red guibg=#444444|"Colorscheme specific
    hi wildmenu guifg=#EEEEEE guibg=#222222
    nmap // :nohls<cr>
    imap // <Esc>:nohls<cr>
    				"Nice colors for commandline autocomplete
"GVim Graphic User Interface
    set guioptions-=m    	"Hide the menu bar
    set guioptions-=T		"Hide the Toolbar
    set guioptions-=r		"Hide the Toolbar
    set guioptions-=l		"Hide the Toolbar
    "set guifont=Consolas:h14:cANSI 
    set guifont=Consolas:h10.3:cANSI 
    "au GUIEnter * simalt ~x	"Start Maximised
"Search
    set ignorecase		"NeVeRminD the CaSE
    set hlsearch		"Highlight your finds
    set wildmenu
    set wildignore+=*.png,*.gif,*.ico,*.jpg,*.pdf,*.div,*.aux,*.latexmk,*.fls,*.log,*.fdb_latexmk
    set incsearch
"Autocomplete
    inoremap <tab> <C-p>
    				"Use Tab for autocomplete
"Save
    "set directory=~/.vim-swp	"Directory for .swp files
"    autocmd CursorHold,CursorHoldI <buffer> silent write
    set updatetime=5000		"AutoSave after 5sec of no activity
    set undofile		"Persistent undo
