"For vim conceal to work
set conceallevel=2
hi  clear conceal
"For updating you when I change modes (MATH,LIST etc)
set laststatus=2

hi AnnaWarning  gui=bold guibg=#FF1719 guifg=black
hi AnnaMetaData gui=bold guifg=#777777
hi AnnaConcealSubgroup gui=bold
hi AnnaGreyedOut guifg=#444444
hi AnnaFlashCardTags guifg=#444444
hi AnnaSubsection guifg=#777777
hi AnnaSubSubSection guifg=#444444
hi AnnaSection gui=bold
hi AnnaBold gui=bold
hi AnnaBoldMath gui=bold
hi AnnaMathBB gui=bold
hi AnnaLogic guifg=#058C73
hi AnnaType guifg=#8F44A3
hi AnnaNote gui=bold guifg=#FF9F2A
hi AnnaFlashCardHeadCardTypeFo gui=bold guifg=#BCE04C
hi AnnaFlashCardHeadCardTypeDe gui=bold guifg=#0AB0EF
hi AnnaFlashCardHeadCardTypeBa gui=bold guifg=#EBEBEB
hi AnnaFlashCardHeadCardTypeMe gui=bold guifg=#F7980F
hi AnnaFlashCardHeadCardTypePr gui=bold guifg=#DFE7D9
hi AnnaFlashCardHeadCardTypeTh gui=bold guifg=#8ED35A
hi AnnaFlashCardRestOfHead gui=bold
hi AnnaTextE gui=italic cterm=italic
hi texUnderlineStyle gui=underline cterm=underline
hi AnnaExtraMathAns gui=underline cterm=underline
 call TexNewMathZone("L","align*",0)

"Italic Bold text fix
syn region texBoldStyle	matchgroup=texTypeStyle start="\\textbf\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell,texUnderlineStyle
syn region texUnderlineStyle	matchgroup=texTypeStyle start="\\underline\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell
syn region texItalStyle	matchgroup=texTypeStyle start="\\emph\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell,texUnderlineStyle
syn cluster texDocMegaGroup		contains=texPartZone,texChapterZone,texSectionZone,texParaZone,texSubSectionZone,texSubSubSectionZone,texSubParaZone,texDocZone,@Spell

syntax match  AnnaSetCounter '\\setcounter{.\{-}}{.\{-}}' containedin=ALL conceal
syntax region AnnaBoldMath matchgroup=AnnaConceals start='\\vect{' end='}' concealends contains=@texMathZoneGroup
syntax region AnnaExtraMath matchgroup=AnnaConceals start='\\lim_{' end='}' contains=@texMathZoneGroup,AnnaExtraMathLim oneline
syntax match  AnnaExtraMathLim '\\lim_{' contained contains=@texMathZoneGroup,AnnaConcealBackSlash,AnnaConcealDownDash
syntax region AnnaExtraMath start='\\tag'   end='}\ze\\\\' contains=@texMathZoneGroup,AnnaExtraMathTag oneline
syntax region AnnaExtraMath start='\\tag\*' end='}\ze\\\\' contains=@texMathZoneGroup,AnnaExtraMathTagT oneline
syntax region AnnaExtraMath matchgroup=AnnaConceals concealends start='\\circled' end='}' contains=@texMathZoneGroup,AnnaExtraMathTag cchar=)
syntax match  AnnaExtraMathTag '\\tag' contained contains=AnnaConcealAll
syntax match  AnnaExtraMathTagT '\\tag\*{' contained contains=AnnaConcealAll
syntax match  AnnaExtraMathTag '{'      contained conceal cchar=(
syntax match  AnnaExtraMathTag '}'      contained conceal cchar=)
syntax match  AnnaExtraMathTagT '}'      contained conceal cchar= 
syntax region AnnaExtraMathAns matchgroup=AnnaConceals start='\\ans{' end='}' concealends contains=@texMathZoneGroup
syntax match AnnaExtraMath '\\\\' conceal contained
syntax match AnnaExtraMath '\\not' conceal cchar=¬ contained
syntax match AnnaExtraMath '\\not=' conceal cchar=≠ contained
syntax match AnnaExtraMath '&=' conceal cchar== contained
syntax match AnnaExtraMath '&+' conceal cchar=+ contained
syntax match AnnaExtraMath '&-' conceal cchar=- contained
syntax match AnnaExtraMath '&>' conceal cchar=> contained
syntax match AnnaExtraMath '&<' conceal cchar=< contained
syntax match AnnaExtraMath '&\\leq' conceal cchar=≤ contained
syntax match AnnaExtraMath '&\\geq' conceal cchar=≥ contained
syntax match AnnaExtraMath '&\\implies' conceal cchar=⇒ contained
syntax match AnnaExtraMath '\\sin' contains=AnnaConcealBackSlash transparent
syntax match AnnaExtraMath '\\cos' contains=AnnaConcealBackSlash transparent
syntax match AnnaExtraMath '\\tan' contains=AnnaConcealBackSlash transparent
syntax match AnnaExtraMath '\\qq\=uad' contains=AnnaConcealAll containedin=@texMathZones contained
syntax match AnnaExtraMath '\\dot{x}' containedin=@texMathZones contained conceal cchar=ẋ contained
syntax match AnnaExtraMath '\\ddot{x}' containedin=@texMathZones contained conceal cchar=ẍ contained
syntax match AnnaExtraMath '\\dot{y}' containedin=@texMathZones contained conceal cchar=ẏ contained
syntax match AnnaExtraMath '\\ddot{y}' containedin=@texMathZones contained conceal cchar=ÿ contained
syntax match AnnaConcealAll '.' contained cchar=  conceal
syntax match AnnaConcealDownDash '_' conceal contained

