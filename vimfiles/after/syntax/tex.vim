" adds support for cleverref package
" \Cref, \cref, \cpageref, \labelcref, \labelcpageref
syn region texRefZone		matchgroup=texStatement start="\\Cref{"				end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\\(label\|\)c\(page\|\)ref{"	end="}\|%stopzone\>"	contains=@texRefGroup

" adds support for listings package
syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>"
syn match texInputFile  "\\lstinputlisting\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
syn match texZone "\\lstinline\s*\(\[.*\]\)\={.\{-}}"
so <sfile>:h/annasyn.vim
"so ~/vimfiles/after/syntax/annasyn.vim
"so ~/vimfiles/after/syntax/annasyn.vim
