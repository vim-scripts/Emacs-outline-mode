"
" File: syntax/outline.vim
"
" Description:
"
"       This uses folding to mimic outline-mode in Emacs.  Set the filetype to
"       'outline' to activate this functinality.  Put it in the modeline to
"       preserve outlines between edits.  For example:
"
"               vim:set ft=outline:
"
" Installation:
"
"   Place this file in your home directory under ~/.vim/syntax/, or in the
"   system location under the syntax/ directory to provide it to all users.
"
" Maintainer: Tye Z. <zdro@yahoo.com>
"
" Customization:
"
"   The colors of the outline headers can be changed by linking them to
"   whatever you like.  For example:
"
"       hi! link Outline_1 Statement
"
" History:
"
"   Version 1.1:
"
"       - Initial version
"


"
" Highlighting for the section header lines.  Add to these for more levels.
"
syn match Outline_1   /^\*\{1\}[^*].*$/
syn match Outline_2   /^\*\{2\}[^*].*$/
syn match Outline_3   /^\*\{3\}[^*].*$/
syn match Outline_4   /^\*\{4\}[^*].*$/

hi! default link Outline_1 Comment
hi! default link Outline_2 Identifier
hi! default link Outline_3 PreProc
hi! default link Outline_4 Type




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


setl foldmethod=expr
setl foldexpr=OutlineFoldFunc()

function! OutlineFoldFunc()
    let line = getline(v:lnum)
    " If the current line starts with a '*', then this is the start of a fold.
    if line =~ '^\*'
        return ">" . matchend(line, "^\**")
    else
        " Since this is not the start of a fold, see if this is the END of
        " one.  We are at the end of a fold when the next line has nothing but
        " whitespace, and the following line is the start of a fold.  We look
        " two lines ahead so we can display only the LAST blank line.  If
        " there are no blank lines, then the start of the next fold will
        " automatically end this one.
        let line2 = getline(v:lnum+1)
        if line2 =~ '^\s*$'
            let line3 = getline(v:lnum+2)
            if line3 =~ '^\*'
                return "<" . matchend(line3, "^\**")
            endif
        endif
    endif
    return "="  " fold-level has not changed
endfunction