syntax cluster texMathZoneGroup add=AnnaExtraMath,AnnaBoldMath,AnnaExtraMathAns

"syntax region AnnaFlashCard matchgroup=AnnaGreyedOutFormula start='\\\zebegin{\(Theorem\|Properties\|Method\|Formula\|cDefinition\|Definition\|FlashCard\)}' end='\\end{\(Theorem\|Properties\|Method\|Formula\|cDefinition\|Definition\|FlashCard\)}' containedin=@texDocMegaGroup concealends cchar=▬ contains=AnnaLogic,AnnaType,texBoldStyle,texUnderlineStyle,texItalStyle,@texMathZones,@Spell
syntax region AnnaFlashCard matchgroup=AnnaGreyedOutFormula start='\\\zebegin{\(Action\|Steps\|Vocab\|Basic\|Compare\|Questions\|FlashCard\)}' end='\\end{\(Action\|Steps\|Vocab\|Basic\|Compare\|Questions\|FlashCard\)}' containedin=@texDocMegaGroup concealends cchar=▬ contains=AnnaLogic,AnnaType,texBoldStyle,texUnderlineStyle,texItalStyle,@texMathZones,@Spell
    syntax region AnnaFlashCardID start='}%\n{' end='}$' containedin=AnnaFlashCard contained conceal oneline
syntax region AnnaFlashCardHead start='begin{' end='\ze}%$' containedin=AnnaFlashCard contained oneline contains=AnnaConcealCloseBraceWithSpace
    syntax match AnnaFlashCardHeadLead	'begin{.\{-}}'	containedin=AnnaFlashCardHead		contained contains=AnnaConcealCloseBraceWithSpace,AnnaConcealOpenBraceWithSpace
        syntax match AnnaFlashCardHeadBegin		'begin' 		containedin=AnnaFlashCardHeadLead	contained conceal cchar=▬
        syntax match AnnaFlashCardHeadCardTypeFo	'Action'		containedin=AnnaFlashCardHeadLead	contained
        syntax match AnnaFlashCardHeadCardTypeDe	'Steps'		containedin=AnnaFlashCardHeadLead	contained
        syntax match AnnaFlashCardHeadCardTypeDe	'Steps'		containedin=AnnaFlashCardHeadLead	contained
        syntax match AnnaFlashCardHeadCardTypeMe	'Vocab'		containedin=AnnaFlashCardHeadLead	contained
        syntax match AnnaFlashCardHeadCardTypeBa	'Basic'		containedin=AnnaFlashCardHeadLead	contained
        syntax match AnnaFlashCardHeadCardTypePr	'Compare'		containedin=AnnaFlashCardHeadLead	contained
        syntax match AnnaFlashCardHeadBegin		'FlashCard}{'		containedin=AnnaFlashCardHeadLead	contained conceal
        syntax match AnnaFlashCardHeadCardTypeTh	'Questions'		containedin=AnnaFlashCardHeadLead	contained
    syntax region AnnaFlashCardRestOfHead start='{' end='\ze}%$' oneline contained containedin=AnnaFlashCardHead contains=@texMathZones,AnnaConceals
        syntax match AnnaFlashCardHeadStart '{' conceal contained containedin=AnnaFlashCardRestOfHead
        syntax region AnnaFlashCardTags start='}{' end='\ze}%$' oneline contained containedin=AnnaFlashCardRestOfHead
           syntax match AnnaFlashCardTagsBraces '}' conceal cchar=▪  contained containedin=AnnaFlashCardTags
           syntax match AnnaFlashCardTagsBraces '{' conceal cchar=   contained containedin=AnnaFlashCardTags

