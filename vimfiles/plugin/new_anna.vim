function! Anna_Del(d)
" Writes out in full the LaTeX math for a fraction-style partial derivative
" given white-space-separated orders info in the form, e.g. 6u x2 y4 for
" '$\frac{\partial^6u}{\partial x^2\partial y^4}$'.
" Con advise where order separates variable using '.' like so: 6.u x.2 y.4, 
" ... and can use lone '.' if no numerator variable required. i.e . x yields
" '$\frac{\partial}{\partial x}$'.
" Todo: Orders are passed to the function by having e.g. §d || then...
"

let l:r = escape(a:d,'\')
if empty(a:d)
	call setline('.',substitute(getline('.'),'§'.escape(a:d,'\').'.\{-}§',l:r,''))
endif
    "call inputsave()
    "let l:orders = input('What orders? ')
    "call inputrestore()
    
    let l:orders = matchstr(getline('.'),'§'.escape(a:d,'\').'\zs.\{-}\ze§')
    
    if empty(substitute(l:orders,'\s\+','',''))
	call setline('.',substitute(getline('.'),'§'.escape(a:d,'\').'.\{-}§',l:r,''))
    endif
    
    let l:o = split(l:orders, '\%(\d\w\|\w\d\|\s\@=\)\zs\s\+\ze') + ['}']
    let l:carat = match(l:o[0], '^\%(\s\+\)\=$') ? '' : '\^'
    let l:o[0]  = len(l:o) == 2 ? a:d : '\frac{'.a:d.substitute(l:o[0],'\.\|\ze\d\+', l:carat, '').'}{'
    let l:carat = match(l:o[1], '^\%(\s\+\)\=$') ? '' : '\^'
    let l:o[-1] = len(l:o) == 2 ? substitute(l:orders,'\.\|\ze\d\+', l:carat, '') : l:o[-1]
    echom string(l:o)
    echom l:orders
    
    for l:i in range(1,len(l:o) - 2)
        let l:carat = match(l:o[1], '^\%(\s\+\)\=$') ? '' : l:carat
        let l:o[l:i] = a:d.substitute(l:o[l:i], '\.\|\ze\d\+', l:carat, '')
    endfor
    
    let l:r = join(l:o,'')
    let l:r = substitute(l:r,'\^\([A-Za-z0-9\\]*\)\.\|\^\(\d\{2,}\)','\^{\1\2}','g')
    "let l:r = substitute(l:r,'\d\{2,}','{&}','g')
    "let l:r = substitute(l:r,'\^\ze\%(}\|$\|\s\)','','g')
    if match(a:d, '\\') != -1
	let l:r = substitute(l:r,a:d.'\ze[A-Za-z0-9]',a:d.' ','g')
    endif
    "Make mappings before escape
    call Anna_MakeMappable(tolower(matchstr(a:d,'\c[a-z]')).substitute(l:orders,'\s\+','','g'), l:r)
    let l:r = escape(l:r,'\')

    call setline('.',substitute(getline('.'),'§'.escape(a:d,'\').'.\{-}\ze§',l:r,''))
    call search('§')
    call setline('.',substitute(getline('.'),'§','','g'))
    return ''
endfunction

fun! Anna_ClearStack()
    let g:anna_rs = ["\<c-r>=UnMa()\<cr>"] "Right stack
    let g:anna_es = [''] "Extras stack
    let g:anna_rs = [] "Right stack
    let g:anna_es = [] "Extras stack
    silent! call UnMa()
    return ''
endfun

fun! UnMa()
    call Anna_NormalEnter()
    for l:mode in reverse(copy(g:anna_modes))
	"echom l:mode
	execute 'let l:mode_status = g:anna_'.l:mode.'_mode_status'
	if l:mode_status == 1
	    execute 'call Anna_'.l:mode.'ModeEnter()'
	    break
	endif
    endfor
    let g:anna_rs = ["\<c-r>=UnMa()\<cr>"]
    let g:anna_es = ['']
    let g:anna_rs = [] "Right stack
    let g:anna_es = [] "Extras stack
    "call Anna_mathModeEnter()
    return eval('"'.escape(maparg('<cr>','i'),'\<').'"')
endfunction

function! Anna_Mysp(right,...)
    call add(g:anna_rs,a:right)
    let l:tmp = a:0 ? add(g:anna_es,a:1) : add(g:anna_es,'')

"Extras
    let l:extra = g:anna_es[-1]
    "echom string(g:anna_es).l:extra
    if type(l:extra) == 0
	if l:extra == 1 "Mappings
	    let l:map_type = a:0 == 2 ? a:2 : ''
	    let g:anna_es[-1] = '§'."\<c-r>=Anna_Mysp2(1,'".l:map_type."')\<cr>"
	elseif l:extra == 2 "Tables
	    let g:anna_es[-1] = '  \\'."\<c-r>=Anna_Mysp2(2)\<cr>"
	elseif l:extra == 3 "Groups
	    let g:anna_es[-1] = "\<c-r>=Anna_GroupTitle()\<cr>\<c-g>u\<Esc>o\    .\<C-g>u\<left>\<del>"
	elseif l:extra == 4 "Sections
	    let g:anna_es[-1] = "\<c-r>=Anna_Mysp2(4)\<cr>"
	elseif l:extra == 5 "Text in math (ON)
	    call DisableModes(['math'], 1) "Disable all modes, except math, don't call Anna_ClearStack()
	    call AnnaModeOff('math',1)
	    call AnnaModeOn('text','')
	    let g:anna_es[-1] = "\<c-r>=Anna_Mysp2(5)\<cr>"
	elseif l:extra == 6 "Quick derivatives
	    let l:d_type = a:0 == 2 ? a:2 : ''
	    let g:anna_es[-1] = '§'."\<c-r>=Anna_Del('".l:d_type."')\<cr>"
	endif
    endif
    "echom string(g:anna_es)
"    let g:anna_rs[-1] = repeat("\<right>",g:anna_rs[-1])
"    inoremap <silent> <buffer> <cr> <c-r>=exists('g:anna_rs[-1]')
"	\ ? remove(g:anna_rs,-1).remove(g:anna_es,-1)
"	\ : UnMa()<cr>
"
    inoremap <silent> <buffer> <cr> <c-r>=exists('g:anna_rs[-1]')
	\ ? repeat("\<c-v><right>",remove(g:anna_rs,-1)).remove(g:anna_es,-1)
	\ : UnMa()<cr>
    return repeat("\<left>",a:right) 
endfunction

fun! Anna_Mysp2(extra, ...)
    call Anna_HAu()
    let l:return = ''
    if a:extra == 1
	"General idea is to get inside bits and map them
        let l:sym = a:0 ? a:1 : ''
	if l:sym == 'v' "Vectors
	    normal! F}"zyi{f§x
	    call Anna_MakeMappable(@z, '\vect{'.@z.'}')
	    let l:return = ' '
	elseif l:sym == 'i' "Inline math
	    execute 'normal! F$"zyF$f§x'
	    call Anna_MakeMappable_for_Inline_Math_Mode(@z.'$')
	    let l:return = ' '
	else
	    call Anna_AutoMapIndex(l:sym)
	endif
    elseif a:extra == 2
	 call AnnaTableCountColumns(b:prev_b,"c")
	 normal! jo\bl 
	 let l:return =' '
    elseif a:extra == 4
	normal! A 
	let l:return = "\<del>\<cr>"
    elseif a:extra == 5
	call DisableAnna_AutosLoose()
	call Anna_Contextualization(1) "Re-evaluate current modes as if we're entering insert mode
    endif
    call Anna_RAu()
    return l:return
endfunction
function! MigrateAnna_SE()
    normal! y$
    let l:text = matchstr(@0,'^.\{-})')
    let l:tvar = matchstr(l:text,'(\zs.\{-}\ze)')
    execute 'let [l,r,s,e] = ['.l:tvar.']'
    if l != r || e != 0
	echoerr 'Errm, please do this one yourself'
	return ''
    endif
    let l:new = 'Anna_Mysp('. l 
    let l:new .= s == 0 ? '' : ",'".repeat(' ',s)."'"
    execute 'normal! ct)'.l:new
endfunction
