"LatexBox settings
"Remember you must have `filetype plugin on' in your
" .vimrc for LatexBox to work
if v:progpath[0] == 'C'
    let g:is_Windows = 1
endif

let g:LatexBox_latexmk_async                = 1
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_autojump                     = 0
let g:LatexBox_show_warnings                = 1
let g:LatexBox_quickfix                     = 0
let g:LatexBox_ignore_warnings              =  
\ ['Maginpar on page', 'Font shape `OMS/SourceSansPro-TLF/m/n'."'".' undefined','Warning']
"AleLint chktex load input files (-I), ignore error 1
let g:ale_tex_chktex_options = '-I -n 1'
set laststatus=2

" let g:anna_flashcard_search_string_b = '\C\\begin{\(Theorem\|Properties\|Method\|Formula\|cDefinition\|Definition\|FlashCard\)}'
" let g:anna_flashcard_search_string_e =   '\C\\end{\(Theorem\|Properties\|Method\|Formula\|cDefinition\|Definition\|FlashCard\)}'
map ,l :NewLecture
map ,s :NewSketch

let g:anna_flashcard_search_string_b = '\C\\begin{\(Action\|Basic\|Steps\|Vocab\|Compare\|Questions\|FlashCard\)}'
let g:anna_flashcard_search_string_e =   '\C\\end{\(Action\|Basic\|Steps\|Vocab\|Compare\|Questions\|FlashCard\)}'

"Defining environments
let g:anna_env = {
    \ 'align_star' : ['\begin{align*}','\end{align*}'],
    \ 'align' : ['\begin{align}','\end{align}'],
    \ 'enumerate' : ['\begin{enumerate}','\end{enumerate}'],
    \ 'itemize' : ['\begin{itemize}','\end{itemize}'],
    \
    \ 'action' : ['\begin{Action}{}{}{}',
    \'\Field{Thing          }{}%',
    \'\Field{Effect on thing}{}%',
    \'\Field{Other thing    }{}%',
    \'\Field{Effect on 2nd  }{}%',
    \'\Field{Third thing    }{}%',
    \'\Field{Effect on 3rd  }{}%',
    \'\Field{Fourth thing   }{}%',
    \'\Field{Effect on 4th  }{}%',
    \'\Field{Fifth thing    }{}%',
    \'\Field{Effect on 5th  }{}%',
    \'\Field{Sixth thing    }{}%',
    \'\Field{Effect on 6th  }{}%',
    \'\Field{Last thing     }{}%',
    \'\Field{Effect on 7th  }{}%',
    \'\end{Action}'],
    \
    \'basic' : ['\begin{Basic}{}{}{}',
    \'\Field{One side  }{}%',
    \'\Field{Other side}{}%',
    \'\end{Basic}'],
    \
    \ 'vocab' : ['\begin{Vocab}{Vocab item}{}{}',
    \'\Field{Thing       }{}%',
    \'\Field{Synonym     }{}%',
    \'\Field{Symbolically}{}%',
    \'\Field{is          }{}%',
    \'\Field{Pictorially }{}%',
    \'\Field{where (pic) }{}%',
    \'\Field{Typa type 1 }{}%',
    \'\Field{Multi 1     }{}%',
    \'\Field{Typa type 2 }{}%',
    \'\Field{Multi 2     }{}%',
    \'\Field{Examples    }{}%',
    \'\end{Vocab}'],
    \
    \ 'steps' : ['\begin{Steps}{}{}{}',
    \'\Field{Perform       }{}%',
    \'\Field{First         }{}%',
    \'\Field{Main steps    }{}%',
    \'\Field{Do'."'".'s? Do nots?}{}%',
    \'\end{Steps}'],
    \
    \ 'z-compare' : ['\begin{Compare}{}{}{}',
    \'\Field{First Thing }{}%',
    \'\Field{Second Thing}{}%',
    \'\Field{Third Thing }{}%',
    \'\Field{Last Thing  }{}%',
    \'\Field{Differences }{}%',
    \'\Field{Similarities}{}%',
    \'\end{Compare}'],
    \
    \ 'z-questions' : ['\begin{Questions}{}{}{}',
    \'\Field{Idea behind (ftf)}{}%',
    \'\Field{When? Where?     }{}%',
    \'\Field{Importance? Why? }{}%',
    \'\end{Questions}']
\}


augroup AnnaInitAU
    au!
    au BufWinEnter  *.tex call AnnaInit()
    au BufWinEnter  *.tex call AnnaModeOn('text','')
    au BufWinEnter  *.tex call AnnaModeOff('text')
    au BufWinEnter  *     call Anna_BufEnter()
augroup END