syntax region AnnaFlashCardField matchgroup=AnnaGreyedOutFormula start='^ ' end='}%\=$' containedin=AnnaFlashCard contained concealends contains=@texMathZones,AnnaConcealOpenBraceWithSpace,AnnaConcealCloseBraceWithColon,AnnaFlashCardFieldDot,AnnaLogic,AnnaType,texBoldStyle,texUnderlineStyle,texItalStyle,@Spell
    syntax match AnnaFlashCardFieldDot '\\Field' conceal cchar=● contained

syntax region AnnaMetaData matchgroup=texDefName start='\\documentclass' end='\ze\\begin{document}' conceal cchar=_
syntax region AnnaMetaData matchgroup=texDefName start='\\listoftodos'   end='\ze\\end{document}'   conceal cchar=_ containedin=@texDocMegaGroup
syntax region AnnaMetaData matchgroup=texDefName start='\\newpage'       end='\ze\\end{document}'   conceal cchar=_ containedin=@texDocMegaGroup
syntax region AnnaMetaData matchgroup=texDefName start='\\lecture'       end=/$/ contains=AnnaConcealBackSlash,AnnaConcealCloseBraceWithSpace,AnnaConcealOpenBraceWithSquare concealends containedin=@texDocMegaGroup
syntax match AnnaConcealBraces '}' contained conceal containedin=AnnaNote
syntax match AnnaConcealCloseBrace '}' contained conceal
syntax match AnnaConcealBraces '{' contained conceal
syntax match AnnaConcealBackSlash '\\' contained conceal
syntax cluster AnnaConcealBracesAndBackSlash contains=AnnaConcealBraces,AnnaConcealBackSlash
syntax cluster AnnaConcealBracesAndBackSlash_OpenSpace contains=AnnaConcealOpenBraceWithSpace,AnnaConcealCloseBraceWithSpace,AnnaConcealBackSlash
syntax cluster AnnaConcealBracesAndBackSlash_OpenColon contains=AnnaConcealOpenBraceWithColon,AnnaConcealCloseBraceWithSpace,AnnaConcealBackSlash

syntax match AnnaConcealOpenBraceWithSquare  '{' contained conceal cchar=▪|
syntax match AnnaConcealOpenBraceWithColon   '{' contained conceal cchar=:|
syntax match AnnaConcealCloseBraceWithColon  '}' contained conceal cchar=:|
syntax match AnnaConcealOpenBraceWithSpace   '{' contained conceal cchar= |
syntax match AnnaConcealCloseBraceWithSpace  '}' contained conceal cchar= |

syntax match AnnaConcealCommands '\\begin{grouping}' containedin=@texDocMegaGroup conceal cchar=┌
syntax match AnnaConcealCommands '\\end{grouping}' containedin=@texDocMegaGroup conceal cchar=└
syntax match AnnaConcealCommands '\\subgroup' containedin=@texDocMegaGroup conceal cchar=├
syntax region AnnaConcealSubgroup matchgroup=AnnaGreyedOut concealends  start='\\\zesubgroup\[' end='\]$' oneline containedin=@texDocMegaGroup contains=@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,@Spell
syntax match AnnaConcealCommands 'subg\zeroup\[' conceal cchar=├ containedin=AnnaConcealSubgroup
syntax match AnnaConcealCommands 'r\zeoup\[' conceal containedin=AnnaConcealSubgroup cchar= |
syntax match AnnaConcealCommands 'o\zeup\[' conceal containedin=AnnaConcealSubgroup cchar= |
syntax match AnnaConcealCommands 'u\zep\[' conceal containedin=AnnaConcealSubgroup cchar= |
syntax match AnnaConcealCommands 'p\ze\[' conceal containedin=AnnaConcealSubgroup cchar= |
syntax match AnnaConcealCommands '\[' conceal containedin=AnnaConcealSubgroup cchar= |

