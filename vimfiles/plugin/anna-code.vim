function! Anna_TestCode(...)
    let replace = a:0 ? (a:1 ? 1 : 0) : 0
    " Checking file name
    let l:cline = line('.')
    let l:ccol = col('.')

    let l:search_string1 = '^\s*\\begin{TestMyCode}'
    let l:search_string2 = '^\s*\\begin{lstlisting}%\='
    call search(l:search_string1 ,'beW')

    let l:tline = line('.')
    let l:etline = search('^\s*\\end{TestMyCode}','nW')

    if empty(matchstr(getline('.'), l:search_string1)) || !l:etline
	echoerr "Can't find a TestMyCode group anywhere above :("
	echoerr "    Check both \begin{...} and \end{...}"
	return 0
    endif


    call search(l:search_string2 ,'beW')
    if empty(matchstr(getline('.'), l:search_string2))
	echoerr "Can't find the actual code group (lstlisting) anywhere above :("
	echoerr "    Check both \begin{...} and \end{...}"
	return 0
    endif
    let l:file_name = matchstr(getline('.'), l:search_string2.'\[\zs[A-Za-z0-9_.-]*\ze\]')
    if empty(l:file_name)
	call inputsave()
	let l:file_name = input('Please provide file name: ', '.cpp'."\<left>\<left>\<left>", 'file')
	call inputrestore()
	while empty(matchstr(l:file_name, '^[A-Za-z0-9_.-]*$'))
	    call inputsave()
	    let l:file_name = input('Try again. Use only [A-Za-z0-9_.-]: ', '.cpp'."\<left>\<left>\<left>", 'file')
	    call inputrestore()
	endwhile
	let l:new_line = substitute(getline('.'), l:search_string2.'\%(\[.\{-}\]\)\=', '\\begin{lstlisting}%['.l:file_name.']','')
	echom l:new_line
	echom line('.')
	call setline('.', l:new_line)
    endif

    " Extracting code
    call search(l:search_string1 ,'eW')
    let l:end = search('^\s*\\end{lstlisting}','bneW')
    let l:beg = search('^\s*\\begin{lstlisting}','bneW')
    
    if l:beg * l:end
	let l:code = getline(l:beg + 1, l:end - 1)
    else
	echoerr "Can't find any code above (i.e. an 'lstlisting' group) :("
	return 0
    endif
    if empty(l:code)
	echoerr "Do we really want to work with empties? :/"
	return 0
    endif
    "echo l:code
    " Saving code. Notice we assume we are in the Course's Notes directory as
    " the norm.
    if !GetCurrentAMpath()
	echoerr 'AMpath issues are making life difficult :(' \\
	return 0
    endif
    if writefile(l:code, '../Media/'.b:ampath.'/'.l:file_name) == -1
	echoerr "Failed to write the code to file :(" \\
	return 0
    endif
    " Now for input, execution and reports
    let l:exec = 'python3 ' . shellescape('../Media/'.b:ampath.'/'.l:file_name, 0)
    let l:ffn = shellescape('../Media/'.b:ampath.'/'.l:file_name, 0)
    let l:fff = matchstr(l:ffn,'^.\{-}\ze\.')
    let l:exec = 'g++ -Wall ' . l:ffn. ' -o '. l:fff
    let l:input = getline(l:tline + 1, l:etline - 1)
    call filter(l:input, 'v:val !~ "^\s*#"')
    let l:exec_attempt = extend([l:exec],l:input)

    call map(l:input, "'echo '.
    \ substitute(substitute(escape(v:val,'\&|()'),'\\','\^','g'),
    \ '\^\^', '\', 'g'
    \ )" )
    let l:input[0] = '('.l:input[0]
    let l:input[-1] = l:input[-1].')'

    let l:feed = join(l:input, ' & ')
    let l:final = join([l:feed, l:exec], ' | ')
    "call add(l:exec_attempt, '# Actually ran: ')
    "call add(l:exec_attempt, l:final)
    "call add(l:exec_attempt, '-----------------------------------------------------------------------')

    let l:time = localtime()
    let l:start = reltime()
    let l:output = split(system(l:final), "\n")
    let l:end = reltime()
    "echo l:final
    "echo l:exec_attempt
    "echo l:output

    " Now to report
    let l:info = ['# Execution ID: '.RandLetter(12),
    \             '# Ran on '.strftime("%A %d %B %Y", l:time).' at '
    \                       .strftime("%H:%M:%S",l:time). ' ('
    \                       .strftime("%z",l:time).')',
    \             '# Took '.split(reltimestr(reltime(l:start,l:end)))[0].' seconds']

    let l:tell_them = 
    \ ['\begin{lstlisting}'] +
    \ l:info +
    \  l:exec_attempt +
    \  map(l:output, '"<< ".v:val') +
    \ ['\end{lstlisting}','\hrulefill','']


    if l:replace
	let l:replace = 0
	call cursor(l:etline ,1)
	let l:obeg = search('^\s*\\begin{lstlisting}','Wn')
	let l:oend = search('^\s*\\end{lstlisting}','Wn')

	if !l:obeg || !l:oend || l:oend-l:obeg < 1 ||  l:obeg != l:etline + 1
	    echom "Couldn't be certain about what exactly to replace :/"
	    let l:replace = 0
	else
	    for l:l in range(l:obeg, l:oend)
		call setline(l:l, '-----'.getline(l:l))
	    endfor
	    :redraw!
	    echom "May we delete the lines with '-----'? Y or n: "
	    let l:response = nr2char(getchar())
	    while l:response !=# 'Y' && l:response !=# 'n'
	        echo "Respond with either 'Y' or 'n'. Delete? "
		let l:response = nr2char(getchar())
	    endwhile

	    if l:response ==# 'Y'
		call cursor(l:obeg, 1)
		execute 'normal! V'.string(l:oend - l:obeg).'jdd'
	    else
		for l:l in range(l:obeg, l:oend)
		    call setline(l:l, substitute(getline(l:l),'^-----','','g'))
		endfor
	    endif
	endif
    endif
    call append(l:etline, l:tell_them)
    call cursor(l:cline,l:ccol)
endfunction