function! Anna_textModeOn()
    "Did not want to wrap this in a function. But then it seems necessary in order to
    "avoid carrying over latex mappings to other filetypes. All mappings and
    "abbreviations in this function will be applied to only the current (hopefully
    "latex) buffer

    inoreabbr <buffer>  action-		<c-r>=ANE('action',1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  aa-		<c-r>=ANE('action',1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	vv-		<c-r>=ANE('vocab',1)<cr><c-r>=Q1AI5(1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	vocab-		<c-r>=ANE('vocab',1)<cr><c-r>=Q1AI5(1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	basic-		<c-r>=ANE('basic',1)<cr><c-r>=Q1AI5(2)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	steps-		<c-r>=ANE('steps',1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	compare-		<c-r>=ANE('z-compare',1)<cr><c-r>=Q1AI5(0)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  questions-	<c-r>=ANE('z-questions',1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	bb-		<c-r>=ANE('basic',1)<cr><c-r>=Q1AI5(2)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	ss-		<c-r>=ANE('steps',1)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>	cc-		<c-r>=ANE('z-compare',1)<cr><c-r>=Q1AI5(0)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  qq-	<c-r>=ANE('z-questions',1)<cr><c-r>=ES('\s')<cr>

function! Q1AI5(num)
    call Anna_HAu()
    if a:num == 1
    " Why this switch case? Were there any problems with passing a string eg
    " Vocab or Compare to :execute?
	inoremap <silent> <buffer> <s-cr> <Esc>:call YankPasteAt('Vocab')<cr>
    elseif a:num == 0
	inoremap <silent> <buffer> <s-cr> <Esc>:call YankPasteAt('Compare')<cr>
    elseif a:num == 2
	inoremap <silent> <buffer> <s-cr> <Esc>:call YankPasteAt('Basic')<cr>
    endif
    return ''
endfunction

function! YankPasteAt(at)
    execute 'normal! yi{?'.a:at.'}{\zs'."\<cr>".'"_di{P'
    call Anna_FlashCardSkip()
    call Anna_FlashCardSkip()
    call Anna_RAu()
    startinsert
    return ''
endfunction

    set spell
    set spelllang=en_gb

    for i in reverse(range(1,20))
for j in range(1,20)
    execute 'inoreabbr f'.i.j.' <c-r>=LMM("\\frac{'.i.'}{'.j.'}")<cr>'
    endfor
    endfor

call LatexTextModeGreekMap()

    nmap <buffer> <F5> :w<cr>:Latexmk<cr>
    if exists('g:is_Windows') && g:is_Windows
	nmap <buffer> <F6> :silent! execute '!start /b sumatraPDF ' .substitute(expand('%'),'\..\{-}$','.pdf','g')<cr>
    else
	nmap <buffer> <F6> :silent! execute '!xreader ' .substitute(expand('%'),'\..\{-}$','.pdf &','g')<cr>
    endif

    inoremap <silent> <buffer> <F5> <Esc>:w<cr>:Latexmk<cr>
    "New <buffer> --blank-- line. Always
    "Gobble up <space>
    "inoremap <silent> <buffer> <F8> <C-g>u
    "inoremap <silent> <buffer> <F9> <left><C-g>u<C-R>=ES('\s')<cr>
    "inoremap <silent> <buffer> <F10> <C-g>u<C-R>=ES('\s')<cr>
    inoremap <silent> <buffer> <C-b> <C-g>u\begin{}<cr>\end{}<Esc>k$ci{<c-r>=Anna_BeginEnvironmentEnter()<cr>

    "Typing
    inoremap <silent> <buffer> <cr> <C-]><C-g>u<Esc>o
    inoremap <silent> <buffer>    &          <C-]>\& |"abbr may cause unwanted substitutions
    inoremap <silent> <buffer>    #          <C-]>\#|"abbr may cause unwanted substitutions
    inoremap <silent> <buffer>    % <C-]>\%
    inoremap <silent> <buffer>    <C-l> <Esc>:inoremap <silent> <buffer> <c-g>u|
    "inoremap <silent> <buffer>    <F7> <Esc>:imap <silent> <buffer> |
    "inoremap <silent> <buffer>    <C-z> <Esc>:iunmap <buffer> |
    noremap <silent> <buffer> <F10>    :call OpenOld(-1)<cr>
    noremap <silent> <buffer> <F11>    :call OpenOld(1)<cr>

    inoreabbr <buffer>    "   ``''<c-r>=Anna_Mysp(2,' ')<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>    '   `'<c-r>=Anna_Mysp(1,' ')<cr><c-r>=ES('\s')<cr>

    "inoreabbr   C §<c-r>=Anna_ChooseFunction()<cr><left>
    "inoreabbr   P §<c-r>=Anna_PermuteFunction()<cr>

    "inoreabbr <buffer>   implies  <c-r>=LMM('\implies')<cr>
    inoreabbr <buffer>   ... \ldots
    "inoreabbr <buffer>   ldots \ldots
    "would looove to make the ldots \ldots mapping above.
    "Unfortunately it messes up with other ldots mappings---as you
    "move away from your recently created `\ldots' you trigger the
    "aforementioned mapping and end up with `\\ldots'.
    inoreabbr <buffer>   dsh \ldots<c-r>=ES('\s')<cr>

    "inoremap <silent> <buffer>    { <C-]>\{
    "inoremap <silent> <buffer> \{}         <C-]>\{  \}<c-r>=Anna_Mysp(3)<cr>
    inoremap <silent> <buffer> {	<c-g>u<C-]>\{  \}<c-r>=Anna_Mysp(3)<cr>
    inoremap <silent> <buffer> <bar>{	<c-g>u<C-]>\{  \}<c-r>=Anna_Mysp(3)<cr>
    inoremap <silent> <buffer> }        <c-g>u<C-]>\}
    inoremap <silent> <buffer> <bar>}	<c-g>u<C-]>{}<c-r>=Anna_Mysp(1)<cr>
    inoremap <silent> <buffer> }}	<c-g>u<C-]>{}<c-r>=Anna_Mysp(1)<cr>

    "inoremap <silent> <buffer> ()	<c-g>u<C-]>()<c-r>=Anna_Mysp(1,' ')<cr>
    inoremap <silent> <buffer> (	<c-g>u<C-]>()<c-r>=Anna_Mysp(1,' ')<cr>
    "inoremap <silent> <buffer> *(	<c-g>u<C-]>()<c-r>=Anna_Mysp(1,' ')<cr><c-r>=AnnaKnowsBetter('*(')<cr>

    "inoremap <silent> <buffer> []	<c-g>u<C-]>[]<c-r>=Anna_Mysp(1)<cr>
    inoremap <silent> <buffer> [	<c-g>u<C-]>[]<c-r>=Anna_Mysp(1)<cr>
    inoremap <silent> <buffer> 0[	<c-g>u<C-]>[]<c-r>=Anna_Mysp(1)<cr><c-r>=AnnaKnowsBetter('0[')<cr>

    inoremap <silent> <buffer> <bar><bar>	<c-g>u<C-]><bar><bar><c-r>=Anna_Mysp(1)<cr>

    function! AnnaKnowsBetter(actual_typed)
	call Anna_HAu()
	echom a:actual_typed." assumed typing error. Use Ctrl + V for literal". a:actual_typed
	call Anna_RAu()
	return ''
    endfunction


    inoreabbr <buffer>  ff       \ff
    inoreabbr <buffer>  rw       \rw
    inoreabbr <buffer>  recall   \recall

    inoreabbr <buffer> fx  <c-r>=LMM('f(x)')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> Fx  <c-r>=LMM('F(x)')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> gx  <c-r>=LMM('g(x)')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> Gx  <c-r>=LMM('G(x)')<cr><C-R>=ES('\s')<cr>

    "inoreabbr <buffer> x  <c-r>=LMM('x')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> y  <c-r>=LMM('y')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> z  <c-r>=LMM('z')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> n  <c-r>=LMM('n')<cr><C-R>=ES('\s')<cr>

    inoreabbr <buffer> thf <c-r>=LMM('\therefore')<cr>
    inoreabbr <buffer> inf <c-r>=LMM('\infty')<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer> abs <c-r>=LMM('\|abs\|')<cr>
    inoreabbr <buffer> qed      \QeD
    inoreabbr <buffer> bb	$\mathbb{}$<C-g>u<C-R>=Anna_Mysp(1,' ')<cr><C-R>=Anna_Mysp(1)<cr><C-R>=ES('\s')<cr>

    inoreabbr <buffer>   ie  \ie
    inoreabbr <buffer>   eg  \eg

    "Sections, Headings
    inoreabbr <buffer>   sec  <C-g>u<Esc>0i\Section{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>  ssec  <C-g>u<Esc>0i   \subsection{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> sssec  <C-g>u<Esc>0i       \subsubsection{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>   secc <C-g>u<Esc>0i\section*{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>  ssecc <C-g>u<Esc>0i   \subsection*{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> sssecc <C-g>u<Esc>0i       \subsubsection*{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>   seccc  <C-g>u<Esc>0i\SectionTwo{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>  sseccc  <C-g>u<Esc>0i   \SubSection{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer> ssseccc  <C-g>u<Esc>0i       \SubSubSection{}<C-g>u<c-r>=Anna_Mysp(1,4)<cr><C-R>=ES('\s')<cr>

    "Lecture planning
    inoreabbr <buffer>  plan   \Plan{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  prev   \Prev
    inoreabbr <buffer>  play   \Play
    inoreabbr <buffer>  next-  \nextlecture{}<c-r>=Anna_Mysp(1,' ')<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  diary  \Calendar{}<c-r>=Anna_Mysp(1,' ')<cr><c-r>=ES('\s')<cr>

    inoreabbr <buffer>  al-  <c-r>=ANE('align',0)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  al*  <c-r>=ANE('align_star',0)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  card- <Esc>:Card

    "Logic and other keywords
    "inoreabbr <buffer> if       <C-g>u\logic{if}
    "inoreabbr <buffer> then     <C-g>u\logic{then}
    "inoreabbr <buffer> else     <C-g>u\logic{else}
    "inoreabbr <buffer> or       <C-g>u\logic{or}
    "inoreabbr <buffer> and      <C-g>u\logic{and}
    "inoreabbr <buffer> iot      <C-g>u\logic{iot}
    "inoreabbr <buffer> from     <C-g>u\logic{from}
    "inoreabbr <buffer> vs       <C-g>u\logic{vs}
    "inoreabbr <buffer> can      <C-g>u\logic{Can:}
    "inoreabbr <buffer> tr       <C-g>u\logic{Try:}
    "inoreabbr <buffer> sy       <C-g>u\logic{Say:}
    "inoreabbr <buffer> since    <C-g>u\logic{since}
    "inoreabbr <buffer> because  <C-g>u\logic{because}
    "inoreabbr <buffer> but      <C-g>u\logic{but}
    "inoreabbr <buffer> Hence    <C-g>u\logic{Hence}
    "inoreabbr <buffer> seems    <C-g>u\logic{Seems:}
    "inoreabbr <buffer> start    <C-g>u\type{start}
    "inoreabbr <buffer> step     <C-g>u\type{Step:}

    "Type of variable
    "inoreabbr <buffer> var      <C-g>u\type{var}
    "inoreabbr <buffer> vars      <C-g>u\type{var}
    "inoreabbr <buffer> variables   <C-g>u\type{variables}
    "inoreabbr <buffer> statement      <C-g>u\type{statement}
    "inoreabbr <buffer> statements      <C-g>u\type{statements}

    "inoreabbr <buffer> matrix   <C-g>u\type{matrix}
    "inoreabbr <buffer> vect     <C-g>u\type{vector}
    "inoreabbr <buffer> vector    <C-g>u\type{vector}
    "inoreabbr <buffer> scalar   <C-g>u\type{scalar}
    "inoreabbr <buffer> set      <C-g>u\type{set}
    "inoreabbr <buffer> function      <C-g>u\type{function}
    "inoreabbr <buffer> func      <C-g>u\type{func}
    "inoreabbr <buffer> relation      <C-g>u\type{relation}

    "inoreabbr <buffer> matrices   <C-g>u\type{matrices}
    "inoreabbr <buffer> vects     <C-g>u\type{vectors}
    "inoreabbr <buffer> vectors     <C-g>u\type{vectors}
    "inoreabbr <buffer> scalars   <C-g>u\type{scalars}
    "inoreabbr <buffer> sets      <C-g>u\type{sets}
    "inoreabbr <buffer> functions      <C-g>u\type{functions}
    "inoreabbr <buffer> funcs      <C-g>u\type{funcs}
    "inoreabbr <buffer> relations      <C-g>u\type{relations}

    "inoreabbr <buffer> const    <C-g>u\type{constant}
    "inoreabbr <buffer> constant <C-g>u\type{constant}
    "inoreabbr <buffer> given    <C-g>u\type{given}

"    inoreabbr <buffer>  def-     <c-r>=ANE('definition',1)<cr><c-r>=ES('\s')<cr>
"    inoreabbr <buffer>  cdef-     <c-r>=ANE('cdefinition',1)<cr><c-r>=ES('\s')<cr>
"    inoreabbr <buffer>  th-      <c-r>=ANE('theorem',1)<cr><c-r>=ES('\s')<cr>
"    inoreabbr <buffer>  prop-      <c-r>=ANE('properties',1)<cr><c-r>=ES('\s')<cr>
"    inoreabbr <buffer>  formula- <c-r>=ANE('formula',1)<cr><c-r>=ES('\s')<cr>
"    inoreabbr <buffer>  method-  <c-r>=ANE('method',1)<cr><c-r>=ES('\s')<cr>
"
    inoreabbr <buffer>  enum     <c-r>=ANE('enumerate',2)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  itm      <c-r>=ANE('itemize',2)<cr><c-r>=ES('\s')<cr>

    inoreabbr <buffer>  Note     <C-g>u\textbf{Note:}
    inoreabbr <buffer>  nb       <C-g>u\nb{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  tip      <C-g>u\tip{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  tut      <C-g>u\tut{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  note     <C-g>u\note{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  hmm      <C-g>u\hmm{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  huh      <C-g>u\huh
    inoreabbr <buffer>  typ      <C-g>u\type{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer>  lgk      <C-g>u\logic{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer>  assume   <C-g>u\AssumeThis{Assume}
    inoreabbr <buffer>  stress   <C-g>u\Stressed{Stress}
    inoreabbr <buffer>  ref      <C-g>u\Refery{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  soo      <C-g>u\Context{}<left><C-g>u<C-R>=ES('\s')<cr>

    inoreabbr <buffer>  cbs      <c-g>u\cbstart<s-cr>
    inoreabbr <buffer>  cbe      <c-g>u\cbend<s-cr>
    inoreabbr <buffer>  cbse     <c-g>u\cbstart<s-cr><s-cr><c-g>u\cbend<c-r>=Anna_HAu()<cr><esc>kA<c-r>=Anna_RAu()<cr>   

    inoreabbr <buffer>  sk <Esc>:call LittleSketch()<cr>a\LittleSketch{0.9}{}{}<left><C-g>u<C-R>=ES('\s')<cr><Esc>|
    inoreabbr <buffer>  tr \MeTrying{}{}<left><left><left><C-g>u<C-R>=ES('\s')<cr>
    
    inoreabbr <buffer>  ft       <C-R>=ES('\s')<cr><C-g>u\footnote{}<C-g>u<c-r>=Anna_Mysp(1,'')<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>  ftt      <C-R>=ES('\s')<cr><C-g>u\footnote[]{}<C-g>u<c-r>=Anna_Mysp(1,'')<cr><c-r>=Anna_Mysp(2,'')<cr><C-R>=ES('\s')<cr>

    inoremap <silent>  <buffer>  $$    $$<C-g>u<C-R>=Anna_Mysp(1,1,'i')<cr><C-R>=ES('\s')<cr>
    "post dash
    inoreabbr <buffer>  q-    \TheQuestion{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  m-    $$<C-g>u<C-R>=Anna_Mysp(1,1,'i')<cr><C-R>=ES('\s')<cr>
    inoremap <silent> <buffer>  ##    <C-g>u\anaside{}<C-r>=Anna_Mysp(1,' ')<cr>
    inoreabbr <buffer>  dmm   <c-g>u\[%Display Math<s-cr>\]<Esc>O |
    inoreabbr <buffer>  say-  <Esc>:BeginGrouping Say<cr>i\Context{}<left><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  try-  <Esc>:BeginGrouping Try<cr>A
    inoreabbr <buffer>  g-    <Esc>:BeginGrouping ''<cr><C-g>u<C-R>=ES('\s')<cr>
    inoreabbr <buffer>  genum-    <Esc>:BeginGrouping LabelLater<cr>a<C-g>u<c-r>=ANE('enumerate',2)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  gitm-     <Esc>:BeginGrouping LabelLater<cr>a<C-g>u<c-r>=ANE('itemize',2)<cr><c-r>=ES('\s')<cr>
    inoreabbr <buffer>  sg-    <C-g>u<Esc>o<C-d>\subgroup[]<c-r>=Anna_Mysp(1,3)<cr><C-R>=ES('\s')<cr>
    inoreabbr <buffer>  sgg    <C-g>u<Esc>o<C-d>\subgroup<cr><C-R>=ES('\s')<cr>

    "shorttype
    "inoreabbr <buffer>  eq= equation<C-g>u<C-R>=ES('\s')<cr>

    "-Dash commands for quick environments and formatting
    inoreabbr <buffer> -g <Esc>:BeginGrouping blank<cr>A
    "inoreabbr <buffer> -a <C-g>u\begin{align}<cr>\end{align}<Esc>O  |
    inoreabbr <buffer> t- <Esc>:call NewTable()<cr>
    inoreabbr <buffer> -b <C-g>u\textbf{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -i <C-g>u\emph{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -u <C-g>u\underline{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -e <C-g>u{\inBlue }<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -d <C-g>u{\inRed }<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -y <C-g>u{\inGrey }<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>

    inoreabbr <buffer> -t <C-g>u\texttt{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -c <C-g>u\code{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> c- <C-g>u<Esc>o<Esc>gI\begin{lstlisting}%<cr>\end{lstlisting}<Esc>O<c-r>=ES('\s')<cr>
    inoreabbr <buffer> test- <C-g>u<Esc>o<Esc>gI\begin{TestMyCode}<cr>\end{TestMyCode}<Esc>O<c-r>=ES('\s')<cr>
    nnoremap <buffer> tt1 :call Anna_TestCode(1)<cr>
    nnoremap <buffer> tt0 :call Anna_TestCode(0)<cr>
    "inoreabbr <buffer> -k \keywrd{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    inoreabbr <buffer> -h <C-g>u\hl{}<C-r>=Anna_Mysp(1,' ')<cr><C-r>=ES('\s')<cr>
    "Greek letters
    "Mapped at DisableModes()
endfunction

"Defining environments
" let g:anna_env = {
"     \ 'align_star' : ['\begin{align*}','\end{align*}'],
"     \ 'align' : ['\begin{align}','\end{align}'],
"     \ 'enumerate' : ['\begin{enumerate}','\end{enumerate}'],
"     \ 'itemize' : ['\begin{itemize}','\end{itemize}'],
"     \
"     \ 'theorem' : ['\begin{Theorem}{}{}{}',
"     \'\Field{For  }{}%',
"     \'\Field{Let  }{}%',
"     \'\Field{If   }{}%',
"     \'\Field{Then }{}%',
"     \'\Field{Proof}{}%',
"     \'\end{Theorem}'],
"     \ 'properties' : ['\begin{Properties}{of the }{}{}',
"     \'\Field{Properties}{}%',
"     \'\Field{Where}{}%',
"     \'\Field{Proof}{}%',
"     \'\end{Properties}'],
"     \ 'definition' : ['\begin{Definition}{From now on\ldots}{}{}',
"     \'\Field{Term }{}%',
"     \'\Field{Means}{}%',
"     \'\end{Definition}'],
"     \ 'cdefinition' : ['\begin{cDefinition}{From now on\ldots}{}{}',
"     \'\Field{Term   }{}%',
"     \'\Field{Synonym}{}%',
"     \'\Field{Denoted}{}%',
"     \'\Field{Means  }{}%',
"     \'\end{cDefinition}'],
"     \ 'method' : ['\begin{Method}{}{}{}',
"     \'\Field{When}{}%',
"     \'\Field{Then}{}%',
"     \'\end{Method}'],
"     \ 'formula' : ['\begin{Formula}{}{}{}',
"     \'\Field{To find}{}%',
"     \'\Field{Where  }{}%',
"     \'\Field{Denoted}{}%',
"     \'\Field{Denoted}{}%',
"     \'\Field{Denoted}{}%',
"     \'\Field{You can}{}%',
"     \'\Field{Like so}{}%',
"     \'\end{Formula}']
" \}

function! ANE(type,id)
    "A New Environment
"    if match(mode(),'i') == -1
"	startinsert
"    endif

    if a:id == 3
	if !exists('g:anna_card_extras["'.a:type.'"]')
	    echoerr 'Note Type "'.a:type.'" is not defined'
	    return ''
	endif
    endif

    let l:is_card = 0
    if a:id == 3
	execute 'let l:snippet = g:anna_card_extras['."'".a:type."'".']'
	let l:is_card = 1
    else
	execute 'let l:snippet = g:anna_env["'.a:type.'"]'
    endif

    execute 'normal! i'."\<C-g>u"
    if a:id == 1
	let l:is_card = 1
    endif
    if l:is_card
	call Anna_DontPlaceMeBetween(g:anna_flashcard_search_string_b,g:anna_flashcard_search_string_e)
	execute 'normal! o'."\<Esc>0i".join(l:snippet,"\n")
	call search('\\begin','bW')
	execute 'normal! $i'.FlashCardID(a:type)
	"FlashCardTags() must be run after FlashCardID
	"
	if a:id == 1
	    execute 'normal! 03f{a'.FlashCardTags()
	elseif a:id == 3
	    execute 'normal! 04f{a'.FlashCardTags()
	endif

	execute 'normal! j0'."\<C-v>".(len(l:snippet)-3).'jI   '."\<Esc>j"
	call search('\\begin','bW')

	if a:id == 1
	    execute 'normal! $%i%'."\<cr>\<Esc>".'k02f}a'
	elseif a:id == 3
	    execute 'normal! $%i%'."\<cr>\<Esc>".'k03f}a'
	endif

	if a:type == 'vocab' || a:type == 'z-compare' || a:type == 'basic'
	    execute 'normal! '."\<down>\<down>A\<left>"
	else
	    call Anna_Mysp(0, "\<c-r>=Anna_FlashCardSkip()\<cr>")
	endif
    else "If not a card
	execute 'normal! a'."\<C-g>u".join(l:snippet,"\n")
	execute 'normal! ko     '
	if a:id == 2
	    execute "normal! a\<bs>\<bs>\<bs>\\item  "
	endif
    endif
    "execute 'normal! zza\<left>\<right>'
    return ''
endfunction
function! AutoCard_Images(ampath)
    if 0 == search('\\LittleSketch{')
	"No work for us. Return peacefully
	return ''
    endif

    if !IsValidAMpath(a:ampath)
	echoerr 'AMpath invalid. Cannot process pictures'
    endif

    let l:img_line = '<div class="little_sketch"><img width="97%" src="anna-IMG-ID.png" /><br><br><span class="pic_caption"><i>IMG-CAPTION</i></span></div>'
    let l:anki_media_dir = 'C:\Users\Tadiwa\AppData\Roaming\Anki2\Tadiwa@Anna\collection.media\'
    let l:curr_media_dir = '..\Media\'.a:ampath.'\'

    normal! gg
    while 0 != search('\\LittleSketch{', 'W')
	let l:img_caption = matchstr(getline('.'), '\\LittleSketch{.\{-}}{.\{-}}{\zs.\{-}\ze}')
	let l:img_id      = matchstr(getline('.'), '\\LittleSketch{.\{-}}{\zs.\{-}\ze}')
	let l:img_fname   = l:img_id.'.png'

	if 0 == strlen(l:img_id)
	    echom ' '
	    echom '----------------------------------------------------'
	    echom getline('.')
	    execute 'silent! s/\\LittleSketch{.\{-}}\({.\{-}}\)\=\({.\{-}}\)\=/\=l:img_html/'
	    write!
	    echom 'Could not locate image id on the line above.'
	    echom '\\LittleSketch removed.'
	    echom getline('.')
	    echom '----------------------------------------------------'
	    echom ' '
	    continue
	endif

	"echom '-----'
	call system('copy "'.l:curr_media_dir.l:img_fname.'" "'.l:anki_media_dir.'anna-'.l:img_fname.'"')
       "let l:img_width   = matchstr(getline('.'), '\\LittleSketch{\zs.\{-}\ze}')

	let l:img_html    = l:img_line
	let l:img_html    = substitute(l:img_html, 'IMG-ID',      l:img_id,      '')
	let l:img_html    = substitute(l:img_html, 'IMG-CAPTION', l:img_caption, '')
	"echom 'l:img_html = '.l:img_html
	execute 'silent! s/\\LittleSketch{.\{-}}{.\{-}}{.\{-}}/\=l:img_html/'
	write!
	normal! 0
    endwhile
endfunction

function! AutoCard(...)
    let l:append = a:0 ? (match(a:1, 'a\|1') != -1) : 0
    silent! LatexmkStop
    write
    redraw

    if !IsValidAMpath() && !GetCurrentAMpath()
	echom 'Cannot process images without valid AMpath'
	return 0
    else
	let l:ampath = b:ampath
    endif

    let l:separator = "\t"

    let l:old_dir = fnameescape(getcwd())
    set autochdir

    let l:old_buffer                                  = expand('%')
    let [l:ssss,l:line_was_at,l:column_was_at,l:ssss] = getpos('.')

    let l:fname         = expand('%:p:t').'-temp-'.RandLetter(3).'.txt'
    let l:dName         = substitute(expand('%:p:t'),'\.tex','','')
    let l:tempfilefname = l:fname
    execute 'silent! noswapfile saveas! '.l:fname
    "Remove comments
    :silent! %s/\\\@<!%.\+$//g
    let l:c = line('.')
    normal! Go%-------------------------------
    normal! ggO%------------------------------

    while 1
	let l:d = line('.')
	let l:next_b = search(g:anna_flashcard_search_string_b,'Wnc')
	if l:next_b != 0
	    let l:mov = l:next_b - l:d - 1
	    let l:mov_go_to = l:next_b - 1
	    if l:mov > 0
	    "l:next_b - l:d is at least 2
		execute 'silent! normal! '."\<S-v>".l:mov_go_to.'Gd'
	    elseif l:mov ==0
	    "l:next_b - l:d is exactly one, we can delete the current line
		silent! normal! dd
	    else
		"Either we didn't find a match or we _are_ on the match
	    "In any case, there's nothing required of us except to move on
	    endif
	    normal! k
	    let l:next_e = search(g:anna_flashcard_search_string_e,'W')
	    normal! j0
	else
	    silent! normal! dG
	    break
	endif
    endwhile
    "Remove %\n
    normal! gg0
    while search('\\Field{.\{-}}\zs{','Wc') != 0
	"normal %
	    call searchpair('{','','}','W')
	    silent! s/}\zs%\n/\r/
	    endwhile

	    "Now to rearrange
	    "Reposition tags and remove any remaining latex commands
    normal! gg0
    while search(g:anna_flashcard_search_string_b.'.\{-}\zs.%','Wc') != 0
	normal! yi{
	call search(g:anna_flashcard_search_string_e,'W')
	let l:taggy = @"
	let l:taggy = substitute(l:taggy,"'".'\|'.'"','','g')
	let l:taggy = substitute(l:taggy,'\\\([A-za-z]\{}\)\={\(.\{-}\)}\=','\2','g')
	let l:taggy = '{'.substitute(l:taggy,'\\#\|}','','g').'}'
	let @" = l:taggy
	normal! P
    endwhile

    "Get Title
    normal! gg0
    while search(g:anna_flashcard_search_string_b.'.\{-}\zs.%','Wc') != 0
	"while search(g:anna_flashcard_search_string_b.'\zs{','Wc') != 0
	normal! %hya}
	normal! j0
	call search('{.\{-}}\zs.','Wc')
	normal! P
    endwhile
    normal! gg0

    "Get the names of those custom flashcards
    let l:extrafiles = []
    let l:extrafiles_ext = []
    while search('\\begin{FlashCard}','Wc') != 0
	let l:newcardtype = matchstr(getline('.'),'\\begin{FlashCard}{\zs.\{-}\ze}')
	call add(l:extrafiles,    l:newcardtype)
	call add(l:extrafiles_ext,l:newcardtype.'.csv')
	s/{FlashCard}//
	normal! j0
    endwhile

    call uniq(l:extrafiles)
    call uniq(l:extrafiles_ext)
    "Delete fields
    execute 'silent! %s/\n.\{-}\\Field{.\{-}}//g'
    "Delete end tags
    execute 'silent! %s/}.\{-}'.g:anna_flashcard_search_string_e.'//g'
    "Replace begin tags with newline and triple hashes
    let l:modb = substitute(g:anna_flashcard_search_string_b,'FlashCard',join(l:extrafiles,'\\|'),'')
    execute 'silent! %s/'.l:modb.'.\{-}%/\#\#\#\#\1\#\#\#/g'
    "Delete comments. Latex comments work on full line. recall after this we will
    execute 'silent! %s/%.\{-}$//g'
    "Delete Separator, tabs and new lines
    execute 'silent! %s/'.l:separator.'\|\t\|\n//g'
    "Create some form of separation between cards (new lines)
    execute 'silent! %s/\#\#\#\#/\r\#\#\#/g'
    execute 'silent! %s/\\recall/<b>Recall</b>/g'
    
    "Process Images
    call AutoCard_Images(l:ampath)

    "Protect the }{ in frac{}
    execute 'silent! %s/\\frac{.\{-}\zs}{\ze.\{-}}/|||§||/g'
    execute 'silent! %s/\\[D,I][a,s]sx\?{.\{-}\zs}{\ze.\{-}}/|||§||/g'
    execute 'silent! %s/\\C{.\{-}\zs}{\ze.\{-}}/|||§||/g'
    execute 'silent! %s/\\\%(under\|over\)set{.\{-}\zs}{\ze.\{-}}/|||§||/g'
    execute 'silent! %s/\\begin{tabular\zs}{\ze/|||§||/g'
    execute 'silent! %s/\\setcounter{enumi*\zs}{\ze/|||§||/g' 
    execute 'silent! %s/\\raisebox{.\{-}\zs}{\ze.\{-}}/|||§||/g'
    "Convert to HTML before separating the fields
    silent! %s/}{\zs\(\_.\{-}\)\ze}{/\=Latex2HTML2(submatch(1),'')/g
    silent! %s/}{\zs\(\_.\{-}\)\ze}{/\=Latex2HTML(submatch(1),'tlmgp')/g
    silent! %s/}{\zs\(\_.\{-}\)\ze}{/\=Latex2HTML3(submatch(1),'')/g
    "Separate the fields
    execute 'silent! %s/}{/'.l:separator.'/g'
    "Undo the fractioning lol
    execute 'silent! %s/|||§||/}{/g'
    "Delete the (former begin...) open braces
    execute 'silent! %s/\#\#\#\zs{//g'
    "Remove the Definition (Vocab and Compare too) Title (Extra field)
    "Similar for Compare
    execute 'silent! %s/Vocab\#\#\#.\{-}'.l:separator.'\zs.\{-}'.l:separator.'//g'
    execute 'silent! %s/Compare\#\#\#.\{-}'.l:separator.'\zs.\{-}'.l:separator.'//g'
    execute 'silent! %s/Basic\#\#\#.\{-}'.l:separator.'\zs.\{-}'.l:separator.'//g'

    normal! gg0 

	    "mark the latex bits (environments, display math and inline math)
	    "we will line breaks to make it easier to identify what's already in [latex]
	    "tags what's not
	    "
	    "
	    "execute 'silent! %s/\(\\begin{\(.\{-}\)}\_.\{-}\\end{\2}\|\\\[\_.\{-}\\\]\|\$\_.\{-}\$\)/<br>[latex]\1[\/latex]\r||§|||<br>/g'
	    "execute 'silent! %s/\[latex\].\{-}\zs\$\(.\{-}\)\$\ze.\{-}\[\/latex\]/\\lgic{\1\\lgic{/g'
    ""execute 'silent! %s/\$\(.\{-}\)\$/[$]\1[\/$]/g'
    "execute 'silent! %s/\\lgic{/\$/g'
    ""Protecting latex commands if they're already in [latex] tags
    "execute 'silent! %s/\[latex\].\{-}\zs\\logic{\(.\{-}\)}\ze.\{-}\[\/latex\]/\\lgic{\1}/g'
    "execute 'silent! %s/\[latex\].\{-}\zs\\type{\(.\{-}\)}\ze.\{-}\[\/latex\]/\\tpe{\1}/g'
    "execute 'silent! %s/\[latex\].\{-}\zs\\textbf{\(.\{-}\)}\ze.\{-}\[\/latex\]/\\txtbf{\1}/g'
    "execute 'silent! %s/\[latex\].\{-}\zs\\emph{\(.\{-}\)}\ze.\{-}\[\/latex\]/\\mphiq{\1}/g'
    "execute 'silent! %s/\[latex\].\{-}\zs\\underline{\(.\{-}\)}\ze.\{-}\[\/latex\]/\\undrlin{\1}/g'
    ""Replacing the survivors with html equivalent
    "execute 'silent! %s/\\logic{\(.\{-}\)}/<span class="logic">\1<\/span>/g'
    "execute 'silent! %s/\\type{\(.\{-}\)}/<span class="type">\1<\/span>/g'
    "execute 'silent! %s/\\emph{\(.\{-}\)}/<em>\1<\/em>/g'
    "execute 'silent! %s/\\textbf{\(.\{-}\)}/<b>\1<\/b>/g'
    "execute 'silent! %s/\\underline{\(.\{-}\)}/<span style="text-decoration:underline;">\1<\/span>/g'
    ""Restoring 
    "execute 'silent! %s/\\lgic{/\\logic{/g'
    "execute 'silent! %s/\\tpe{/\\type{/g'
    "execute 'silent! %s/\\txtbf{/\\textbf{/g'
    "execute 'silent! %s/\\mphiq{/\\emph{/g'
    "execute 'silent! %s/\\undrlin{/\\underline{/g'
    ""piecing back the lines we split up
    "execute 'silent! %s/\[\/latex\]\zs\n||§|||\ze<br>//g'
    "execute 'silent! %s/<br>\[latex\]\$/[\$]/g'
    "execute 'silent! %s/\$\[\/latex\]<br>/[\/\$]/g'
    "Pad the file
    normal! Go
    normal! ggO
    w

    "Now to put these away
    "Trying to get course_code using method 1
    "let l:forward_slash_annadir = substitute(g:anna_dir,'\\','/','g')
    "let l:current_dir = substitute(expand('%:p:h'),'\\','/','g')
    "let l:current_dir_tail = substitute(l:current_dir,l:forward_slash_annadir.'/','','')
    "let l:course_code = split(l:current_dir_tail,'/')[0]
    "Simpler method
    let l:course_code = expand('%:p:h:h:t')

    let l:cardstore = fnameescape(substitute(g:anna_dir,'\\','/','g').'/'.l:course_code.'/FlashCards')
    if !isdirectory(l:cardstore)
	call mkdir(l:cardstore)
    endif

    let l:cardstore = fnameescape(substitute(g:anna_dir,'\\','/','g').'/'.l:course_code.'/FlashCards/'.l:dName)
    if !isdirectory(l:cardstore)
	call mkdir(l:cardstore)
    endif

    set noautochdir
    execute 'cd '.l:cardstore
    if join(reverse(split(substitute(getcwd(),'\\','/','g'),'/'))[0:1],'/') !=# l:dName.'/FlashCards'
	echoerr ':( Could not change to FlashCards Directory at [Course]/FlashCards/'.l:dName
	return ''
    endif

    let l:cardfiles = extend(['questions.csv', 'compare.csv', 'vocab.csv', 'steps.csv', 'basic.csv', 'action.csv'], l:extrafiles_ext, )
    let l:cardfiles_with_changes = []

    for l:cardfile in l:cardfiles
	"echom 'l:append = '.l:append.' at '.l:cardfile

	let l:card_candidates = []
	let l:cardtype = substitute(l:cardfile,'....$','','g')

	"Assuming 4 char extension
	if !filereadable(l:cardfile)
	    call writefile([],l:cardfile)
	endif
	normal! gg

	while (0 != search('\c\#\#\#'.l:cardtype.'\#\#\#','W'))
	    call add(l:card_candidates,getline(line('.')))
	endwhile

	"echom string(l:card_candidates)

	if !empty(l:card_candidates) 
	    execute 'silent! e! '.l:cardfile
	    normal gg
	    silent! s/^\(\s\|,\)\n//g
	    write!
	    set noreadonly
	    if !l:append
		normal! ggVGd
		write!
	    endif

	    for l:candidate in l:card_candidates
		let l:candidate = substitute(l:candidate,'\c\#\#\#'.l:cardtype.'\#\#\#','','')
		normal! gg

		if (0 == search('\m'.escape(l:candidate,'$.*~\^[]'),'Wn'))
		    execute 'normal! O'."\<c-r>=l:candidate\<cr>"
		    call add(l:cardfiles_with_changes,l:cardtype)
		    write!
		endif
	    endfor
	endif
	    silent! %s/^\t\+\n\=//g
	    normal! ggOrandom 
	    normal! j
	    let l:num_fields = 0

	    while search(l:separator,'', line('.'))
		let l:num_fields += 1
	    endwhile
	    let l:blank_line = repeat("\t", l:num_fields)

	    normal!gg
	    s/^.\{-}\ze$/\=l:blank_line/g
	    "echom 'tmp_fname = '.l:tempfilefname
	    write!
	    execute 'noswapfile b '.l:tempfilefname
    endfor

if !empty(l:cardfiles_with_changes)
    let l:msg = 'New '.join(uniq(l:cardfiles_with_changes),', ').' cards for '.l:course_code
    let @* = l:msg
    let l:anki_dir = fnameescape(substitute(g:anna_dir,'\\','/','g').'/anna-global/')

    if filereadable(l:anki_dir.'Anki.lnk')
	let l:cardfiles_with_changes = uniq(l:cardfiles_with_changes)

	for l:cardfaira in l:cardfiles_with_changes
	    let l:cardfilename = substitute(l:cardstore.'/'.l:cardfaira.'.csv','\\','/','g')
	    echom '@'.getcwd()
	    execute 'silent! !'.l:anki_dir.'Anki.lnk -p Tadiwa@Anna '.l:cardfilename
	endfor
    endif

    echom l:msg
else
   echom ':) AutoCard generator is done but no new cards were found'
endif

execute 'silent! bdelete '.escape(l:tempfilefname,' ').' '.join(l:cardfiles,' ')
set noautochdir
execute 'cd '.l:old_dir
execute 'b! '.l:old_buffer
call delete(l:old_dir.'\' .escape(l:tempfilefname,' '))
call delete(l:old_dir.'\.' .escape(l:tempfilefname.'.swp',' '))
call delete(l:old_dir.'\.'.escape(l:tempfilefname.'.un~',' '))
echom l:old_dir.'/' .escape(l:tempfilefname,' ')
echom l:old_dir.'/.'.escape(l:tempfilefname.'.un~',' ')
call cursor(l:line_was_at,l:column_was_at)
endfunction

function! Rib(search,ob,cb,flags)
"Return inside bracket
let [l:buff,l:line,l:col,l:off] = getpos('.')
let [l:section_line,l:bcol] = searchpos(a:search.a:ob.'\zs.',a:flags)
if l:section_line != 0
   call cursor(l:section_line,l:bcol)
   let [l:lnum,l:ecol] = searchpairpos(a:ob,'',a:cb,'cW','',l:section_line)
   "let l:extract = matchstr(getline(l:section_line),'\c\\section\*\={\zs.\{-}\ze}')
   call cursor(l:line,l:col)
   if l:lnum == l:section_line
      return [strpart(getline(l:lnum),l:bcol-1,l:ecol-l:bcol),l:section_line]
   endif
endif
return ['',0]
endfunction

function! FlashCardTags()
let l:tags  =['\#'.b:course_code]

let [l:extract,l:part_line] = Rib('\c\\part','{','}','bnW')
if !empty(l:extract)
   call add(l:tags,'\#'.substitute(l:extract,' \|\n\|\t','-','g'))
endif

let [l:extract,l:section_line] = Rib('\c\\section','{','}','bnW')
if !empty(l:extract)
   call add(l:tags,'\#'.substitute(l:extract,' \|\n\|\t','-','g'))
endif

let [l:extract,l:subsection_line] = Rib('\c\\subsection','{','}','bnW')
if !empty(l:extract) && l:subsection_line > l:section_line
   call add(l:tags,'\#'.substitute(l:extract,' \|\n\|\t','-','g'))
endif

let [l:extract,l:subsubsection_line] = Rib('\c\\subsubsection','{','}','bnW')
if !empty(l:extract) && l:subsubsection_line > l:subsection_line
   call add(l:tags,'\#'.substitute(l:extract,' \|\n\|\t','-','g'))
endif

let l:result = substitute(join(l:tags, ' '), ',\|\.', '-', 'g')
return substitute(l:result, '-\{2,}', '-', 'g')
endfunction

function! RandLetter(n)
let l:n = 0
let l:rand = ''
while l:n < a:n
   let l:n +=1
   let l:rand .= nr2char(float2nr(65 + ceil(str2nr(reltimestr(reltime())[-2:])*25/100)),1)
endwhile
return l:rand
endfunction

function! FlashCardID(type)
let l:c = line('.')    
let l:col = col('.')
execute 'normal! gg/\\lecture'."\<cr>".'f{yi{'
let b:course_code = printf('%.12s',substitute(@",'.\{8}\zs.\{-}','',''))
let l:card_type = a:type[0]
execute l:c
let l:numfile = fnameescape(g:anna_dir).'/anna-global/.annacardnumber'
if !filereadable(l:numfile)
   call writefile([100],l:numfile)
   execute 'normal! O% Could not find the .annacardnumber file. A new .annacardnumber file has been generated starting at ID 101'
   execute 'normal! o% You may lose your old Anki cards if a new card is created with the same ID!!'
   call cursor(l:c,l:col)
endif
let l:number = printf('%03d',str2nr(readfile(l:numfile,'',1)[0])+1)
call writefile([l:number],l:numfile)
return toupper(b:course_code.l:card_type.RandLetter(2)).l:number
endfunction

"Commands
:command! -nargs=1 -complete=customlist,CourseCodeComplete NewLecture call NewLecture("<args>")
:command! -nargs=1 TabuPlus call TabuPlus("<args>")
:command! -nargs=1 NewNoteType call NewNoteType("<args>")
:command! -nargs=1 Card call ANE("<args>",3)
:command! NewSketch call NewSketch()
"trying to keep a /^The/ in the next three
:command! ThenBreakStarted call BreakNow() 
:command! ThenBreakOver call BreakOver()
:command! BackDate call BackDate()
:command! TheEnd call TheEnd()
:command! -nargs=1 BeginGrouping call BeginGrouping("<args>")
:command! MathMode call Anna_mathModeOn()
:command! ClearMaps call Anna_ClearMaps()
:command! -nargs=? AutoCard call AutoCard(<f-args>)
:command! TabConceal call TabConceal()

"More Functions
function! Anna_ChooseFunction()
let l:n = matchstr(getline('.'),' \zs.\{-}\ze §',col('.')-6)
call setline(line('.'),substitute(getline('.'),'\zs.\{-}§','','g'))
return '\Ch{'.l:n.'}{}'
endfunction

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

function! NewNoteType(name)
    if Confirm('Create new flashcard note type called "'.a:name.'"?') == 0
         echoerr 'Aborted '.a:name
    return ''
    endif
    let l:field_c = 0
    let l:longest = 0
    let l:fields = []
    echo 'Field name entry time. Enter blank field name to finish.'
    while 1
        let l:field_c += 1
        let l:field_n = input('Field '.l:field_c.': ')
        if empty(l:field_n) 
           break
        endif
        call add(l:fields,l:field_n)
        if len(l:field_n) > l:longest
           let l:longest = len(l:field_n)
        endif
    endwhile
    let l:store = ['let g:anna_card_extras["'.a:name.'"] = [',
                \ ' \ '."'".'\begin{FlashCard}{'.a:name.'}{}{}{}'."'"]
    let l:card = ['\begin{FlashCard}{'.a:name.'}{}{}{}']
        for l:field in l:fields
            let l:spaces = repeat(' ',l:longest - len(l:field)+1)
            call add(l:card,                    '\Field{'.l:field.l:spaces.'}{}%')
            call add(l:store,'         \, '."'".'\Field{'.l:field.l:spaces.'}{}%'."'")
        endfor
    call add(l:card,            '\end{FlashCard}')
    call add(l:store,' \, '."'".'\end{FlashCard}'."'")
    call add(l:store,'\ ]')
    call add(l:store,'')
    let g:anna_card_extras[a:name] = l:card
    
    if !isdirectory('../FlashCards')
         call mkdir('../FlashCards')
    endif
    
    call writefile(l:store,g:anna_card_extras_store,'a')
    silent! call ANE(a:name,3)
    return ''
endfunction

function! IsValidAMpath(...)
    let l:t_ampath = a:0 ? a:1 : 'b:ampath'

    if (match(l:t_ampath, ':') != -1) && exists(l:t_ampath)
	execute 'let l:ampath = '.l:t_ampath
    else
	let l:ampath = l:t_ampath
    endif

    if (match(l:ampath,'^\f*$') != -1) && isdirectory('../Media/'.l:ampath)
	return 1
    else
	return 0
    endif
endfunction

function! GetCurrentAMpath()
    if IsValidAMpath()
	return b:ampath
    endif

    let l:ampath = matchstr(getline(search('\C\\AMpath{','n')),'\C\\AMpath{\zs.\{-}\ze}')
    if !empty(l:ampath) && !isdirectory('../Media/'.l:ampath)
	call mkdir('../Media/'.l:ampath, 'p')
    endif
    
    if (match(l:ampath,'^\f\+$') != -1) && isdirectory('../Media/'.l:ampath)
	let b:ampath = l:ampath
	return b:ampath
    endif

    echoerr 'Failed to set up AMpath :('
    return 0
endfunction

function! NewSketch()
    if !GetCurrentAMpath()
	return 0
    endif
let l:ParentMediaDir = expand('%:p:h:h').'/Media'
let l:MediaPath = l:ParentMediaDir.'/'.b:ampath
"echom l:MediaPath
let l:sketch_fn = l:MediaPath.'/'.b:ampath.'.aphalina'
if !isdirectory(l:MediaPath)
   echom l:MediaPath
   echoerr 'Seems AMpath does not exist in the directory ../../Media?'
   return ''
endif
if filereadable(l:sketch_fn)
   execute 'silent! !'.l:sketch_fn
else
   call writefile(readfile(l:ParentMediaDir.'/blank.aphalina','b'),l:sketch_fn,'b')
   execute 'silent! !'.l:sketch_fn
endif
endfunction

function! LMM(map)
if g:anna_math_mode_status == 1
   "call Anna_HAu()
   "execute 'normal! i'.a:map."\<right>"
   "call Anna_RAu()
   return a:map."\<left>\<right>"
else
   return '$'.a:map.'$'
endif
endfunction

function! LBMa(map,pre,post)
"Live Bracket Mappings for arrays
if InsideBracket()
   return       a:map
else
   return a:pre.a:map.a:post
endif
endfunction

function! InsideBracket()
"if Inside Bracket
   let l:accum = 0
   let l:c     = line('.')
   let l:store = [['(',')'],['{','}'],['\[','\]']]
   let l:max   = len(l:store)
   let l:i     = 0

   while l:accum == 0
      let l:accum = searchpair(l:store[l:i][0],'',l:store[l:i][1],'cn','',l:c)
      let l:i += 1
      if l:i == l:max
         break
      endif
   endwhile

   if l:accum == 0
      return 0  
   else
      return 1
   endif
endfunction

function! LatexTextModeGreekMap()
"Not Greek but will put here nonetheless
inoreabbr <buffer> nabla <C-]><c-r>=LMM('\nabla')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> ~     <C-]>\textasciitilde<C-R>=ES('\s')<cr>
"Ordinals
inoreabbr <buffer> 0th	<c-]><c-r>=LMM('0^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 1st	<c-]><c-r>=LMM('1^{\text{st}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 2nd	<c-]><c-r>=LMM('2^{\text{nd}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 3rd	<c-]><c-r>=LMM('3^{\text{rd}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 4th	<c-]><c-r>=LMM('4^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 5th	<c-]><c-r>=LMM('5^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 6th	<c-]><c-r>=LMM('6^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 7th	<c-]><c-r>=LMM('7^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 8th	<c-]><c-r>=LMM('8^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 9th	<c-]><c-r>=LMM('9^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> 10th	<c-]><c-r>=LMM('10^{\text{th}}')<cr><C-R>=ES('\s')<cr>
"
inoreabbr <buffer> ith	<c-]><c-r>=LMM('i^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> jth	<c-]><c-r>=LMM('j^{\text{th}}')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> kth	<c-]><c-r>=LMM('k^{\text{th}}')<cr><C-R>=ES('\s')<cr>
"
"Greek letters
inoreabbr <buffer> Pi <C-]><c-r>=LMM('\Pi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> pi <C-]><c-r>=LMM('\pi')<cr><C-R>=ES('\s')<cr>
"
inoremap <silent> <buffer> `a <C-]><c-r>=LMM('\alpha')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `B <C-]><c-r>=LMM('B')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `b <C-]><c-r>=LMM('\beta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `G <C-]><c-r>=LMM('\Gamma')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `g <C-]><c-r>=LMM('\gamma')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `D <C-]><c-r>=LMM('\Delta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `d <C-]><c-r>=LMM('\delta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `E <C-]><c-r>=LMM('E')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `e <C-]><c-r>=LMM('\varepsilon')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Z <C-]><c-r>=LMM('Z')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `z <C-]><c-r>=LMM('\zeta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `H <C-]><c-r>=LMM('H')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `h <C-]><c-r>=LMM('\eta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Th <C-]><c-r>=LMM('\Theta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `th <C-]><c-r>=LMM('\theta')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `I <C-]><c-r>=LMM('I')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `i <C-]><c-r>=LMM('\iota')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `K <C-]><c-r>=LMM('K')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `k <C-]><c-r>=LMM('\kappa')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `L <C-]><c-r>=LMM('\Lambda')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `l <C-]><c-r>=LMM('\lambda')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `M <C-]><c-r>=LMM('M')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `m <C-]><c-r>=LMM('\mu')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `N <C-]><c-r>=LMM('N')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `n <C-]><c-r>=LMM('\nu')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Xi <C-]><c-r>=LMM('\Xi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `xi <C-]><c-r>=LMM('\xi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `O <C-]><c-r>=LMM('O')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `o <C-]><c-r>=LMM('o')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Pi <C-]><c-r>=LMM('\Pi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `pi <C-]><c-r>=LMM('\pi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `P <C-]><c-r>=LMM('P')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `p <C-]><c-r>=LMM('\rho')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Rho <C-]><c-r>=LMM('P')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `rho <C-]><c-r>=LMM('\rho')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `S <C-]><c-r>=LMM('\Sigma')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `s <C-]><c-r>=LMM('\sigma')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `T <C-]><c-r>=LMM('T')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `t <C-]><c-r>=LMM('\tau')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `U <C-]><c-r>=LMM('\Upsilon')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `u <C-]><c-r>=LMM('\upsilon')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Ph <C-]><c-r>=LMM('\Phi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `ph <C-]><c-r>=LMM('\phi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Ps <C-]><c-r>=LMM('\Psi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `ps <C-]><c-r>=LMM('\psi')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `Om <C-]><c-r>=LMM('\Omega')<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> `om <C-]><c-r>=LMM('\omega')<cr><C-R>=ES('\s')<cr>
                                                               
inoreabbr <buffer> gPi <C-]><c-r>=LMM('\Pi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gpi <C-]><c-r>=LMM('\pi')<cr><C-R>=ES('\s')<cr>
                                                               
inoreabbr <buffer> ga <C-]><c-r>=LMM('\alpha')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gB <C-]><c-r>=LMM('B')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gb <C-]><c-r>=LMM('\beta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gG <C-]><c-r>=LMM('\Gamma')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gg <C-]><c-r>=LMM('\gamma')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gD <C-]><c-r>=LMM('\Delta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gd <C-]><c-r>=LMM('\delta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gE <C-]><c-r>=LMM('E')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> ge <C-]><c-r>=LMM('\varepsilon')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gZ <C-]><c-r>=LMM('Z')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gz <C-]><c-r>=LMM('\zeta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gH <C-]><c-r>=LMM('H')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gh <C-]><c-r>=LMM('\eta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gTh <C-]><c-r>=LMM('\Theta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gth <C-]><c-r>=LMM('\theta')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gI <C-]><c-r>=LMM('I')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gi <C-]><c-r>=LMM('\iota')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gK <C-]><c-r>=LMM('K')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gk <C-]><c-r>=LMM('\kappa')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gL <C-]><c-r>=LMM('\Lambda')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gl <C-]><c-r>=LMM('\lambda')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gM <C-]><c-r>=LMM('M')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gm <C-]><c-r>=LMM('\mu')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gN <C-]><c-r>=LMM('N')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gn <C-]><c-r>=LMM('\nu')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gXi <C-]><c-r>=LMM('\Xi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gxi <C-]><c-r>=LMM('\xi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gPi <C-]><c-r>=LMM('\Pi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gpi <C-]><c-r>=LMM('\pi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gP <C-]><c-r>=LMM('P')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gp <C-]><c-r>=LMM('\rho')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gRho <C-]><c-r>=LMM('P')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> grho <C-]><c-r>=LMM('\rho')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gS <C-]><c-r>=LMM('\Sigma')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gs <C-]><c-r>=LMM('\sigma')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gT <C-]><c-r>=LMM('T')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gt <C-]><c-r>=LMM('\tau')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gU <C-]><c-r>=LMM('\Upsilon')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gu <C-]><c-r>=LMM('\upsilon')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gPh <C-]><c-r>=LMM('\Phi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gph <C-]><c-r>=LMM('\phi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gPs <C-]><c-r>=LMM('\Psi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gps <C-]><c-r>=LMM('\psi')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gOm <C-]><c-r>=LMM('\Omega')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer> gom <C-]><c-r>=LMM('\omega')<cr><C-R>=ES('\s')<cr>
endfunction

"function! DvDt()
"let l:dvdt = input('Derivative: ','d')
"let l:raised = substitute(l:dvdt,'\D\zs\d','\^\0','g')
"execute 'normal! li'"\<C-g>u".l:raised."\<Esc>a}\<Esc>Fdi}{\<Esc>Fdi\\frac{\<Esc>2f}a \<right>"
"startinsert
"endfunction

function! Anna_DontPlaceMeBetween(start,end)
    "Clean up space first; in case the space was only for abbreviations
    execute "normal! i\<C-R>=ES('\\s')\<cr>"
    let l:e = search(a:end,'Wn')
    if l:e == 0
    elseif l:e > line('.')
       "end of group after current line. ,must check begin of group
	let l:b = search(a:start,'Wn')
        if l:b == 0 || l:b > l:e
           "probably in a group
            execute l:e
        "else
            "probably in between groups
        endif
    endif
    return ''
endfunction

function! BeginGrouping(type)
    call Anna_DontPlaceMeBetween('\\begin{grouping}','\\end{grouping}')
    if a:type ==# 'blank'
       let l:type = ''
    else
       let l:type = '['.substitute(a:type,'.',toupper(a:type[0]),'').']'
    endif

    execute "normal! i\<C-g>u"
    execute 'normal! o\begin{grouping}'.l:type."\<s-cr>\\end{grouping}\<Esc>O    \<Esc>$"
    if a:type ==# "''"
       normal! ddk$di[$
       call Anna_Mysp(0,3)
       startinsert
    endif
    return ''
endfunction

function! Anna_GroupTitle()
    silent! normal! 0f[di[
    let l:title = @"
    let l:thetitle = toupper(l:title[0]).strcharpart(l:title,1,strlen(l:title)-1)
    return l:thetitle
endfunction

function! AnnaProcessMedia()
silent! nunmap <buffer> <cr>
let l:clip = @*
let l:from = fnameescape(l:clip)
echom l:from
    if !filereadable(l:from)
       normal! I%
       normal! o
       echoerr 'Error! Try again'|"'Cannot read file at: "'.l:clip.'". Try again.'
       return ''
    endif
let l:anna_dir = escape(g:anna_dir,'\')
"remove base directory bit
let l:fname1 = substitute(l:clip,'\c'.l:anna_dir,'','')
"remove anna-randoms bit
let l:fname2 = substitute(l:fname1,'\c'.'anna-randoms\|sketches','','g')
"remove slashes to remain with file name
let l:fname = substitute(l:fname2,'/\|\','','g')
"return l:fname
let l:to = fnameescape(expand('%:p:h').'/../Media/'.expand('%:t:r').'/'.l:fname)
    if filereadable(l:to)
    echoerr 'Sketch with same name already exists. Try again'
    return ''
else
    call rename(l:from,l:to)
    return substitute(l:fname,'.png','','g')
endif
endfunction

function! LittleSketch()
nnoremap <buffer> <cr> 2hci{<C-r>=AnnaProcessMedia()<cr><Right><Right>
endfunction

function! Anna_listModeEnter()
  inoremap <silent>  <buffer> <cr> <C-g>u <C-r>=Anna_HAu()<cr><C-]><Esc>o\item <c-r>=Anna_RAu()<cr><c-r>=Anna_listModeEnter()<cr>
  "Space at the end of the line (the one after <C-g>u) helps syntax for Enum to work properly
  "Recalling Anna_listModeEnter() is sorta a workaround. It seems <cr> gets
  "unmapped after one use. Recalling helps keep the mapping around
  return ''
endfunction

function! Anna_listModeOn()
  inoreabbr <buffer> -- \item
endfunction

function! Anna_listModeOff()
  silent! iunabbr <buffer> --
endfunction

function! Anna_FlashCardSkip()
    call Anna_HAu()
    let l:boundary = search(g:anna_flashcard_search_string_e,'nWz')
    let l:line = search('\\Field{.\{-}}{.\{-}\zs}','Wz',l:boundary)
    return ''
    call Anna_RAu()
"    let l:line = search('\\Field{.\{-}}{.\{-}}\zs','Wz',l:boundary)
"    if l:line != 0 
"	execute 'silent! normal! '.l:line.'G0fFf{f{a'."\<C-g>".'u'."\<right>"
"    endif
"    inoremap <silent> <buffer> <s-cr> <c-r>=Anna_HAu()<cr><c-r>=Anna_FlashCardSkip()<cr><c-r>=Anna_RAu()<cr>
"    call Anna_RAu()
"    return ''
endfunction

function! Anna_FlashCardModeEnter()
return ''
endfunction

function! Anna_FlashCardModeOn()
inoremap <silent> <buffer> <s-cr> <c-]><c-g>u<c-r>=Anna_HAu()<cr><c-r>=Anna_FlashCardSkip()<cr><c-r>=Anna_RAu()<cr>
inoreabbr  dm-   <c-g>u\[%Display Math<cr><cr>\]<left><left><left><Up>    |
"iabbr  enum  <c-g>u<c-b>enumerate<cr>  \item|
"iabbr  itm   <c-g>u<c-b>itemize<cr>  \item|
inoreabbr <buffer>  sk <Esc>:call LittleSketch()<cr>a\LittleSketch{0.7}{}{}<left><C-g>u<C-R>=ES('\s')<cr><Esc>|
endfunction

function! Anna_FlashCardModeOff()
iunmap <buffer> <s-cr>
inoreabbr  dm-   <c-g>u\[%Display Math<s-cr>\]<Esc>O |
inoreabbr  enum     <c-r>=ANE('enumerate',2)<cr><c-r>=ES('\s')<cr>
inoreabbr  itm      <c-r>=ANE('itemize',2)<cr><c-r>=ES('\s')<cr>
inoreabbr <buffer>  sk <Esc>:call LittleSketch()<cr>a\LittleSketch{0.9}{}{}<left><C-g>u<C-R>=ES('\s')<cr><Esc>|
endfunction
function! Anna_PythonColon(old,new)
    call Anna_HAu()
    set paste
    let l:tbe = a:old * !a:new * g:anna_code_mode_status * (match(getline('.'), ':$') != -1) ? '    ' : ''
    let l:tbe .= a:old * !a:new * g:anna_code_mode_status ? matchstr(getline('.'),'^\s*\zs#\s*') : ''
    "let l:tbf = match(getline('.'),'^\s*$') != -1 ? '' : matchstr(getline(line('.')),'^\s*')
	execute 'normal! o'.matchstr(getline(line('.')),'^\s*').l:tbe
	call Anna_RAu()
	startinsert!
endfunction

function! Anna_codeModeEnter()
    set pastetoggle=<cr>
    set paste
endfunction

function! Anna_codeModeOn()
    call DisableModes(['code'])
    augroup PasteMode
	au!
	au OptionSet paste :call Anna_PythonColon(v:option_old, v:option_new)
	au CursorMovedI *.tex call DisableModes(['code'])
    augroup END
endfunction

function! Anna_codeModeOff()
    augroup PasteMode
	au!
    augroup END
    set pastetoggle=
    set nopaste
endfunction

function! Anna_mathModeEnter()
inoremap <silent> <buffer> <cr> <C-]><c-r>=Anna_HAu()<cr><c-g>u<Esc>A<space>\\<Esc>:TabConceal<cr>o<c-r>=Anna_RAu()<cr>|
return ''
endfunction

function! Anna_MapNextChar(type)
if a:type ==# '&'
   call Anna_HAu()
   let l:char = getchar()
   let l:char = nr2char(l:char)
   if l:char ==# ' ' | return ' ' | endif
   call TabConceal()
   call add(b:my_math_maps,l:char)
   execute 'inoremap <silent> <buffer> '.l:char.' <c-r>=Anna_HAu()<cr><c-r>=LBMa("'.l:char.'","&"," ")<cr>§<Esc>:TabConceal<cr>0f§i<del><c-r>=Anna_RAu()<cr>'
   call cursor(searchpos('§','c',line('.')))
   "execute 'normal! f§i'."\<del>".l:char.'  '
   call Anna_RAu()
   return ''
endif
endfunction

function! TabuPlus(pattern)
   call Anna_HAu()
   call TabConceal()
   call Anna_RAu()
   normal! $
   return ''
endfunction

function! MapAllThese(items,using)
"Used to pass elements of a:items to the func called a:using
    for item in a:items
        if type(item) == 3
	   call call(a:using,item)
	else
	   call call(a:using,[item])
	endif
    endfor
endfunction

function! AnnaDO(operator,...)
"Anna Declare Operator
"Used to make abbreviations for math operators
"a:operator is the operator without the backslash
"Optional 2nd argument overides lhs bit of the mapping
    let l:lhs = (a:0 == 0) ? a:operator : a:1 
    execute 'inoreabbr <buffer> '.l:lhs.' <C-]>\'.a:operator.'<left><right><c-g>u'
endfunction

function! AnnaUO(operator,...)
    let l:lhs = (a:0 == 0) ? a:operator : a:1 
    execute 'iunabbr <buffer> '.l:lhs
endfunction

function! Anna_mathSpaceOff(shift)
    augroup Anna_mathSpaceAutoOff
	au!
    augroup END

    execute 'iunmap <buffer> <'. (a:shift ? 'S-' : '') . 'Space>'
    return ''
endfunction

function! Anna_mathSpaceOn(shift, ...)
    if a:0 ? a:1 : 0
	augroup Anna_mathSpaceAutoOff
	    au!
	    execute 'au! TextChangedI *.tex call Anna_mathSpaceOff('.a:shift.')'
	augroup END
    endif

    let l:switch_off = ''
    "a:0 ? (a:1 ? '<c-r>=Anna_mathSpaceOff('.a:shift.')<cr>' : '') : ''
    execute 'inoremap <silent> <buffer> <'. (a:shift ? 'S-' : '') . 'Space> <c-g>u\ '.l:switch_off
    return ''
endfunction

function! Anna_mathModeOn()
call MapAllThese(g:amp_operators,'AnnaDO')
inoreabbr <buffer> del <c-g>u§\partial<c-r>=Anna_Mysp(0,6,'\partial')<cr>
inoreabbr <buffer> dd  <c-g>u§d<c-r>=Anna_Mysp(0,6,'d')<cr>

call Anna_mathSpaceOn(1)
inoremap <silent> <buffer> , <c-g>u,<c-r>=Anna_mathSpaceOn(0, 1)<cr>

inoremap <silent> <buffer> ~ \tild |
inoreabbr <buffer> iee <c-g>u<End> \qquad\qquad\text{()}<c-r>=Anna_Mysp(2,5)<cr><C-R>=ES('\s')<cr>
inoremap <silent> <buffer> <c-p> <C-R>=EP('\s')<cr>§<c-r>=Anna_Mysp2(1,'')<cr>

inoreabbr <buffer> inf <c-r>=LMM('\infty')<cr><c-r>=ES('\s')<cr>
inoremap <silent> <buffer> <C-e> <C-]><Left><Right>
"Letters are easier to reach... plus wouldn't want to press <C-[> by mistake
inoremap <silent> <buffer> <C-t> <Left><Right>

"We don't want to overide any alignment mapping made by Anna_MapNextChar(),
"hence the <unique>
for i in ['=','-','+']
    if empty(maparg(i,'i'))
         execute 'inoremap <unique> <silent> <buffer> '.i.' <C-]>'.i.'<Left><Right>'
    endif
endfor

iunabbr <buffer> '
"iunabbr <buffer> Pi
"iunabbr <buffer> pi 

inoreabbr not    \not<left><right><c-r>=ES('\s')<cr>
inoreabbr norm   \norm{}<c-r>=Anna_Mysp(1)<cr><c-r>=ES('\s')<cr>

inoreabbr circled \circled{}<c-r>=Anna_Mysp(1)<cr><c-r>=ES('\s')<cr>
inoreabbr ans \ans{}<c-r>=Anna_Mysp(1)<cr><c-r>=ES('\s')<cr>
inoreabbr tag \tag{}\\<left><left><left><c-r>=Anna_Mysp(0,4)<cr><c-r>=ES('\s')<cr>
inoreabbr tagg \tag*{}\\<left><left><left><c-r>=Anna_Mysp(0,4)<cr><c-r>=ES('\s')<cr>
inoremap <silent> -- <C-]><C-g>u<space>&<space><left><right>
inoremap <silent> ,+ <C-]><c-g>u<space>&§<c-r>=Anna_MapNextChar('&')<cr><del><del>+<space>
inoremap <silent> ,- <C-]><c-g>u<space>&§<c-r>=Anna_MapNextChar('&')<cr><del><del>-<space>
inoremap <silent> ,= <C-]><c-g>u<space>&§<c-r>=Anna_MapNextChar('&')<cr><del><del>=<space>
inoremap <silent> ,: <C-]><c-g>u<space>&§<c-r>=Anna_MapNextChar('&')<cr><del><del>:<space>
inoreabbr txt \text{}<c-r>=Anna_Mysp(1,5)<cr><C-R>=ES('\s')<cr>

inoreabbr vec   <C-g>u\vect{}<c-r>=Anna_Mysp(1,1,'v')<cr><C-R>=ES('\s')<cr>
inoreabbr per   <C-r>=ES('\s')<cr>/<C-r>=ES('\s')<cr>
inoremap  <C-d> <Esc>:call DvDt()<cr>
"inoremap <silent>  /       <C-]><c-g>u<c-r>=Anna_HAu()<cr>}{}§<Esc>F a\frac{<Esc>f§xi<c-r>=Anna_Mysp(1,1)<cr><c-r>=Anna_RAu()<cr>
inoremap <silent>  /        <C-]><c-g>u}{}§<c-r>=search(' ','b')?"\<lt>right>":''<cr><c-g>u\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
"inoremap <silent>  //      <C-]><c-g>u<c-r>=Anna_HAu()<cr>}{}§<Esc>F$a\frac{<Esc>f§xi<c-r>=Anna_Mysp(1,1)<cr><c-r>=Anna_RAu()<cr>
inoremap <silent>  //       <C-]><c-g>u}{}§<c-r>=search('$.*§','b')?"\<lt>right>":''<cr>\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
inoremap <silent>  //1     <C-]><c-g>u}{}§<c-r>=search(' \ze\%(.* .*\)\{1}§','b')?"\<lt>right>":''<cr>\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
inoremap <silent>  //2     <C-]><c-g>u}{}§<c-r>=search(' \ze\%(.* .*\)\{2}§','b')?"\<lt>right>":''<cr>\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
inoremap <silent>  //3     <C-]><c-g>u}{}§<c-r>=search(' \ze\%(.* .*\)\{3}§','b')?"\<lt>right>":''<cr>\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
inoremap <silent>  //4     <C-]><c-g>u}{}§<c-r>=search(' \ze\%(.* .*\)\{4}§','b')?"\<lt>right>":''<cr>\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
inoremap <silent>  //5     <C-]><c-g>u}{}§<c-r>=search(' \ze\%(.* .*\)\{5}§','b')?"\<lt>right>":''<cr>\frac{<c-r>=search('§')?'':''<cr><del><c-r>=Anna_Mysp(1,1)<cr>
"inoremap <silent>  //5     <C-]><c-g>u<c-r>=Anna_HAu()<cr>}{}§<Esc>6F a\frac{<Esc>f§xi<c-r>=Anna_Mysp(1,1)<cr><c-r>=Anna_RAu()<cr>

inoremap <silent>  \|>     <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>2F a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|>>    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>F$a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|>1    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>3F a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|>2    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>4F a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|>3    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>5F a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|>4    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>6F a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|>5    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>7F a\left. <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|<     <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right.§<Esc>2F a\left\| <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|<<    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right.§<Esc>2F$a\left\| <Esc>f§i<del><c-r>=Anna_RAu()<cr>
inoremap <silent>  \|<>    <C-]><c-g>u<c-r>=Anna_HAu()<cr> \right\|§<Esc>2F a<bs>\left\| <Esc>f§i<del><c-r>=Anna_Mysp(8,' ')<cr><c-r>=Anna_RAu()<cr>

"inoremap  !     \not
inoremap  *              <C-]>\times<left><right>
inoremap  <s-tab>        <C-]>\quad<left><right>
inoreabbr  upto          <C-g>u\ldots,<C-r>=ES('\s')<cr>

inoreabbr bar    <C-g>u\bar{}<C-r>=Anna_Mysp(1)<cr><C-r>=ES('\s')<cr>
inoreabbr hat    <C-g>u\hat{}<C-r>=Anna_Mysp(1)<cr><C-r>=ES('\s')<cr>
inoreabbr int    <C-g>u\int \ d<c-r>=Anna_Mysp(4)<cr>
inoreabbr intt   <C-g>u\int_{}^{}  \ d<c-r>=Anna_Mysp(4)<cr><c-r>=Anna_Mysp(2)<cr><c-r>=Anna_Mysp(3)<cr><C-r>=ES('\s')<cr>

inoreabbr <buffer>	root	\sqrt{}<c-r>=Anna_Mysp(1,1)<cr><c-r>=ES('\s')<cr>
inoreabbr <buffer>	sqrt	\sqrt{}<c-r>=Anna_Mysp(1,1)<cr><c-r>=ES('\s')<cr>
inoreabbr <buffer>	bb	\mathbb{}<C-g>u<c-r>=Anna_Mysp(1,' ')<cr><C-R>=ES('\s')<cr>
inoreabbr <buffer>	summ	<C-g>u\sum_{}^{}<c-r>=Anna_Mysp(1)<cr><c-r>=Anna_Mysp(3)<cr><C-r>=ES('\s')<cr>
inoreabbr <buffer>	prodd	<C-g>u\prod{}^{}<c-r>=Anna_Mysp(1)<cr><c-r>=Anna_Mysp(3)<cr><C-r>=ES('\s')<cr>
inoreabbr <buffer>	limm	<C-g>u\lim_{}<c-r>=Anna_Mysp(1,' ')<cr><C-R>=ES('\s')<cr>
                  	
inoremap <silent> <buffer> 	^ 	<C-]>^<c-r>=Anna_Mysp(0,1,'^')<cr>
inoremap <silent> <buffer> 	_ 	<C-]>_<c-r>=Anna_Mysp(0,1,'_')<cr>
inoremap <silent> <buffer> 	__	<C-]>_{}<C-g>u<c-r>=Anna_Mysp(1,1,'_')<cr>
inoremap <silent> <buffer> 	^^	<C-]>^{}<C-g>u<c-r>=Anna_Mysp(1,1,'^')<cr>
inoremap <silent> <buffer> 	_^	<C-]>_{}^{}<C-g>u<c-r>=Anna_Mysp(1,1,'_')<cr><c-r>=Anna_Mysp(3)<cr>
inoremap <silent> <buffer> 	^_	<C-]>^{}_{}<C-g>u<c-r>=Anna_Mysp(1,1,'^')<cr><c-r>=Anna_Mysp(3)<cr>

"inoremap <silent> <buffer>	()	<C-]>()<c-r>=Anna_Mysp(1)<cr>
"inoremap <silent> <buffer> 	(( 	<C-]>\left(  \right)<C-r>=Anna_Mysp(8)<cr>
"inoremap <silent> <buffer> 	[[ 	<C-]>\left[  \right]<C-r>=Anna_Mysp(8)<cr>
"inoremap <silent> <buffer> 	{{ 	<C-]>\left\{
"\right\}<C-r>=Anna_Mysp(9)<cr>
inoremap <silent> <buffer> 	)) 	<C-]>\left(  \right)<C-r>=Anna_Mysp(8)<cr>
inoremap <silent> <buffer> 	]] 	<C-]>\left[  \right]<C-r>=Anna_Mysp(8)<cr>
inoremap <silent> <buffer> 	}} 	<C-]>\left\{  \right\}<C-r>=Anna_Mysp(9)<cr>
inoremap <silent> <buffer> 	<bar><bar> 	<C-]>\left<bar>  \right<bar><C-r>=Anna_Mysp(8)<cr>
inoremap <silent> <buffer> 	<> 	<C-]>\langle  \rangle<c-r>=Anna_Mysp(8)<cr>

inoremap <silent> <buffer> )(       	  	<C-]>\right)
inoremap <silent> <buffer> ][       	  	<C-]>\right]
inoremap <silent> <buffer> }{       	  	<C-]>\right\}

endfunction

function! EnableAnna_AutosLoose()
    call Anna_HAu()
    augroup Anna_AutosLoose
	au!
	au InsertLeave  *.tex call DisableModes()
	au InsertLeave  *.tex call DisableAnna_AutosLoose()
    augroup END
    call Anna_HAu()
    return ''
endfunction

function! DisableAnna_AutosLoose()
    augroup Anna_AutosLoose
	au!
    augroup END
    "call Anna_RAu()
    "No need to call Anna_RAu() since Mysp2() will do that
    return ''
endfunction

function! Anna_mathModeOff(...)
   iunmap <buffer> ~
   iunabbr <buffer> iee
   iunmap <buffer> <c-p>
   call Anna_mathSpaceOff(1)
   iunmap <buffer> ,

if a:0 == 0 "We do NOT want to unmap these for \text{} etc.
   iunmap <buffer> <C-e>
   iunmap <buffer> <C-t>
   iunmap <buffer> +|
   iunmap <buffer> -|
   iunmap <buffer> =|
   
   for l:mapping in b:my_math_maps 
       execute 'silent! iunmap <buffer> '.l:mapping
   endfor
else "For \text{} etc., try to stay
    call EnableAnna_AutosLoose()
endif

let b:math_is_inline = 0

iunabbr not
iunabbr norm

iunabbr circled
iunabbr ans
iunabbr tag
iunabbr tagg
iunmap --
iunmap ,+
iunmap ,-
iunmap ,=
iunmap ,:
iunabbr txt

iunabbr vec
iunabbr per
iunmap /
iunmap //
iunmap //1
iunmap //2
iunmap //3
iunmap //4
iunmap //5
iunmap \|>
iunmap \|>>
iunmap \|>1
iunmap \|>2
iunmap \|>3
iunmap \|>4
iunmap \|>5
iunmap \|<
iunmap \|<<
iunmap \|<>

"iunmap !
iunmap *
iunmap <s-tab>
iunabbr upto

iunabbr bar
iunabbr hat
iunabbr int
iunabbr intt

iunabbr <buffer> root
iunabbr <buffer> sqrt
iunabbr <buffer> bb
iunabbr <buffer> summ
iunabbr <buffer> limm

iunmap <buffer> _
iunmap <buffer> __
iunmap <buffer> ^^
iunmap <buffer> _^
iunmap <buffer> ^_

"iunmap <buffer> ()
"iunmap <buffer> ((
"iunmap <buffer> [[
"iunmap <buffer> {{
iunmap <buffer> ))
iunmap <buffer> ]]
iunmap <buffer> }}
iunmap <buffer> <>

iunmap <buffer> )(
iunmap <buffer> ][
iunmap <buffer> }{

call MapAllThese(g:amp_operators,'AnnaUO')
call AnnaModeOn('text',0)
call AnnaModeOff('text')
endfunction

function! DisableModes(...)
let l:candidates = deepcopy(g:anna_modes)
if a:0 == 1 "For excluding modes from being disabled
    for l:item in a:1
	call filter(l:candidates, 'v:val !~ "'.l:item.'"')
    endfor
endif

for l:mode in l:candidates
    execute 'silent! call AnnaModeOff("'.l:mode.'")'
endfor

let b:Anna_NewTable = 0
let b:anna_se_sp = []
let b:anna_se_mv = []
let b:anna_se_ex = []
let b:display_math_mode_decision_made = 0
let b:math_is_inline = 0
let l:skip = a:0 == 2 ? a:2 : 0
let @_ = l:skip ? '' : Anna_ClearStack()
call uniq(b:my_anna_maps)
call uniq(b:my_anna_abbr)
return ''
endfunction

function! NewTable()
  execute "normal! a\<s-cr>   \\begin{tabular}{}\<s-cr>\\end{tabular}\<s-cr>\<Esc>kO\\bl \<Esc>$"
  let b:Anna_NewTable = 1
  startinsert
endfunction

function! Anna_table_mode_First_Enter()
    call Anna_Mysp(0,2)
endfunction

function! Anna_tableModeEnter()
inoremap <silent> <buffer> <cr> <C-]><C-g>u  \\<Esc>:TabConceal<cr>o\bl |
return ''
endfunction

function! Anna_tableModeOn(prev_b)
"Mappings
let b:prev_b = a:prev_b
inoremap <silent> <buffer> 'c <C-]><C-g>u & ┦<Esc>:call AnnaTableCountColumns(<c-r>=b:prev_b<cr>,'c')<Esc>0f┦s|
inoremap <silent> <buffer> 'l <C-]><C-g>u & ┦<Esc>:call AnnaTableCountColumns(<c-r>=b:prev_b<cr>,'l')<Esc>0f┦s|
inoremap <silent> <buffer> 'r <C-]><C-g>u & ┦<Esc>:call AnnaTableCountColumns(<c-r>=b:prev_b<cr>,'r')<Esc>0f┦s|
inoreabbr <buffer> md <c-]><C-g>u<c-r>=Anna_HAu()<cr>  \\<Esc>:TabConceal<cr>o\bl <Esc>kA \midrule<Esc>jA<c-r>=Anna_RAu()<cr>
inoreabbr <buffer> hr <c-]><C-g>u<c-r>=Anna_HAu()<cr>  \\<Esc>:TabConceal<cr>o\bl <Esc>kA \hline<Esc>jA<c-r>=Anna_RAu()<cr>
endfunction

function! Anna_BeginEnvironmentEnter()
inoremap <silent> <buffer> <cr> <c-r>=Anna_NormalEnter()<cr><Esc>yi{/end{}<cr>f{pO   |
return ''
endfunction

function! Anna_NormalEnter()
inoremap <silent> <buffer> <cr> <C-g>u<Esc>o
return ''
endfunction

function! Anna_textModeEnter()
inoremap <silent> <buffer> <cr> <C-g>u<Esc>o
return ''
endfunction

function! Anna_textModeOff()
return ''
endfunction

"function! Anna_GoLeft(n)
"    return repeat("\<left>",a:n)
"endfunction
"
"function! Anna_SE(left,n,nsp,extra)
""Rewriting Anna_SpaceEnter() so that it takes number of spaces and
""optional extra arguments for more functionality
""a:n is number of right movements required
""a:nsp is number of spaces required
"
"let l:spcs       = repeat(' ',a:nsp)
"let l:move       = repeat('<right>',a:n)
"
"    if a:extra == 1|let l:move .= '§'
"elseif a:extra == 2|let l:move .= '§'
"elseif a:extra == 3|let l:move .= '§'
"elseif a:extra == 9|let l:move .= '§'
"elseif a:extra == 5|let l:move  = '<C-r>=Anna_FlashCardSkip()<cr>'
"elseif a:extra == 6|let l:move  = '\\<Esc>:call AnnaTableCountColumns(b:prev_b,"c")<cr>jo\bl '
"endif
"
"let l:math_enter = '<c-r>=Anna_RE('.a:extra.')<cr>'
"    if a:extra == 1|let l:math_enter .= '<del>'
"elseif a:extra ==99|let l:math_enter .= '<c-r>=AnnaModeOff("text")<cr><c-r>=AnnaModeOn("math","True")<cr><c-r>=Anna_mathModeEnter()<cr>'
"elseif a:extra == 2|let l:math_enter .= '<del>'
"elseif a:extra == 3|let l:math_enter .= '<del>'
"elseif a:extra == 8|let l:math_enter .= '<c-r>=Anna_HAu()<cr><Esc>o<c-r>=Anna_RAu()<cr>'
"elseif a:extra == 7|let l:math_enter .= '<c-r>=Anna_GroupTitle()<cr><C-g>u<Esc>o    .<C-g>u<left><del>'
"elseif a:extra == 67|let l:math_enter .= '<C-g>u<Esc>o    .<C-g>u<left><del>'
"endif
"
"let l:end_map    = l:move.l:spcs.l:math_enter
"
"call add(b:anna_se_sp,a:nsp)
"call add(b:anna_se_mv,a:n)
"call add(b:anna_se_ex,a:extra)
"
"execute 'inoremap <silent> <buffer> <cr> <C-]>.<left><del>'.l:end_map
""About the .<left><del>     ...
""It just works. Especially when trying to expand a mapping & also leave a pair of
""brackets. I tried '<left><right>' and 'leaving it blank' but both foiled
"
"return Anna_GoLeft(a:left)
"endfunction

function! Anna_MakeMappable_for_Inline_Math_Mode(str)
"Lets NOT map pure numbers
if !empty(matchstr(a:str,'\C^\%([0-9]\+\|a\|an\)$'))
    return ''
endif
"x and n represent an alphabet letter and
"D represents a digit in the comments below
"± implies '=' too
let l:noabbr = 0
if empty(a:str) || strlen(a:str)>20 | return '' | endif
"strlen 20 generously allows for $\epsilon+\epsilon$
let l:var = matchstr(a:str,'^\$\zs[0-9]\=[0-9]\=[B-Zb-z]\ze\$$')
"allowing for Dn, DDn and n
"'a' is a very valid English word. Tryna avoid confusion
"Lets NOT map pure numbers
if !empty(matchstr(a:str,'\C^\%([0-9]\+\|a\|an\)$'))
    return ''
endif
if !empty(l:var)
    execute 'inoreabbr <buffer> '  .l:var." <c-r>=LMM('".l:var."')<cr>"
    execute 'inoreabbr <buffer> ' .l:var."1 <c-r>=LMM('".l:var."+1')<cr>"
    execute 'inoreabbr <buffer> ' .l:var."2 <c-r>=LMM('".l:var."+2')<cr>"
    execute 'inoreabbr <buffer> '.l:var."m1 <c-r>=LMM('".l:var."-1')<cr>"
        call add(b:my_anna_maps,l:var)
        call add(b:my_anna_maps,l:var.'1')
        call add(b:my_anna_maps,l:var.'2')
        call add(b:my_anna_maps,l:var.'m1')
    "the other 3 mappings are for x±1 and x+2
    return ''
endif
let l:var2 = matchstr(a:str,'^\$\zs[0-9A-Za-z]\(+\|-\|=\)[0-9A-Za-z]\ze\$$')
    if !empty(l:var2)
        execute 'inoremap <silent> <buffer> '.l:var2.  " <C-]><c-r>=LMM('".l:var2."')<cr> "
        call add(b:my_anna_maps,l:var2)
	return ''
    endif
let l:var  = matchstr(a:str,'^\$\zs\([0-9]\|\\\=[A-Za-z]\{-}\)\(+\|-\|=\)\([0-9]\|\\\=[A-Za-z]\{-}\)\ze\$$')
"tryna allow for x±D, D±x where x could be a greek letter
if empty(l:var)
   return ''
endif
"echom '>>'.l:var.'<<'
let l:mapto = l:var

   let l:l1 = matchstr(l:var,'^\\\zs.')
   if !empty(l:l1)
      let l:noabbr = 1
      let l:var = substitute(l:var,'^\\.\{-}\ze\(+\|-\|=\)','`'.l:l1,'')
      "eg replace \lambda with `l
   endif
   let l:l2 = matchstr(l:var,'\(+\|-\|=\)\\\zs.')
   if !empty(l:l2)
      let l:noabbr = 1
      let l:var = substitute(l:var,'\(+\|-\|=\)\zs\\.\{-}$','`'.l:l2,'')
      "eg replace \lambda with `l
   endif
   "echom '>>'.l:var.'<<'

   if l:noabbr == 1 
       execute 'inoremap <silent> <buffer> '.l:var.  " <C-]><c-r>=LMM('".l:mapto."')<cr> "
       call add(b:my_anna_maps,l:var)
       return ''
   endif
endfunction

function! Anna_MakeMappable(str,mapto)
"Will split the a:str so that if a:str starts with a Latex command, \eg Greek letter 
"then we can easily identify where that command ends or rather, 
"where the rest begins
let l:tre = tr(a:str,"'".'+-!@$%&*=:;/?"~|,.({[_^]})`',
                        \'||||||||||||||||||||||||||\\')
let l:punctuated = l:tre
let l:trd = substitute(l:tre,'\\vect\|\\left\|\\right\|\\frac\|\\mathbb\|\\mathcal','','g')
let l:trd = match(a:str,'^\s*\\sqrt') != -1 ? substitute(l:trd,'\\sqrt','r','g') : substitute(l:trd,'\\sqrt','','g')
let l:tre = substitute(l:trd,'\\\([A-z]\)[A-z]*','`\1','g')
let l:r1  = substitute(l:tre,'\s\|\\\||','','g')

let l:map = (l:trd !=# l:tre) ? 1 : 0
"echom l:r1.' >>> '.a:str

"for l:bit in l:split
"   if l:bit[0] ==# '\'
"      call add(l:bits,'`'.l:bit[1])
"      let l:map = 1
"   else
"      call add(l:bits,l:bit)
"   endif
"endfor

"let l:r1 = join(l:bits,'')

if empty(l:r1)
   echoerr 'Empty LHS of mapping'
   return ''
endif

if match(a:str,'^\s*\\frac') != -1
    let l:r1 = 'f'.l:r1
endif

"Lets NOT map pure numbers
if !empty(matchstr(l:r1,'\C^\%([0-9]\+\|a\|an\)$'))
    echom "Can't map '". l:r1."' (pure numbers/a/an)"
    return ''
endif

let l:rstrlen = strlen(l:r1)-1
let l:ret = [[l:r1,a:mapto]]

if strlen(l:r1) != 1
   "let l:r1lastchar = matchstr(l:punctuated,'\%(.*\zs\%([0-9]\+\|[A-Za-z]\)\)*$')
   let l:r1lastchar = matchstr(l:punctuated,'\%([0-9]\+\|[A-Za-z]\)\ze[|\\]*$')
   echom 'r1last' l:r1.' '.l:r1lastchar
   echom l:punctuated
   let l:r1lastchar_nr_value = str2nr(l:r1lastchar)
   
   if l:r1lastchar ==# '0'
      let l:extended = [['m2','m1',1,2,'n'],[-2,-1,1,2,'n']]
   elseif l:r1lastchar_nr_value == 0
      let l:extended = [[l:r1lastchar.'m1',l:r1lastchar.'1',l:r1lastchar.'2'],[l:r1lastchar.'-1',l:r1lastchar.'+1',l:r1lastchar.'+2']]
   else
      let l:extended = [[substitute(string(l:r1lastchar_nr_value-2),'-','m','g'),substitute(string(l:r1lastchar_nr_value-1),'-','m','g'),l:r1lastchar_nr_value+1,l:r1lastchar_nr_value+2,'n'],[l:r1lastchar_nr_value-2,l:r1lastchar_nr_value-1,l:r1lastchar_nr_value+1,l:r1lastchar_nr_value+2,'n']]
   endif

   let l:operator = escape(matchstr(a:str,'\^\|_'),'^')
   if l:operator != ''
       "Look for coefficient, if any. Extract the core thing being indexed.
       let l:base = matchstr(a:str,''.l:operator)
       "echo matchstr('\frac{\lambda^2}{{\beta a}_5}','\%(\%(\zs{.\{-}}\)* &
       ".*\%({.\{-}}\)\|\%(\zs\\\w*\)*\|\w\)_')
   endif

   let g:ext = l:extended[1]
   
   let l:i = 0
   echom 'EXT:'.string(l:extended)
   for l:ext in l:extended[0]
      let l:newlhs = strcharpart(l:r1,0,l:rstrlen).l:ext
      
      "echom 'G-EXT'. string(g:ext)
      if len(l:extended[1][l:i]) > 1
         let l:newrhs = 
	     \ !empty(matchstr(a:mapto,'\^\|_'))
	     \   ?(matchstr(a:mapto,'\(\^\|_\)\zs.') ==# '{')
	     \     ? substitute(a:mapto,'\(\^\|_\){\zs.\+\ze}',      g:ext[l:i],    '')
	     \     : substitute(a:mapto,'\(\^\|_\)\zs.\ze',      '{'.g:ext[l:i].'}','')
	     \   : substitute(a:mapto,'\(.*\zs'.l:r1lastchar.'\)*',g:ext[l:i],'')
         "echom '-1- >>>'.l:extended[1][l:i].'>>>'.a:mapto.'>>>'.l:newrhs
      else
         let l:newrhs = substitute(a:mapto,'.\ze\(}\|)\|]\)\{-}$',l:extended[1][l:i],'')
         "echom '-2- >>>'.l:extended[1][l:i].'>>>'.a:mapto.'>>>'.l:newrhs
      endif
      call add(l:ret,[l:newlhs,l:newrhs])
      "echom 'RET: '.string(l:ret)
      let l:i += 1
   endfor
endif

for l:lhs in l:ret
    let l:esc0 = escape(l:lhs[0],'|')
    let l:esc1 = escape(l:lhs[1],'|')
    let l:esc1 = substitute(l:esc1,"'","'.".'"'."'".'"'.".'",'g')
    "echom string(l:esc0)
    "echom string(l:lhs)

       if !empty(l:lhs[0])
	  if l:map == 1
	     let l:tm = maparg(l:esc0,'i')
	     let l:final = "<C-]><C-R>=LMM('".l:esc1."')<CR><C-R>=Anna_MakeMappable('".l:esc0."','".l:esc1."')<CR><C-R>=ES('\\s')<CR>"

	     if l:tm !=# l:final
		 while maparg(l:esc0,'i') !=# '' "if trigger is taken
		    let l:esc0 = '`'.l:esc0 "assign alternative
		 endwhile
		 execute 'inoremap <silent> <buffer> '.l:esc0.' '.l:final
		 execute 'inoreabbr <buffer> '.substitute(l:esc0,'`','g','g').' '.l:final
		 call add(b:my_anna_maps,l:lhs[0])
	     endif
	  else
	     let l:tm = maparg(l:esc0,'i',1)
	     let l:final = "<C-R>=LMM('".l:esc1."')<CR><C-R>=Anna_MakeMappable('".l:esc0."','".l:esc1."')<CR><C-R>=ES('\\s')<CR>"
	      echom '------'
	      echom l:esc0. ' --> '.l:final
	     " echom l:tm
	     " echom l:final
	     " echom l:final ==# l:tm
	     " echom '------'

	     if l:tm !=# l:final
		 while maparg(l:esc0,'i') !=# '' "if trigger is taken
		    let l:esc0 = matchstr(l:esc0,'[A-z0-9]').l:esc0 "assign alternative
		 endwhile
		 execute 'inoreabbr <buffer> '.l:esc0.' '.l:final
		 call add(b:my_anna_maps,l:lhs[0])
             else
		echom 'Skipped'
	      echom '------'
	     endif
	  endif
       endif
endfor
return ''
endfunction

function! Anna_Unmatched(mapto)
let l:trt0  = strlen(a:mapto)
let l:trt   = 0
"Not perfect but should work for now. Hope to improve later
let l:trt += (strlen(escape(a:mapto,'('))-l:trt0)*10
let l:trt += (strlen(escape(a:mapto,'['))-l:trt0)*20
let l:trt += (strlen(escape(a:mapto,'{'))-l:trt0)*30
let l:trt += (strlen(escape(a:mapto,')'))-l:trt0)*1
let l:trt += (strlen(escape(a:mapto,']'))-l:trt0)*2
let l:trt += (strlen(escape(a:mapto,'}'))-l:trt0)*3
"if there is some fractional part on any of the trts, then there's an unmatched bracket somewhere
"if float2nr(l:trt1) != l:trt1 || float2nr(l:trt2) != l:trt2 || float2nr(l:trt3) != l:trt3
"   return 1
"else
"   return 0
"endif
"echom l:trt
"if l:trt[0] == l:trt[1] || l:trt == 0
if (l:trt % 11) == 0
   return 0
else
   return 1
endif
endfunction

function! Anna_AutoMapIndex(sym)
    "Sometimes brackets and binary operators mess around with indices (think powers subscripts). So
    "this function tries to keep looking back till all brackets are captured in
    "order to make sure the 'full' expression is mapped
    "eg Without this function, both $(a+b)_c$ $(a+b_c)$ get mappings 'bc'
    "We would prefer mappings 'abc' for the 1st one and 'bc' for the 2nd

    call cursor([line('.'),col('.') - 1]) "Shift one left, will undo later
    "echom col('.').' '.strcharpart(getline('.'),0,col('.')).'<<<'
    let [l:l,l:c] = [line('.'), col('.')]

    let l:sym = a:sym
    let l:break = 0
    let l:max_tries = 7

    if !empty(l:sym)
	call search(escape(l:sym,'^\[]*'),'b')
    endif

    let [l:lnum,l:cnum] = searchpos('\%(\\left.\| \|+\|-\|=\|\$\|^\|(\|\[\|{\)','b')
    echom 'FYI:'. a:sym
    "let l:cnum -= 1

    let l:test = strcharpart(getline('.'),l:cnum,l:c - l:cnum)
    echom '-----'
    echom 'Initially grabbed: "'.l:test.'"'.' at '.l:cnum
       
    while l:break < l:max_tries && Anna_Unmatched(l:test) == 1
	"echom 'Test: failed:'.Anna_Unmatched(l:test).' '.l:test
	let [l:lnum,l:cnum] = searchpos('\%(\\left.\| \|+\|-\|=\|\$\|^\|(\|\[\|{\)','b')
        let l:test = strcharpart(getline('.'),l:cnum,l:c - l:cnum )
        echom 'After moving back: ``'.l:test.'"'
	echom 'Grabbed: "'.l:test.'"'.' at '.l:cnum.' at Iter#'.l:break
        let l:break += 1
    endwhile
    echom 'Passed!!! '.l:test
    echom '-----'
    "echom ' '
    "echom ' '

    call cursor(l:l,l:c + 1)

    if l:break == l:max_tries && Anna_Unmatched(l:test) == 1
       echom 'Did not map '.l:test.' since there were unmatched brackets'
       normal! 0f§x
       return ''
    endif

    let l:map = l:test
    let l:tr1 = tr(l:map[0],' +-=$','*****')
    if l:tr1 !=# l:map[0]
       let l:map = substitute(l:map,'.','','')
    else
       let l:trt = (strlen(escape(l:map,'()[]{}'))-strlen(l:map))*0.5
       if float2nr(l:trt) != l:trt
	  let l:map = substitute(l:map,'.','','')
       endif
    endif
    normal! 0f§x

    let l:map = substitute(l:map,'§','','')
    echom 'About to map: "'.l:map.'"'
    call Anna_MakeMappable(l:map,l:map)
    return ''
endfunction

"function! Anna_RE(extra)
"silent! call remove(b:anna_se_sp,-1)
"silent! call remove(b:anna_se_mv,-1)
"silent! call remove(b:anna_se_ex,-1)
"
"if a:extra == 1
"   normal! F}yi{
"   let l:map =@"
"   normal! f§x
"   let l:mapto = '\vect{'.l:map.'}'
"   call Anna_MakeMappable(l:map,l:mapto)
"endif
"if a:extra == 9
"   call Anna_HAu()
"   normal! F$yF$
"   let l:map =@".'$'
"   execute 'normal! f§x'."\<right>"
"   call Anna_MakeMappable_for_Inline_Math_Mode(l:map)
"   call Anna_RAu()
"endif
"
"let l:sym = '0'
"if a:extra == 2
"   let l:sym = '_'
"elseif a:extra == 3
"   let l:sym = '^'
"elseif a:extra == 23
"   let l:sym = ''
"endif
"
"if l:sym != '0'
"   call Anna_AutoMapIndex(l:sym)
"endif
"   
"if len(b:anna_se_mv) == 0
"let l:enter_remapped = 0
"   for l:mode in g:anna_modes
"       execute 'let l:mode_status = g:anna_'.l:mode.'_mode_status'
"       if l:mode_status == 1
"          execute 'call Anna_'.l:mode.'ModeEnter()'
"          let l:enter_remapped = 1
"       endif
"   endfor
"   if l:enter_remapped == 0
"      call Anna_NormalEnter()
"   endif
"else
"   let l:extra      = b:anna_se_ex[-1]
"   let l:spcs       = repeat(' ',b:anna_se_sp[-1])
"   let l:move       = repeat('<right>',b:anna_se_mv[-1])
"        if l:extra == 1|let l:move .= '§'
"    elseif l:extra == 2|let l:move .= '§'
"    elseif l:extra == 3|let l:move .= '§'
"    elseif l:extra == 9|let l:move .= '§'
"    elseif l:extra == 5|let l:move  = '<C-r>=Anna_FlashCardSkip()<cr>'
"    elseif l:extra == 6|let l:move  = '\\<Esc>:call AnnaTableCountColumns(b:prev_b,"c")<cr>jo\bl '
"    endif
"   let l:math_enter = '<c-r>=Anna_RE('.l:extra.')<cr>'
"        if l:extra == 1|let l:math_enter .= '<del>'
"    elseif l:extra ==99|let l:math_enter .= '<c-r>=AnnaModeOff("text")<cr><c-r>=AnnaModeOn("math","True")<cr><c-r>=Anna_mathModeEnter()<cr>'
"    elseif l:extra == 2|let l:math_enter .= '<del>'
"    elseif l:extra == 3|let l:math_enter .= '<del>'
"    elseif l:extra == 8|let l:math_enter .= '<c-r>=Anna_HAu()<cr><Esc>o<c-r>=Anna_RAu()<cr>'
"    elseif l:extra == 7|let l:math_enter .= '<c-r>=Anna_GroupTitle()<cr><C-g>u<Esc>o    .<C-g>u<left><del>'
"    elseif l:extra == 67|let l:math_enter .= '<C-g>u<Esc>o    .<C-g>u<left><del>'
"    endif
"   let l:end_map    = l:move.l:spcs.l:math_enter
"   execute 'inoremap <silent> <buffer> <cr> <C-]>.<left><del>'.l:end_map
"   "About the .<left><del>     ...
"   "It just works. Especially trying to expand a mapping + leave a pair of
"   "brackets. I tried <left><right> and leaving it blank but both foiled
"
"endif
"   "call Anna_HAu()
"   "execute 'normal! i'."\<right>"
"   "call Anna_RAu()
"return ''
"endfunction

function! Anna_tableModeOff()
"Mappings
silent! iunmap <buffer> 'l
silent! iunmap <buffer> 'r
silent! iunmap <buffer> 'c
endfunction

function! AnnaModeOn(mode,arg)
    let l:enter = 1
    let l:mode = a:mode

    if a:mode ==# 'mathi'
       let l:mode = 'math'
       let l:enter = 0
    endif

    if l:mode ==# 'math' && g:anna_text_mode_status == 1
       return ''
    endif
" must wait for 'mathi' to get resolved before invoking extras
execute 'let l:mode_status = g:anna_'.l:mode.'_mode_status'
execute 'let l:mode_extras = g:anna_extra'.l:mode.'_on'
" seems we cannot :execute an if statement or a for statement without risking trouble. Hence the variables above

    if l:mode_status == 0
       if l:mode ==? 'table'
             call Anna_tableModeOn(a:arg)
             execute 'call Anna_'.l:mode.'ModeEnter()'
       elseif l:mode ==? 'math'
             call Anna_mathModeOn()
             if l:enter == 1 && empty(a:arg)
                call Anna_mathModeEnter()
             endif
       else
             execute 'call Anna_'.l:mode.'ModeOn()'
             if l:enter == 1
                execute 'call Anna_'.l:mode.'ModeEnter()'
             endif
       endif
       for l:line in l:mode_extras
           execute l:line
       endfor
       " Set statusline
       execute 'let g:anna_'.l:mode."_mode=' [".toupper(l:mode)."] >>'"
       execute 'let g:anna_'.l:mode.'_mode_status = 1'
    endif
return ''
endfunction

function! AnnaModeOff(mode,...)
    execute 'let l:mode_status = g:anna_'.a:mode.'_mode_status'
    execute 'let l:mode_extras = g:anna_extra'.a:mode.'_off'
" seems we cannot :execute an if statement or a for statement without causing trouble. Hence the variables above
    if l:mode_status == 1
       if a:0 != 0 && a:mode ==? 'math'
          execute 'call Anna_'.a:mode.'ModeOff(1)'
	   for l:line in l:mode_extras
	       execute l:line
	   endfor
       else
          execute 'call Anna_'.a:mode.'ModeOff()'
	  "I had to move this for loop here.
	  "Otherwise it would get executed twice on invoking txt.
	  "... Puzzled as to why
	   for l:line in l:mode_extras
	       execute l:line
	   endfor
       endif

       execute 'let g:anna_'.a:mode."_mode = ''"
       execute 'let g:anna_'.a:mode.'_mode_status = 0'

       let l:skip_normalenter = 0
       if len(b:anna_se_sp) == 0
       "We don't want to overwrite any existing Anna_SE() [Anna_Mysp()?] mappings
          for l:mode in g:anna_modes
              execute 'let l:mode_status = g:anna_'.l:mode.'_mode_status'
              if l:mode_status == 1
                 execute 'call Anna_'.l:mode.'ModeEnter()'
                 let l:skip_normalenter = 1
              endif
          endfor

          if l:skip_normalenter == 0
              call Anna_NormalEnter()
          endif
       endif
   endif
 return ''  
endfunction

function! Anna_Contextualization(InsertEnter)
 let l:c = line('.')    
 let l:col = col('.')
 let l:arg = ''
 let l:same_line = 0
 let l:math_mode_decision_made = 0
 "Display math mode initialized at End of File,
 "and cancelled on leaving insert mode with DisableModes

if l:c == b:prev_c
"Will use this later
   let l:same_line = 1
endif

if b:display_math_mode_decision_made == 0
"start inline math check but only if it won't interfere with display mode
   let l:inline_math_points = 0
  
   let l:forwardsearch = search('\$','cnz',l:c)
     if l:forwardsearch != 0
     "if our motionless forward search yields result, do backward search
         "let l:backwardsearch = search('\$','nb',l:c)
         execute 'silent! normal! F$'
         "if we've moved, proceed
         if l:col != col('.')
	 "if l:backwardsearch != 0
            let l:inline_math_points = 2
            call AnnaModeOn('mathi',l:arg)
            let l:math_mode_decision_made = 1
            let b:math_is_inline = 1
            call cursor(l:c,l:col)
         endif
     endif
   if l:inline_math_points != 2
       call AnnaModeOff('math')
   endif
   "end inline math check
endif

"if we're not entering insert mode,
if a:InsertEnter == 0
"and we're still on the same line, forget the multi-line contexts
   if l:same_line == 1|return ''|endif
"if we're on a different line, let this current line be the new "old line
   let b:prev_c = l:c
endif
if g:anna_text_mode_status == 1
   call AnnaModeOff('text')
endif
"Order of the checks below matters. Simplest thing is to have the innermost
"mode last
 call AmIbetweenv2(g:anna_flashcard_search_string_b,g:anna_flashcard_search_string_e,'FlashCard')
 call AmIbetweenv2('\\begin{enumerate}\|\\begin{itemize}','\\end{enumerate}\|\\end{itemize}','list')
 let l:tabline = AmIbetweenv2('\\begin{tabular}','\\end{tabular}','table')
    if l:tabline > 0 && b:Anna_NewTable == 1
       call Anna_table_mode_First_Enter()
    endif

      if l:math_mode_decision_made == 0
 call AmIbetweenv2('\\\[\|\\begin{align','\\\]\|\\end{align','math')
      endif
 call AmIbetweenv2('\\begin{lstlisting}\|\\begin{TestMyCode}','\\end{lstlisting}\|\\end{TestMyCode}','code')
 endfunction

 function! AmIbetweenv2(start,end,mode)
 let l:arg    = ''
 let l:prev_b = search(a:start,'bWn')
 let l:search = searchpair(a:start,'',a:end,'Wnc')

 if l:search > 0
 "We ARE between
    if a:mode ==# 'table'
       let l:arg = l:prev_b
    elseif a:mode ==# 'math'
       "we're about to turn math mode on
       "Make it known to inline math
       let b:display_math_mode_decision_made = 1
       let b:math_is_inline = 0
    endif
 
    call AnnaModeOn(a:mode,l:arg)
    return l:prev_b
 else
    "We aRE NOT between
    call AnnaModeOff(a:mode)
    return ''
 endif
 endfunction
   
" function! AmIbetween(start,end,mode)
" let l:arg = ''
" let l:c = line('.')
"   let l:next_e = search(a:end,'Wn')
"       if l:c == l:next_e|call AnnaModeOff(a:mode)|return ''|endif
"       if l:next_e == 0
"          call AnnaModeOff(a:mode)
"          return ''
"       endif
"   let l:prev_b = search(a:start,'bWn')
"       if l:c == l:prev_b|call AnnaModeOff(a:mode)|return ''|endif
"       if l:prev_b == 0
"          call AnnaModeOff(a:mode)
"          return ''
"       endif
"   let l:next_b = search(a:start,'Wn')
"   if l:next_b != 0 && l:next_b < l:next_e+1|call AnnaModeOff(a:mode)|return ''|endif
"   let l:prev_e = search(a:end,'bWn')
"   if l:prev_e != 0 && l:prev_e > l:prev_b-1|call AnnaModeOff(a:mode)|return ''|endif
"
"   if a:mode ==# 'table'
"      let l:arg = l:prev_b
"   elseif a:mode ==# 'math'
"      "we're about to turn math mode on
"      "Make it known to inline math
"      let b:display_math_mode_decision_made = 1
"      let b:math_is_inline = 0
"   endif
"
"   call AnnaModeOn(a:mode,l:arg)
"   return l:prev_b
"endfunction

function! AnnaTableCountColumns(prev_b,column_type)
"Tabularize /\\\@<!&\|\\\\
call TabConceal()
let l:c = line('.')
let b:anna_current_table_col_n = str2nr(execute('silent! .s/ &//gn')[1])
"(From innermost bracket going out) - Find l OR c OR r in the last visual selection and return number of matches; split by whitespace, get 1st element in resulting list, change to a number then subtract 2 (2 matches due to l and r in tabular)
if b:anna_current_table_col_n == 0
    "execute normal! i\<bs>"
    execute a:prev_b
    execute 'normal! 02f}i'.a:column_type
    let b:Anna_NewTable = 0
    return ''
endif
let b:anna_current_table_col_n += 1
let b:tabu_col_n = str2nr(split(execute(a:prev_b.'s/l\|c\|r//gn'))[0]) - 2
if b:tabu_col_n < b:anna_current_table_col_n
    let l:diff = b:anna_current_table_col_n - b:tabu_col_n
    execute a:prev_b
    execute 'normal! 02f}'.l:diff.'i'.a:column_type
    execute l:c
    "normal! A
endif
return ''
endfunction

function! AnnaStatusLine()
if empty(g:anna_table_mode.g:anna_math_mode.g:anna_list_mode.g:anna_FlashCard_mode.g:anna_code_mode)
   return '%f %m'
else
   return ' >>'.g:anna_math_mode.g:anna_table_mode.g:anna_list_mode.g:anna_FlashCard_mode.g:anna_code_mode
endif
endfunction

function! ES(pat)
"ES = EatSpace
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

function! EP(pat)
    let c = getline('.')[col('.')-2]
    return (c =~ a:pat) ? "\<left>" : ""
endfunc

function! HW()
execute 'normal! a\homework{}{}'."\<Esc>F}"
startinsert
endfunction

function! DateTime()
let b:date =strftime("%a %d %b %y")
let b:time =strftime("%H:%M")
endfunction

function! BreakNow()
call DateTime()
execute 'normal! o\ThenWeTookAbreak{'.b:date.'}{'.b:time.'}'
endfunction

function! BreakOver()
call DateTime()
execute 'normal! o\ThenTheBreakWasOver{'.b:date.'}{'.b:time.'}'."\<Esc>o"
endfunction

function! TheEnd()
call DateTime()
execute 'normal! o\AndThatWasIt{'.b:date.'}{'.b:time.'}'
endfunction

function! NewLecture(course_code)
if &modified
   echoerr 'No write since last change. (No override available)'
   return ''
endif
"Firstly, note the current dir then change to anna_dir. Standard procedure
let l:old_dir = getcwd() | execute 'cd' fnameescape(g:anna_dir)
"--------------------------------------------------------------

if !isdirectory(fnameescape(a:course_code).'/Notes')
   echoerr 'Course not found :( Run initialization'
   return
endif
execute 'cd' fnameescape(a:course_code).'/Notes'
"cd will fail if directory does !exist    ?
let s:filename = strftime("%m%d-%a%d%b").".tex"
let s:do_infos = 1

if filereadable(s:filename)
   let s:do_infos = 0
endif

execute 'e' s:filename
let b:filename = s:filename

if s:do_infos == 1
execute 'silent! normal! gg50dd'
"reading metadata from preload.tex, generating the rest
   execute 'read' fnameescape('../preload.tex')
   "yank till \ from \xspace EXCEPT for venues
   execute 'normal! 2f{lyt\0'| let b:c_lecturer =@"
   execute 'normal! j2f{lyt\0'| let b:c_lecturer_email =@"
   execute 'normal! j2f{lyt\0'| let b:c_fullname =@"
   execute 'normal! j2f{yi{0'| let b:c_venues =@"
   execute 'normal! gg50dd'
   let b:c_code = a:course_code
   call DateTime()|let b:start_time = b:time|let b:start_date = b:date
   call TodaysVenue()
"loading snippet, writing metadata
   execute 'read' fnameescape('../../anna-global/.lecture-head.tex')
  execute "normal! ggdd0"
  execute "normal! fAf{ci{\<C-r>=expand('%:t:r')\<cr>"
    execute "normal! j0"
    execute "normal! f{ci{\<C-r>=b:c_code\<cr>"
    execute "normal! f{ci{\<C-r>=b:c_lecturer\<cr>"
    execute "normal! f{ci{\<C-r>=b:start_date\<cr>"
    execute "normal! f{ci{\<C-r>=b:start_time\<cr>"
    execute "normal! f{ci{\<C-r>=b:c_venues\<cr>"
    "It works when the 'o' is alone... I don't know why
    let l:headers = HeadingsCatchUp('')
    if !empty(l:headers)
       execute 'normal! GO'.HeadingsCatchUp('')
    endif
    "Let's GO
    normal! GO
    startinsert
"endif do infos
endif

    augroup MakeMediaDir
        au!
        au! BufWrite <buffer> call MaybeCreateMediaDir()
    augroup END
filetype detect
if filereadable(g:anna_card_extras_store)
   execute ':source '.g:anna_card_extras_store
endif
call DisableModes()
"end NewLecture
set nomod
return ''
endfunction

function! MaybeCreateMediaDir()
    let l:media_dir = '../Media/'.fnameescape(expand('%:t:r'))
    if !isdirectory(l:media_dir)
        call mkdir(l:media_dir)
    endif
    augroup MakeMediaDir
       au!
    augroup END
endfunction

function! TodaysVenue()
"Sample venue - 'Mon{NCB2} Wed{NCB1} Fri{WSS3}
if !empty(b:c_venues)
   let l:tday =strftime("%a")
   "l:tday == Mon,Tue,Wed or ...
   execute "normal! o0000 \<C-r>=b:c_venues\<cr>"
   "pad the line then write stored venues to file so we can do...
   execute 'silent! normal! 0f'.l:tday[0]
   "reset position then find l:tday...sorta
   if expand("<cword>") ==? l:tday
      execute 'normal! f{yi{'
      let b:c_venues =@"
      "overwrite old venues
   endif
   execute 'normal! ddgg'
   "clean up
endif
endfunction

function! CourseCodeComplete(A,L,P) 
let l:old_dir = getcwd() | execute 'cd' fnameescape(g:anna_dir)
let s:list = globpath('.','*',0,1)
let s:list = filter(s:list,'v:val !~ "anna-global"')
let s:list = filter(s:list,'v:val !~ "anna-randoms"')
let s:list = filter(s:list,'v:val !~ ".anna-global"')
let s:list = map(s:list,"substitute(v:val,'.','','')")
let s:list = map(s:list,"substitute(v:val,'\\','','')")
let s:list = map(s:list,"substitute(v:val,'/','','')")
execute 'cd' fnameescape(l:old_dir)
return s:list
endfunction

function! Anna_ClearMaps()
 for l:mapping in b:my_anna_maps 
     execute 'silent! iunmap <buffer> '.l:mapping
 endfor
 for l:abbreviation in b:my_anna_abbr 
     execute 'silent! iunabb <buffer> '.l:abbreviation
 endfor
 for l:mapping in b:my_math_maps 
     execute 'silent! iunmap <buffer> '.l:mapping
 endfor
 let b:my_anna_maps = []
 let b:my_math_maps = []
 let b:my_anna_abbr = []
endfunction

function! Anna_BufEnter() 
if !exists('b:my_anna_maps')
   let b:my_anna_maps = []
   let b:my_anna_abbr = []
endif
if !exists('b:anna_se_sp')
   let b:anna_se_sp = []
   let b:anna_se_mv = []
   let b:anna_se_ex = []
endif
let b:prev_c = 0
endfunction

function! Anna_HAu()
    "Hold AutoCommands
    augroup AnnaAutos
	au!
    augroup END
    return ''
endfunction

function! Anna_RAu()
"Resume AutoCommands
augroup AnnaAutos
    au!
    au InsertLeave  *.tex call DisableModes()
    au CursorMovedI *.tex call Anna_Contextualization(0)
    au InsertEnter  *.tex call Anna_Contextualization(1)
augroup END
return ''
endfunction

function! AnnaReplaceWithUnique(matched_string,characters)
let g:anna_counter1 += float2nr(5 + ceil(str2nr(reltimestr(reltime())[-2:])*25/100))
let g:anna_counter2 += float2nr(3 + ceil(str2nr(reltimestr(reltime())[-2:])*25/100))
let l:uniq_id = 
              \ '|=||'
              \.RandLetter(5)
              \.a:characters[reltimestr(reltime())[-1:]]
              \.RandLetter(3)
              \.a:characters[3:5]
              \.a:characters[reltimestr(reltime())[-1:]]
              \.RandLetter(3)
              \.a:characters[0]
              \.a:characters[reltimestr(reltime())[-1:]]
	      \.g:anna_counter1
              \.RandLetter(2)
              \.a:characters[0]
              \.a:characters[reltimestr(reltime())[-1:]]
              \.RandLetter(7)
	      \.g:anna_counter2
	      \.'||=|'
let g:keeep[l:uniq_id] = a:matched_string
return l:uniq_id
endfunction

function! Latex2HTML3(latex,options)
    let l:latex = a:latex
    let l:patt  = escape('[[$]]\(\_.\{-}\)[[/$]]','[/$]')
    let l:latex = substitute(l:latex, l:patt,'\\\[\1\\\]','g')
    return l:latex
endfunction

function! Latex2HTML2(latex,options)
    let l:latex = a:latex
    let l:latex = substitute(l:latex,'\\\@<!\$\(\_.\{-}\)\\\@<!\$','\\(\1\\)','g')
    let l:latex = substitute(l:latex,'\\\@<!\\\[\(\_.\{-}\)\\\@<!\\\]','\[\$\]\1\[\$\]','g')
    "let l:latex = substitute(l:latex,'\\\[\(\_.\{-}\)\\\]','\\[\1\\]','g')
    return l:latex
endfunction

function! Latex2HTML(latex,options)
let g:keeep         = {}
let l:latex = a:latex

if match(a:options,'\CX') != -1
    let l:originalx = a:latex
else
    let l:original  = a:latex
    "Later on should make sure you wrap [latex] tags only around the ORIGINAL
    "html-unescaped input. On that day this might come in handy
endif
"Available options are 'ltgm'

"Math (m)
if (match(a:options,'\Cm') != -1) || (match(a:options,'\Cp') != -1)
    let l:latex = substitute(l:latex , '\(\(\\\@<!\(\\\[\)\_.\{-}\\\@<!\(\\\]\)\)\|\(\\\@<!\$\_.\{-}\\\@<!\$\)\)' , '\=Latex2HTML(submatch(1) , "Xtg")' , 'g')
    "protecting the math we have already placed in [$],[$$] or [latex] or Anki2 MathJax \(\) \[\]
    let g:anna_counter1 = 0
    let g:anna_counter2 = 89
    let l:patt          =     escape('\([$]\_.\{-}[/$]\)\|\(\\(\_.\{-}\\)\)\|\(\\\[\_.\{-}\\\]\)\|\([$$]\_.\{-}[/$$]\)\|\([latex]\_.\{-}[/latex]\)','[$/]')
    let l:latex         = substitute(l:latex,'\('.l:patt.'\)','\=AnnaReplaceWithUnique(submatch(1),'."'@|=-+!_|@!')",'g')
endif

"Lists (l)
if match(a:options                  , '\Cl') != -1
   let l:latex = substitute(l:latex , '\\begin{itemize}\_.\{-}\\item'   , '<ul><li>'   , 'g')
   let l:latex = substitute(l:latex , '\\setcounter{enumi*|||§||\([0-9]*\)}\_.\{-}\\item'                          , '</li><li value="\1">'  , 'g')
   let l:latex = substitute(l:latex , '<\/li><li value="\zs\([0-9]\)\ze">'                          , '\=submatch(1)+1'  , 'g')
   let l:latex = substitute(l:latex , '\\end{itemize}'                  , '</li></ul>' , 'g')
   let l:latex = substitute(l:latex , '\\begin{enumerate}\_.\{-}\\item' , '<ol><li>'   , 'g')
   let l:latex = substitute(l:latex , '\\end{enumerate}'                , '</li></ol>' , 'g')
   let l:latex = substitute(l:latex , '\\begin{centering}' , '<div class="centering">'	, 'g')
   let l:latex = substitute(l:latex , '\\end{centering}'                , '</div>'			, 'g')
   let l:latex = substitute(l:latex , '\\item'                          , '</li><li>'  , 'g')
   
   let l:latex = substitute(l:latex , '\s\{-}</li>'        , '</li> ' , 'g')
   let l:latex = substitute(l:latex , '\s\{-}<li>'         , ' <li>'  , 'g')
   let l:latex = substitute(l:latex , '\s\{-}<\(\/\?\)ul>' , '<\1ul>' , 'g')
endif

"Text (t). ie Logic...  Type...  Bold...  Italics...  Underline
if match(a:options                  , '\Ct') != -1
   let l:latex = substitute(l:latex , '\\ '                       , '\&nbsp;'                                             , 'g')
   let l:latex = substitute(l:latex , '\\logic{\(.\{-}\)}'        , '<span class="logic">\1<\/span>'                      , 'g')
   let l:latex = substitute(l:latex , '\\type{\(.\{-}\)}'         , '<span class="type">\1<\/span>'                       , 'g')
   let l:latex = substitute(l:latex , '\\bool{\(.\{-}\)}'         , '<span class="type">\1<\/span>'                       , 'g')
   let l:latex = substitute(l:latex , '\\emph{\(.\{-}\)}'         , '<em>\1<\/em>'                                        , 'g')
   let l:latex = substitute(l:latex , '\\textbf{\(.\{-}\)}'       , '<b>\1<\/b>'                                          , 'g')
   let l:latex = substitute(l:latex , '\\underline{\(.\{-}\)}'    , '<span style="text-decoration:underline;">\1<\/span>' , 'g')
   let l:latex = substitute(l:latex , '``\(\_.\{-}\)'. "''"       , '\&ldquo;\1\&rdquo;'                                  , 'g')
   let l:latex = substitute(l:latex , '`\(\_.\{-}\)' .  "'[^A-z]" , '\&lsquo;\1\&rsquo;'                                  , 'g')
   let l:latex = substitute(l:latex , '\\ldots'                   , '\&hellip;'                                           , 'g')
   let l:latex = substitute(l:latex , '\\ie'                      , 'i.e.'                                                , 'g')
   let l:latex = substitute(l:latex , '\\eg'                      , 'e.g.'                                                , 'g')
   let l:latex = substitute(l:latex , '--'                        , '\&ndash;'                                            , 'g')
   let l:latex = substitute(l:latex , '---'                       , '\&mdash;'                                            , 'g')
   let l:latex = substitute(l:latex , '\\\\'                      , '<br>'                                                , 'g')
   let l:latex = substitute(l:latex , '\n\n'                      , '<br>'                                                , 'g')
   let l:latex = substitute(l:latex , '\\&'                       , '\&amp;'                                              , 'g')
endif
"Greek letters (g)
if match(a:options,'\Cg') != -1
   let l:latex = substitute(l:latex ,
   \'\C\\\(nabla\|Pi\|pi\|alpha\|beta\|Gamma\|gamma\|Delta\|delta\|epsilon\|zeta\|eta\|Theta\|theta\|iota\|kappa\|Lambda\|lambda\|mu\|nu\|Xi\|rho\|Sigma\|sigma\|tau\|Upsilon\|upsilon\|Phi\|phi\|Psi\|psi\|Omega\|omega\)'
   \,'\&\1;'
   \,'g')
   
   let l:latex = substitute(l:latex , '\\varsigma'                            , '\&\1f;'   , 'g')
   let l:latex = substitute(l:latex , '\\var\(epsilon\|pi\|theta\|rho\|phi\)' , '\&var\1;' , 'g')
endif

if match(a:options,'\CX') != -1

   let l:began_with = matchstr(l:latex , '^\\\@<!\(\$\|\\\[\)')
   let l:ended_with = matchstr(l:latex , '\\\@<!\(\$\|\\\]\)$')
   let l:latex      = substitute(l:latex , '^'.escape(l:began_with,'$\[]') , '' , '')
   let l:latex      = substitute(l:latex , escape(l:ended_with,'$\[]').'$' , '' , '')
   if empty(l:latex)
      return l:latex
   endif
   "Check if the math is simple enough
   let l:lmath = substitute(l:latex,'\C\(\\i\=i\=int\)','\\XAXSLG','g')

   let l:lmath = substitute(l:lmath, '\C\(\\{\|\\}\|\\%\|\\\$\|\\&\|\\text\|\\times\|\\ldots\|\\QeD\|\\not=\|\\geq\|\\leq\|\\quad\|\\qquad\|\\distr\| \|\\cdot\|\\subseteq\|\\supseteq\|\\subset\|\\supset\|\\cap\|\\cup\|\\not\|\\infty\|\\in\|\\notin\|\\in\|\\mathbb{[A-z]}\|\\iff\|\\forall\|\\implies\|\\exists\|\\backslash\|\\to\|\\mp\|\\pm\|\\vect\)' , '0', 'g')
   let l:lmath = tr(l:lmath
                           \, '[]{}&!()+-=_^.,?:;|#"*<>'."'"
                           \, '000000000000000000000000'.'0')
			   "echom l:lmath.'>>'.l:latex
   if match(l:lmath,'^[A-z0-9]\+$') == 0 && match(l:lmath,'\\') == -1
      "Math is simple enough. Go ahead and HTML it
      let l:latex = substitute(l:latex , '\\geq'       , '\&ge;' , 'g')
      let l:latex = substitute(l:latex , '\\backslash' , '| Щ||' , 'g')
      let l:latex = substitute(l:latex , '>'           , '\&gt;' , 'g')
      let l:latex = substitute(l:latex , '\\leq'       , '\&le;' , 'g')
      let l:latex = substitute(l:latex , '<'           , '\&lt;' , 'g')
      "Must start with <> since they might mess up some html

      let l:latex = substitute(l:latex , '_{\(\_.\{-}\)}'  , '<sub>\1</sub>' , 'g')
      let l:latex = substitute(l:latex , '\^{\(\_.\{-}\)}' , '<sup>\1</sup>' , 'g')
      let l:latex = substitute(l:latex , '_{\@!\(.\)'      , '<sub>\1</sub>' , 'g')
      let l:latex = substitute(l:latex , '\^{\@!\(.\)'     , '<sup>\1</sup>' , 'g')
      
      let l:latex = substitute(l:latex , '\\QeD'               , '\&#11035;'                                                , 'g')
      let l:latex = substitute(l:latex , '\\text{\(\_.\{-}\)}' , '<span class="text">\1</span>'                             , 'g')
      let l:latex = substitute(l:latex , '\\times'             , '\&times;'                                                 , 'g')
      let l:latex = substitute(l:latex , '\\ldots'             , '\&ldots'                                                  , 'g')
      let l:latex = substitute(l:latex , '\\not='              , '\&#x2260;'                                                , 'g')
      let l:latex = substitute(l:latex , "'"                   , '\&prime;'                                                 , 'g')
      let l:latex = substitute(l:latex , '"'                   , '\&prime;\&prime;'                                         , 'g')
      let l:latex = substitute(l:latex , '\\qquad'             , '\&nbsp;\&nbsp;\&nbsp;\&nbsp;\&nbsp;\&nbsp;\&nbsp;\&nbsp;' , 'g')
      let l:latex = substitute(l:latex , '\\quad'              , '\&nbsp;\&nbsp;\&nbsp;\&nbsp;'                             , 'g')
      let l:latex = substitute(l:latex , '\\distr'             , '~'                                                        , 'g')
      let l:latex = substitute(l:latex , '\\cdot'              , '\&middot;'                                                , 'g')
      let l:latex = substitute(l:latex , '\\su\(b\|p\)seteq'   , '\&su\1seteq;'                                             , 'g')
      let l:latex = substitute(l:latex , '\\su\(b\|p\)set'     , '\&su\1set;'                                               , 'g')
      let l:latex = substitute(l:latex , '\\c\(u\|a\)p'        , '\&c\1p;'                                                  , 'g')
      let l:latex = substitute(l:latex , '\\infty'             , '\&infin;'                                                 , 'g')
      let l:latex = substitute(l:latex , '\\not\\\=in'         , '\&notin;'                                                 , 'g')
      let l:latex = substitute(l:latex , '\\in'                , '\&in;'                                                    , 'g')
      let l:latex = substitute(l:latex , '\\mathbb{\([A-z]\)}' , '<span class="extra_symbols">\&\1opf;</span>'              , 'g')
      let l:latex = substitute(l:latex , '-'                   , '\&minus;'                                                 , 'g')
      let l:latex = substitute(l:latex , '\\iff'               , '\&iff;'                                                   , 'g')
      let l:latex = substitute(l:latex , '\\forall'            , '\&forall;'                                                , 'g')
      let l:latex = substitute(l:latex , '\\implies'           , '\&Implies;'                                               , 'g')
      let l:latex = substitute(l:latex , '\\exists'            , '\&Exists;'                                                , 'g')
      let l:latex = substitute(l:latex , '\\to'                , '\&rightarrow;'                                            , 'g')
      let l:latex = substitute(l:latex , '\\pm'                , '\&pm;'                                                    , 'g')
      let l:latex = substitute(l:latex , '\\mp'                , '\&mp;'                                                    , 'g')

      let l:latex = substitute(l:latex , '\\vect{\(.\{-}\)}' , '<b>\1<\/b>' , 'g')
      let l:latex = substitute(l:latex , '\\\@<!{'           , ''           , 'g')
      let l:latex = substitute(l:latex , '\\\@<!}'           , ''           , 'g')
      let l:latex = substitute(l:latex , '\\{'               , '{'          , 'g')
      let l:latex = substitute(l:latex , '\\}'               , '}'          , 'g')
      
      let l:latex = l:began_with.l:latex.l:ended_with

      let l:latex = substitute(l:latex , '^\\\@<!\$\(\_.\{-}\)\\\@<!\$$'             , '<span class="math">\1</span>' , 'g')
      let l:latex = substitute(l:latex , '^\\\@<!\(\\\[\)\(\_.\{-}\)\\\@<!\(\\\]\)$' , '<p class="math">\2</p>'       , 'g')
   else
      "Maths is NOT simple enough. Just let the latex be
      "let l:latex = l:began_with.l:latex.l:ended_with
      let l:latex = substitute(a:latex , '\\\@<!\$\(\_.\{-}\)\\\@<!\$'             , '[$]\1[\/$]'   , 'g')
      let l:latex = substitute(l:latex , '\\\@<!\(\\\[\)\(\_.\{-}\)\\\@<!\(\\\]\)' , '<br>[$$]\2[\/$$]<br>' , 'g')
   endif
endif
if match(a:options,'\CX') == -1
"Will now deal with any remaining latex commands (anything with a backslash)
"but only if this isn't one of those special maths 'X' type subruns?
"Replace everything we' re NOT interested with a 'unique' string
let g:anna_counter1 = 10000
let g:anna_counter2 = 11000
let l:patt          = escape('\([$]\_.\{-}[/$]\)\|\([$$]\_.\{-}[/$$]\)\|\([latex]\_.\{-}[/latex]\)','[$/]')
let l:latex         = substitute(l:latex,'\('.l:patt.'\)','\=AnnaReplaceWithUnique(submatch(1),'."'@|=-+!_|@!')",'g')

"Do what needs to be done (hug any lingering latex with [latex] and [/latex])
"Am only handling backslash now to avoid it being double HTML'd
let l:latex = substitute(l:latex , '\\backslash','| Щ||', 'g')
let l:latex = substitute(l:latex , '\(\\begin{\(.\{-}\)}\_.\{-}\\end{\2}\|\\[A-z0-9]\+\(\[.\{-}\]\)\=\(\({.\{-}}\)\+\|.\)\=\)' , '[latex]\1[/latex] ' , 'g')

"Check one more time
let l:lateness = substitute(l:latex,'\('.l:patt.'\)','\= AnnaReplaceWithUnique(submatch(1),'."'@| = -+!_|@!')",'g')

"If we STILL have a backslash lingering somewhere...
if match(l:lateness , '\\') != -1
   echom 'By the way... gave up on a Latex2HTML() job.. Thing is I did not manage to handle all the backslashes'
   return a:latex
else
"Now to put everything back together
for [l:key, l:value] in items(g:keeep)
    let l:latex = substitute(l:latex,l:key,escape(l:value,'\&'),'')
endfor
   let l:latex = substitute(l:latex , '| Щ||'  , '\\' , 'g')
   unlet g:anna_counter1
   unlet g:anna_counter2
endif
endif
return l:latex
endfunction

"AutoCommands/Initialization
function! AnnaInit()
let b:display_math_mode_decision_made = 0
"For g:anna_modes... Order might matter
"Not 100% sure but since, when a mode is switched off, we check if the _other_ modes need
"their <cr> mapping restablished by running through g:anna_modes; it semms best to  
"Put innermost mode last

let g:anna_modes = ['text','FlashCard','list','table','math','code']
for l:mode in g:anna_modes
   execute 'let g:anna_extra'.l:mode.'_on  = []'
   execute 'let g:anna_extra'.l:mode.'_off = []'
   execute 'let g:anna_'.l:mode.'_mode_status  = 0'
   execute 'let g:anna_'.l:mode.'_mode         = ""'
endfor

let g:anna_card_extras = {}
let g:anna_card_extras_store = '../FlashCards/extras.vim'
"(relative to Notes directory)
if filereadable(g:anna_card_extras_store)
   execute ':source '.g:anna_card_extras_store
endif

call Anna_BufEnter()
call DisableModes()
call Anna_RAu()
let b:my_math_maps = []
set statusline=%!AnnaStatusLine()

augroup AnnaExit
    au!
    au VimLeavePre *.tex echo 'Cleaning up...'
    au VimLeavePre  *.tex silent! LatexmkStop
    au VimLeavePre  *.tex silent! !start /B latexmk -c
    au VimLeavePre *.tex silent! call LatexmkCleanExtras()
    au VimLeave *.tex execute 'silent! !start /B attrib +H *.un~'
augroup END
if filereadable(expand('%')) && !filereadable(substitute(expand('%'),'\.tex$','\.pdf','')) && expand('%:p:h:t') ==# 'Notes'
    echohl AnnaWarning
    echo 'PDF not found!'
    echohl None
endif
endfunction

function! LatexmkCleanExtras()
    if expand('%:p:h:t') ==# 'Notes' && expand('%:p:t') =~# '[0-9]\{4}-[A-z0-9]\{8}\.tex'
       cd %:p:h
       let l:cand = extend(glob('*.tdo',1,1),glob('*.fls',1,1))
       execute 'silent! !start /B del /Q *.tdo'
       execute 'silent! !start /B del /Q *.fls'
       for l:file in l:cand
           call delete(l:file)
       endfor
    endif
    silent! !taskkill /f /im perl.exe
endfunction

function! ListSubstitute(str,from,to,flags)
if len(a:from) != len(a:to)
   echoerr 'The 2 lists must be of the same length'
   return ''
endif
let l:dict = {}
let l:cntr = 0
for l:old in a:from
    let l:dict[l:old] = l:cntr
    let l:cntr += 1
endfor

let l:newf = '\('.join(a:from,'\|').'\)'
let l:newt = '\=a:to[l:dict[submatch(1)]]'

return substitute(a:str,l:newf,l:newt,a:flags)
endfunction

function! Strdate2num(str)
let l:str = a:str
"Day
let l:days   = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun']
let l:months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

let l:d = matchstr(a:str,'^...')
let l:n = matchstr(a:str,'^...\zs..')
let l:m = matchstr(a:str,'^.....\zs...')

return ListSubstitute(l:m,l:months,map(range(1,12),'0.v:val'),'').l:n.'-'.a:str
endfunction

function! OperationRename()
let l:l1 = glob('*.tex',1,1)
let l:l2 = glob('*.pdf',1,1)
let l:l4 = glob('*/Notes/*.pdf',1,1)
let l:l5 = glob('*/Notes/*.tex',1,1)
let l:l6 = glob('*/Notes/.*.tex.un?',1,1)
let l:l7 = extend(extend(l:l4,l:l5),l:l6)

for l:oldname in l:l7
       if match(l:oldname,'\\\.\=[0-9]\{4} [A-z]\{3}[0-9]\{2}[A-z]\{3}\.') != -1
	   "let l:oldy = matchstr(l:oldname,'\\\.\=\zs[A-z]\{3}[0-9]\{2}[A-z]\{3}.\{-}$')
	   "let l:newy = Strdate2num(l:oldy)
           "let l:very = substitute(l:oldname,escape(l:oldy,'~\.'),escape(l:newy,'~\.'),'g')
	   let l:very = substitute(l:oldname,'\\\.\=[0-9]\{4}\zs \ze[A-z]\{3}[0-9]\{2}[A-z]\{3}\.','-','')
           "call rename(l:oldname,l:very)
	   echo l:oldname.' >> '.l:very 
       endif
endfor
return 'Operation Rename Complete'
endfunction

function! BackDate(afresh)
let [l:ssss,l:line_was_at,l:column_was_at,l:ssss] = getpos('.')
call cursor(1,1)
call search('\\lecture')
let l:date = matchstr(getline('.'),'\\lecture\({.\{-}}\)\{2}{\zs.\{-}\ze}')
let l:newdate = Strdate2num(substitute(l:date,' \|..$','','g')).'.tex'
let l:ampath = matchstr(l:newdate,'^.\{-}\ze\.tex')
normal! gg
execute ':%substitute/\\AMpath{\zs.\{-}\ze}/'.l:ampath.'/'
normal! ggj$2F}ci{(ReWrite)
normal! j
execute ':saveas '. l:newdate
if a:afresh == 1
    let l:headers = HeadingsCatchUp('')
    if !empty(l:headers)
       execute 'normal! GO'.HeadingsCatchUp('')
    endif
    "Let's GO
    normal! GO
    startinsert
else
    call cursor(l:line_was_at,l:column_was_at)
endif
endfunction

function! OpenOld(difference)
    let path = GotoLecture(a:difference)
    execute path ? 'e '.path : 'echo "Nothing there :/"'
endfunction

function! GotoLecture(difference,...)
"This one returns the file name of the previous (a:difference < 0) or
"next (positive difference) lecture
if a:0 == 0
   let l:file_name = expand('%:t')
else
   let l:file_name = a:1
endif
if a:difference == 0 | return 0 | endif

let l:tex_files = glob('*.tex',1,1)
let l:pos = (index(l:tex_files,l:file_name) + a:difference) % len(l:tex_files) 

if l:pos < -1|let l:pos =-1|endif
let l:previously = get(l:tex_files,l:pos,0)

return l:previously
endfunction

function! HeadingsCatchUp(file_name)
let l:previously = GotoLecture(-1)
if !l:previously| return 0 | endif

let l:section         = ''
let l:subsection      = ''
let l:subsubsection   = ''
let l:c_section       = 0
let l:c_subsection    = 0
let l:c_subsubsection = 0

let l:content = readfile(l:previously)
for l:line in l:content
    "Check for counters and respond accordingly
    let l:temp = add(matchlist(l:line,'\\setcounter{\(.\{-}\)}{\([0-9]\+\)}'),'')
    if !empty(l:temp[0])
       let l:sec  = l:temp[1]
       let l:ctr  = l:temp[2]
       call execute('let l:c_'.l:sec.' = '.l:ctr)
    endif
    "check for headers and respond accordingly
    let l:temp = add(matchlist(l:line,'\C\\\(sub\)\=\(sub\)\=\(s\|S\)ection{\(.\+\)}'),'')
    if !empty(l:temp[0])
       let l:type  = l:temp[1].l:temp[2].'section'
       let l:head  = l:temp[4]
       let l:level = (strlen(l:temp[1].l:temp[2])/3) + 1
       call execute('let l:c_'.l:type.' += 1')
       let l:head = substitute(l:head,"'","'".'"'."'".'"'."'",'g')
       call execute('let l:'  .l:type.' = '."'".l:head."'")

       while l:level < 3
          let l:subtype = repeat('sub',l:level).'section'
          call execute('let l:c_'.l:subtype.' =  0')
          call execute('let l:'  .l:subtype.' = ""')
          let l:level += 1
       endwhile
    endif
endfor
let l:results = [[l:c_section,l:section],[l:c_subsection,l:subsection],[l:c_subsubsection,l:subsubsection]]
let l:ret = []
let l:level = 0

for l:bit in l:results
    let l:subtype = repeat('sub',l:level).'section'
    if l:bit[0] > 1
       call add(l:ret,'\setcounter{'.l:subtype.'}{'.(l:bit[0]-1).'}')
    endif
    if l:bit[1] !=# ''
       if l:level == 0|let l:subtype = 'Section'|endif
       let l:spaces = repeat(' ',l:level*3)
       if l:level == 2|let l:spaces = '     '|endif
       call add(l:ret,l:spaces.'\'.l:subtype.'{'.l:bit[1].'}')
    endif
    let l:level += 1
endfor
return join(l:ret,"\n")
endfunction

function! TabConceal()
let l:l = line('.')
let l:c =  col('.')

let l:patt = '\\\@<!&'
let l:ratt = '&'
"g:tabcon at end of file
let l:conceal = g:tabcon

call cursor(line('.'),1)
if search(l:patt,'',line('.')) < 1
   call cursor(l:l,l:c)
   return ''
endif
"Range ID
let l:l = line('.')
let l:c =  col('.')

let l:p = l:l
while 1
  let l:p = l:p+1
  call cursor(l:p,0)
  if search(l:patt,'n',l:p) < 1
     break
  endif
endwhile
let l:range_end = l:p-1

call cursor(l:l,1)

let l:p = l:l
let l:range_beg = l:p

while 1
  let l:p = l:p-1
  call cursor(l:p,0)
  if search(l:patt,'n',l:p) < 1
     break
  endif
endwhile
let l:range_beg = l:p+1

call cursor(l:l,1)
let l:range = [l:range_beg,l:range_end]
"end range 

let l:lines = getline(l:range_beg,l:range_end)
let l:block = join(l:lines,"\n")

let l:max = len(l:conceal)
let l:i = l:max - 1

while l:i > -1
if !empty(l:conceal[l:i])
    let l:block = substitute(l:block,l:conceal[l:i],repeat(';',l:i).'\1\2\3\4\5\6\7\8\9','g')
endif
    let l:i -= 1
endwhile
let l:k = 0
let l:structure = []
let l:summary_s = []

let l:lines = split(l:block,"\n")

for l:line in l:lines
let l:i = 0
let l:j = 0
call add(l:structure,[])
call add(l:structure[l:k],match(l:line,'\S'))

   let l:new = l:structure[l:k][0]
if l:k != 0
   let l:old = l:summary_s[0]
   if l:new < l:old
      let l:summary_s[0] = l:new
   endif
else
   call add(l:summary_s,l:new)
endif

let l:line = substitute(l:line,'\s\+',' ','g')
    while 1
       let l:i += 1
       let l:jtemp = matchend(l:line,l:patt,l:j)
       if l:jtemp > -1
          let l:sto = match(l:line,l:patt,l:j) - l:j
	  call add(l:structure[l:k],l:sto)
	  if l:k == 0
	     call add(l:summary_s,l:sto)
	  endif
          let l:j = l:jtemp

          if l:k != 0
             let l:old = get(l:summary_s,l:i,'a')
             let l:new = l:sto
	     if l:old ==# 'a'
	        call add(l:summary_s,0)
             elseif l:new > l:old
                let l:summary_s[l:i] = l:new
             endif
          endif
       else
          break
       endif
    endwhile
    let l:k += 1
endfor
"Formatting
let l:liney = []
let l:lines = getline(l:range_beg,l:range_end)
let l:m = 0
let l:max = len(l:structure[0])

let l:fmt_str = repeat(' ',l:summary_s[0]-1)

for l:ln in l:lines
    let l:format_string = l:fmt_str
    let l:structure[l:m] = l:structure[l:m][1:99]

    let l:n = 1
    for l:c in l:structure[l:m]
        let l:format_string .= '%s'.repeat(' ',l:summary_s[l:n]-l:c).l:ratt
	let l:n += 1
    endfor
    let l:format_string .= '%s'
    let l:lin = substitute(l:ln,'\s\+',' ','g')
    call add(l:liney,call('printf',extend([l:format_string],split(l:lin,l:patt,1))))
    let l:m += 1
endfor
call setline(l:range_beg,l:liney)
call cursor(l:l,l:c)
return ''
endfunction

vnoremap .. :<c-u>s/\%'<.*\%'>./\\{&}/<left><left><left><left>
vnoremap .h :<c-u>call V_Hug()<cr>

function! V_Hug()
     cnoremap ubc underbrace
     cnoremap ubk underbracket
     let l:underbrace = input('hug with: ...\')
     let l:oldpos = getpos("'>") 
     let l:oldpos[2] += strlen(l:underbrace) + 4
     execute "s/\\%'<.*\\%'>./\\\\".l:underbrace."{&}/"
     call setpos('.', l:oldpos)
     cunmap ubc
     cunmap ubk
     startinsert
endfunction

let g:tabcon = [
\ '\$\|\^\|_\|\\\@<!{\|\\\@<!}\|\\left\|\\right\|\\text\|\\logic\|\\type'
\ ,'\\int\|\\implies\|\\&\|\\phi\|\\psi\|\\therefore\|\\partial\|\\leq\|\\geq\|\\approx'
\ ,''
\ ,'\\frac{\(.\{-}\)}{\(.\{-}\)}\|\\dfrac{\(.\{-}\)}{\(.\{-}\)}\|\\tfrac{\(.\{-}\)}{\(.\{-}\)}'
\ ]
let g:amp_operators = [
\ 'arccos' , 'arcsin' , 'arctan',
\ 'cos'    , 'sin'    , 'tan',
\ 'sec'    , 'csc'    , 'cot',
\ 'cosh'   , 'sinh'   , 'tanh', 'coth',
\
\ ['csc','cosec'],['arccos','acos'],['arcsin','asin'],['arctan','atan'],
\
\ 'lim'    ,'liminf','limsup' ,
\ ['liminf','linf'] ,['limsup','lsup'],
\
\ 'arg','deg','det','dim','exp','gcd','hom','inf'    ,'injlim',
\ 'ker','lg' ,'ln' ,'log','max','min','Pr' ,'projlim','sup'   ,
\
\ 'mod','bmod','pmod','pod',
\
\ ['cdot' ,'dot'] ,['cdots','dots'],['equiv','eqv'],
\ ['implies','imp'],['partial','ddel'], ['partial', 'del'],
\
\ 'forall','vdots','exists','cdots','cdot','approx','equiv',
\ 'neq'   ,'leq'  ,'geq'   ,'to'   ,'iff' ,'pm'    ,'mp'   ,
\ 'cup'   ,'cap'  ,'in'    ,'sum'  ,'cong', 'vee', 'wedge',
\ 'tild'  ,'prod'
\ ]
"The last ones are not necessarily math operators, but we'll get the right effect