syntax region AnnaTabular matchgroup=AnnaGreyedOut start='\\begin{tabular}.\{-}}' end='\\end{tabular}' transparent containedin=ALL contains=AnnaTabularBars,AnnaTabularBarsBlank,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,@Spell
syntax region AnnaEnumBars0 matchgroup=AnnaGreyedOut start='\\begin{enumerate}' end='\\end{enumerate}' transparent containedin=ALL contains=@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,AnnaFlashCard,@Spell
syntax region AnnaEnumBarsLL0 matchgroup=AnnaGreyedOut start='\\begin{enumerate}' end='\\end{enumerate}' transparent containedin=AnnaEnumBars0 contains=@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,AnnaFlashCard,@Spell
syntax region AnnaList matchgroup=AnnaGreyedOut start='\\begin{itemize}' end='\\end{itemize}' transparent containedin=ALL contains=AnnaListBarsItem,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,AnnaFlashCard,@Spell
syntax region AnnaListL1 matchgroup=AnnaGreyedOut start='\\begin{itemize}' end='\\end{itemize}' transparent containedin=AnnaList	contained concealends contains=AnnaListBarsItemL1,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,@Spell
syntax region AnnaListL2 matchgroup=AnnaGreyedOut start='\\begin{itemize}' end='\\end{itemize}' transparent containedin=AnnaListL1	contained concealends contains=AnnaListBarsItemL2,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,@Spell
syntax region AnnaListL3 matchgroup=AnnaGreyedOut start='\\begin{itemize}' end='\\end{itemize}' transparent containedin=AnnaListL2	contained concealends contains=AnnaListBarsItemL3,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup,@Spell

syntax match AnnaConceals '\\ldots'	conceal cchar=… 
syntax match AnnaConceals '\\eg'	contains=AnnaConcealBackSlash
syntax match AnnaConceals '\\ie'	contains=AnnaConcealBackSlash

"syntax region AnnaContext matchgroup=AnnaGreyedOut concealends start='\\Context' end="}\zs\1\ze" transparent
syntax region AnnaLogic matchgroup=AnnaGreyedOut concealends start='\\logic{' end="}" containedin=ALL
syntax region AnnaType matchgroup=AnnaGreyedOut concealends start='\\type{' end="}" containedin=ALL
syntax region AnnaType matchgroup=AnnaNote start='\\note\|\\nb' end=/$/ contains=@AnnaConcealBracesAndBackSlash_OpenSpace
"syntax region AnnaTextE matchgroup=AnnaText concealends start='\\text{' end='}' containedin=@texMathZoneGroup contained
syntax region AnnaTextE	matchgroup=texTypeStyle start="\\text\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell,texUnderlineStyle containedin=@texMathZones contained
syntax region AnnaMatrixEq transparent matchgroup=AnnaGreyedOut start='\\begin{matrixeq}.\{-}}' end='\\end{matrixeq}' contains=AnnaMatrixEqBars,@texMathZoneGroup containedin=@texMathZoneGroup
syntax region AnnaMathBB concealends matchgroup=AnnaGreyedOut start='\\mathbb{' end='}' containedin=@texMathZoneGroup contained

syntax match AnnaMatrixEqBars ')(' contained conceal cchar=│
"syntax match AnnaFrac '\\frac{.\{-}}.\{-}}' transparent containedin=@texMathZoneGroup contains=AnnaFracSlash,@texMathZoneGroup
"syntax match AnnaMathCurlies '{\_.\{-}}' contains=@texMathZones,AnnaMathCurl containedin=@texMathZoneGroup contained
syntax region AnnaFrac matchgroup=AnnaFracDelim start='\\\(t\|d\)\=frac' skip='}{' end='}' oneline transparent containedin=@texMathZoneGroup contains=AnnaFracSlash,@texMathZoneGroup concealends cchar=) 
syntax cluster texMathZoneGroup add=AnnaFrac

syntax region AnnaSection start='\c\\section' end='}\|$' contains=@AnnaConcealBracesAndBackSlash_OpenSpace,@Spell contained containedin=@texDocMegaGroup
syntax region AnnaSubsection start='\\subsection' end='}\|$' contains=@Spell,@AnnaConcealBracesAndBackSlash_OpenSpace contained containedin=@texDocMegaGroup
syntax region AnnaSubSubsection start='\\subsubsection' end='}\|$' contains=@Spell,@AnnaConcealBracesAndBackSlash_OpenSpace contained containedin=@texDocMegaGroup
syntax match AnnaMediaControls '\\Plan{.\{-}}' contains=@AnnaConcealBracesAndBackSlash_OpenColon contained containedin=@texDocMegaGroup
syntax match AnnaMediaControls '\\Play' contains=AnnaConcealBackSlash,AnnaConcealBackSlashWithPlay contained containedin=@texDocMegaGroup
syntax match AnnaConcealBackSlashWithPlay '\\' contained conceal cchar=►

