function! In_Initial(idx,val)
    return match(g:initial,escape(a:val,'./\')) == -1
endfunction

function! Match(lst,str)
    return match(a:lst,escape(a:str,'./\'))
endfunction


function! LivePDF()
let l:list = []
let l:open = []
let g:initial = []
let l:ecnt = 0
let l:limm = 34
let l:time = 400

let l:old_dir = getcwd() | execute 'cd' fnameescape(g:anna_dir)
let s:list = globpath('.','*',0,1)
let s:list = filter(s:list,'v:val =~ ("anna-global" || "anna-randoms")')
let s:list = map(s:list,"substitute(v:val,'.','','')")
let s:list = map(s:list,"substitute(v:val,'\\','','')")
let s:list = map(s:list,"substitute(v:val,'/','','')")
let ext = '/Notes'
let directories = join( map(s:list, "v:val.ext"),',')

let g:initial = globpath(directories,'.*.tex.swp',1,1)

    while 1
        let l:list = globpath(directories,'.*.tex.swp',0,1)
	let l:list = filter(l:list, function('In_Initial'))

        "echo 'Found: '. "\n + ".join(l:list, "\n".' + ')
	"echo 'Currently open: '. join(l:open, '+')
	execute 'sleep '.l:time.'m'

	for swp in l:list
	    let pdf = substitute(swp, '\.\ze.\{-}\.tex\.swp$'    , ''     , '')
	    let pdf = substitute(pdf, '\.tex\.swp$' , '.pdf' , '')
	    if match(l:open, escape(swp,'./\')) == -1
		if filereadable(pdf)
		    let l:open = l:open + [swp]
		    let l:ecnt = 0
		    call OpenPDF(pdf)
		endif
	    endif
	endfor

	for opd in l:open
	    let id = match(l:list, escape(opd,'/\.'))
	    if id == -1
		call remove(l:open,match(l:open,escape(opd,'./\')))
	    endif
	    "echo id
	endfor

	if empty(l:list)
	    "echo l:limm - l:ecnt
	    let l:ecnt += 1
	    if l:ecnt >= l:limm
		silent! !start /b taskkill /im sumatraPDF.exe
		"echo 'Closed the viewer'
	    endif
	endif
	"echo '-------------------------------'
    endwhile
execute 'cd' fnameescape(l:old_dir)
endfunction

command LivePDF :call LivePDF()

function! OpenPDF(file)
    "execute 'silent! !sumatraPDF '.a:file.'&'
    silent! call system('start /b sumatraPDF '.a:file)
endfunction
