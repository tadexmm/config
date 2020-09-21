let g:anna_lecture_head = ['\documentclass[12pt]{article} \input{../preload.tex} \AMpath{} \begin{document}','\lecture{#course}{#lecturer}{#date}{#time}{#venue}{on-time}','\listoftodos \end{document}']
let g:anna_tut_head = ['\documentclass{article} \input{../preload.tex} \begin{document}','\lecture{#pageref}{#questions}{#date}{#time}{#venue}{on-time}','\end{document}']
    
function! Confirm(msg)
    echo a:msg . ' '
    let l:answer = nr2char(getchar())

    if l:answer ==# 'Y'
        return 1
    elseif l:answer ==# 'n'
        return 0
    else
        echo 'Please enter "Y" or "n"'
        return Confirm(a:msg)
    endif
endfunction
function! AddCourse()
       call inputsave() "In case AddCourse is one day used in a mapping
    let s:course_code = input('Enter course code: ')
       call inputrestore()
if empty(s:course_code)
    return 0
endif

    let s:course_lecturer = input(s:course_code.' Lecturer: ')
    let s:course_venues   = input(s:course_code.' Venue(s): ')
    let s:course_fullname = input(s:course_code.' Course full name: - ')

    let s:before_course = getcwd()
    call mkdir(s:course_code)

    execute 'cd' fnameescape(s:course_code)
     if s:before_course ==? getcwd()
        echoerr "Couldn't change/create directory :("
        return 0
    endif

    let s:write1 = '\newcommand{\courseLecturer}{'.s:course_lecturer.'\xspace}'
    let s:write2 = '\newcommand{\courseFullName}{'.s:course_fullname.'\xspace}'
    let s:write3 = '\newcommand{\courseVenues}{'  .s:course_venues  .'}'|"No xpace for venues.. for now
    let s:write4 = '\newcommand{\courseCode}{'    .s:course_code    .'\xspace}'
    let s:write5 = '\newcommand{\AMpath}[1]{\newcommand{\MediaPath}{#1}}'
    let s:write6 = '\input{../../anna-global/base.tex}'

    let s:course_settings = [s:write1,s:write2,s:write3,s:write4,s:write5,s:write6]
    call writefile(s:course_settings,'preload.tex')

    call mkdir('Notes')
    call mkdir('Media')
    call mkdir('randoms')
    call mkdir('Sakai')
    call mkdir('Scripts')

    execute 'cd' fnameescape(s:before_course)
    echom "' - Added :)"
    return 1

endfunction
" ----------------------------------------------------------------
" Initializing anna directories
cd %:p:h "Change directory to current file directory

let $destination = '../Anna'.strftime("%y")
let s:skeleton_response = Confirm('Creating Anna skeleton at: "' . getcwd().'/'.$destination.'" Continue?')
if s:skeleton_response == 0
    echom 'Ok. Open a random file in your chosen Anna skeleton folder then try again'
    finish
endif
if s:skeleton_response == 1
    if !exists('*mkdir')
       echom 'mkdir not available on this system'
       echom 'Please try manual setup. Ending Anna setup.'
       finish
    endif
    if isdirectory($destination)
       echoerr 'Directory '.$destination.' already exists! Please delete it first'
       finish
    endif

    let s:before_add = getcwd()

    call mkdir($destination)
    execute 'cd! '.$destination
    let g:anna_dir = getcwd()
    call mkdir('anna-randoms')
    call mkdir('anna-global')
    call writefile(g:anna_lecture_head,'anna-global/.lecture-head.tex')
    call writefile(g:anna_tut_head,'anna-global/.tut-head.tex')

    echom 'Now adding courses. Only course codes are required. The rest are optional '
    echom '- Press <Esc> to skip or exit'
      let s:add_success = 1
    while s:add_success == 1
    let s:add_success = AddCourse()
    endwhile
    execute 'cd' fnameescape(s:before_add)
    echom '                                                                Anna Initialization complete. '
          \."1. Remember to add this line to your .vimrc file:                                    "
	  \. "let g:anna_dir = '".g:anna_dir."'                                 "
	  \. '2. Also copy anna-global folder to the new '. $destination[3:] .' location.'
    sleep 4
"end if s:skeleton_response == 1
endif