syntax match AnnaConcealCommands '\c\\section' conceal cchar=§ containedin=AnnaSection
syntax match AnnaConcealCommands '\\subsection' conceal cchar=§ containedin=AnnaSubsection
syntax match AnnaConcealCommands '\\subsubsection' conceal cchar=§ containedin=AnnaSubSubsection
syntax keyword AnnaConcealCommands lecture contained conceal containedin=AnnaMetaData

syntax match AnnaSymbols '\\&' conceal cchar=& containedin=ALL
syntax match AnnaSymbols '\\#' conceal cchar=# containedin=ALL

syntax match AnnaTabularBarsBlank '\\bl' contained
syntax match AnnaTabularBarsA '.' conceal cchar=  containedin=AnnaTabularBarsBlank contained
syntax match AnnaTabularBars '\\\\' conceal contained
syntax match AnnaTabularBars '\\\@<!&' conceal cchar=│ contained

syntax match AnnaListBarsItem   '\\item' contained
syntax match AnnaListBarsItemL1 '\\item' conceal cchar=━ contained
syntax match AnnaListBarsItemL2 '\\item' conceal cchar=─ contained
syntax match AnnaListBarsItemL3 '\\item' conceal cchar=- contained

syntax match AnnaListBarsItemA  '.' conceal cchar=  containedin=AnnaListBarsItem,AnnaListBarsItemL1,AnnaListBarsItemL2,AnnaListBarsItemL3 contained
syntax match AnnaListBarsItemA  'm' conceal cchar=● containedin=AnnaListBarsItem contained
syntax match AnnaListBarsItemA  'm' conceal cchar=━ containedin=AnnaListBarsItemL1 contained
syntax match AnnaListBarsItemA  'm' conceal cchar=─ containedin=AnnaListBarsItemL2 contained
syntax match AnnaListBarsItemA  'm' conceal cchar=- containedin=AnnaListBarsItemL3 contained

function! AnnaEnumSmartConceal(end)
 syntax match AnnaEnumXBarsItemA            '.'    conceal contained cchar=  
 syntax match AnnaEnumDotForem              'm'    conceal contained cchar=.
 syntax region AnnaEnumBars1          start='\\item\ze\s' end='\ze\\end{enumerate}' contained containedin=AnnaEnumBars0 contains=@Spell,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup
 syntax region AnnaEnumBarsLL1        start='\\item\ze\s' end='\ze\\end{enumerate}' contained containedin=AnnaEnumBarsLL0 contains=@Spell,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup
 syntax match  AnnaEnum1Bars '\\item\ze\s' contained containedin=AnnaEnumBars1 contains=AnnaEnumDotForem,AnnaEnumConcealtFor1,AnnaEnumConcealiFor,AnnaEnumXBarsItemA
 syntax match  AnnaEnumLL1Bars '\\item\ze\s' contained containedin=AnnaEnumBars1 contains=AnnaEnumDotForem,AnnaEnumConcealtFor1,AnnaEnumConcealiFor,AnnaEnumXBarsItemA

 syntax cluster AnnaEnumBarsCluster add=AnnaEnumBars1
 syntax cluster AnnaEnumBarsLLCluster add=AnnaEnumBarsLL1

 let l:range = range(2,a:end)
 let l:quote         = "'"
 let l:eye   = l:quote.'t'.l:quote
 let l:tee   = l:quote.'e'.l:quote

 for l:num in range(10)
    execute 'syntax match AnnaEnumConcealiFor'.    l:num.' '. l:eye .' conceal contained cchar='.l:num
    execute 'syntax match AnnaEnumConcealtFor'.    l:num.' '. l:tee .' conceal contained cchar='.l:num
 endfor
 for l:num in range(26)
    execute 'syntax match AnnaEnumConcealtFor'.    nr2char(97+l:num).' '. l:tee .' conceal contained cchar='.nr2char(97+l:num)
 endfor
 let l:start  = l:quote.'\n.\{-}\ze\\item'.l:quote
 let l:end    = l:quote.'\ze\\end{enumerate}'.l:quote
 let l:esitem = l:quote.'\\item'.l:quote
 
 for l:item in l:range
    execute 'syntax cluster AnnaEnumBarsCluster add=AnnaEnumBars'.l:item
    if strlen(l:item) == 1
       let l:tens_digit = ''
       let l:unit_digit = l:item[0]
      execute 'syntax region AnnaEnumBars'.l:item.' start='.l:start.' end='.l:end.' contained contains=@Spell,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup containedin=AnnaEnumBars'.(l:item-1)
      execute 'syntax match  AnnaEnum'.l:item.'Bars '.l:esitem.' contained containedin=AnnaEnumBars'.l:item.' contains=AnnaEnumDotForem,AnnaEnumConcealiFor'.l:tens_digit.',AnnaEnumConcealtFor'.l:unit_digit.',AnnaEnumXBarsItemA'
    else 
       let l:tens_digit = l:item[0]
       let l:unit_digit = l:item[1]
      execute 'syntax region AnnaEnumBars'.l:item.' start='.l:start.' end='.l:end.' contained contains=@Spell,@texMathZones,texTypeStyle,@texBoldGroup,@texItalGroup containedin=AnnaEnumBars'.(l:item-1)
      execute 'syntax match  AnnaEnum'.l:item.'Bars '.l:esitem.' contained containedin=AnnaEnumBars'.l:item.' contains=AnnaEnumDotForem,AnnaEnumConcealiFor'.l:tens_digit.',AnnaEnumConcealtFor'.l:unit_digit.',AnnaEnumXBarsItemA'
    endif
 endfor
endfunction
call AnnaEnumSmartConceal(99)
delf AnnaEnumSmartConceal
"Rough draft
"syntax match AnnaEnumConcealiFor0 'i'    conceal contained cchar=0
"syntax region AnnaEnumBars1 start='\\item'           end='\ze\\end{enumerate}' contained containedin=AnnaEnum
"syntax region AnnaEnumBars2 start='\n.\{-}\ze\\item' end='\ze\\end{enumerate}' contained containedin=AnnaEnumBars1 
"syntax match AnnaEnum1Bars '\\item' contained containedin=AnnaEnumBars1 contains=AnnaEnumDotFortem,AnnaEnum1,AnnaEnumConcealiFor
"syntax match AnnaEnum1 '\\' conceal cchar=1
"Old
"syntax match AnnaListBarsEnum   '\\item' conceal cchar=◆ contained

"syntax match AnnaFracSlash '}' conceal cchar=) contained
syntax match AnnaFracSlash '}{' conceal cchar=/ contained
"syntax match AnnaFracSlash '\\frac{' conceal cchar=( contained
syntax match AnnaFracSlash '{' conceal cchar=( contained
syntax match AnnaMathCurl '{' conceal contained
syntax match AnnaMathCurl '}' conceal contained
"syntax region AnnaMathCurlies start='{' end='}' contains=@texMathZones containedin=@texMathZoneGroup concealends

"Redefining texDocZone so that we can concealends
if !exists("g:tex_fold_enabled")
 let s:tex_fold_enabled= 0
elseif g:tex_fold_enabled && !has("folding")
 let s:tex_fold_enabled= 0
else
 let s:tex_fold_enabled= 1
endif

if s:tex_fold_enabled && has("folding")
 com! -nargs=* TexFold <args> fold 
else
 com! -nargs=* TexFold <args> 
endif

" by default, enable all region-based highlighting
let s:tex_fast= "bcmMprsSvV"
if exists("g:tex_fast")
 if type(g:tex_fast) != 1
  " g:tex_fast exists and is not a string, so
  " turn off all optional region-based highighting
  let s:tex_fast= ""
 else
  let s:tex_fast= g:tex_fast
 endif
endif

if exists("g:tex_nospell") && g:tex_nospell
 let s:tex_nospell = 1
else
 let s:tex_nospell = 0
endif

if s:tex_fast =~# 'p'
 if !s:tex_nospell
TexFold syn region texDocZone matchgroup=texSection start='\\begin\s*{\s*document\s*}\|%{document}' end='\\end\s*{\s*document\s*}\|\ze%{document}' contains=@texFoldGroup,@texDocGroup    concealends
 else
TexFold syn region texDocZone matchgroup=texSection start='\\begin\s*{\s*document\s*}\|%{document}' end='\\end\s*{\s*document\s*}\|\ze%{document}' contains=@texFoldGroup,@texDocGroup,@Spell concealends
 endif
endif

delc TexFold
