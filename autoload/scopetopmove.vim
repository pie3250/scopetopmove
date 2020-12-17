" //--------------------------------------------------------------------------------------------------
" /**
"  * @file    scopetopmove.vim
"  * @brief   scopetop move script
"  * @author  pie3250
"  * @date    2018.03.27 (Tue)
"  */
" //--------------------------------------------------------------------------------------------------
" // Last Change:2020/12/17 23:24:19 (Thu).

"encoding
scriptencoding utf-8

let s:ignoreList = ["if", "else", "for", "switch", "while", "struct", "enum"]

" search to EOF
function! scopetopmove#searchAndMoveNormal()
    let l:nowCursorPos = line('.')
    let l:cursorPos = l:nowCursorPos + 1
    " write to jump list(using ctrl + i, ctrl + o)
    execute 'normal gg'
    execute 'keepjumps normal ' + l:nowCursorPos + ' G'

    let l:findFlg = 0
    let l:prevLineString = getline('.')

    let lines = getline(l:cursorPos, '$')
    if !empty(lines)
        for i in lines
            let l:ignoreCheckFlg = 0
            if match(i, '^{') >= 0
                let l:ignoreCheckFlg = 1
            elseif match(i, '{$') >= 0
                let l:ignoreCheckFlg = 1
                let l:prevLineString = ''
            endif

            if l:ignoreCheckFlg == 1
                " check ignore pattern prev line
                if s:checkIgnorePattern(l:prevLineString) == 0
                    if s:checkIgnorePattern(i) == 0
                        let l:result = s:checkIgnoreString(i)
                        if l:result != 0
                            call cursor(l:cursorPos, 1)
                            " keepjumps
                            execute 'keepjumps normal' . '$'
                            execute 'keepjumps normal' . '%'
                            let l:endCheck = getline('.')
                            if match(l:endCheck, '^}') >= 0
                                let l:result = 0
                            endif
                        endif
                        if l:result == 0
                            call cursor(l:cursorPos, 1)
                            execute 'keepjumps normal' . '0'
                            let l:findFlg = 1
                            break
                        endif
                    endif
                endif
            endif
            let l:cursorPos += 1
            let l:prevLineString = i
        endfor

        " not found to Top
        if l:findFlg == 0
            call cursor('$', 1)
        endif
    else
        call cursor('$', 1)
    endif
endfunction

" search to TOP
function! scopetopmove#searchAndMoveReverse()
    let l:nowCursorPos = line('.')
    let l:cursorPos = l:nowCursorPos - 1
    " write to jump list(using ctrl + i, ctrl + o)
    execute 'normal gg'
    execute 'keepjumps normal ' + l:nowCursorPos + ' G'

    let l:findFlg = 0

    if l:cursorPos > 0
        let lines = getline(1, l:cursorPos)
        let l:dataNum = len(lines)
        let l:cursorPos = (l:dataNum - 1)

        for i in lines
            let l:checkString = lines[l:cursorPos]
            let l:ignoreCheckFlg = 0
            let l:prevLineString = ''
            if match(l:checkString, '^{') >= 0
                let l:ignoreCheckFlg = 1

                " check prev line
                if ((l:cursorPos - 1) >= 0)
                    let l:prevLineString = lines[l:cursorPos - 1]
                endif
            elseif match(l:checkString, '{$') >= 0
                let l:ignoreCheckFlg = 1
            endif


            if l:ignoreCheckFlg == 1
                if s:checkIgnorePattern(l:prevLineString) == 0
                    if s:checkIgnorePattern(l:checkString) == 0
                        let l:result = s:checkIgnoreString(l:checkString)
                        if l:result != 0
                            call cursor(l:cursorPos + 1, 1)
                            execute 'keepjumps normal' . '$'
                            execute 'keepjumps normal' . '%'
                            let l:endCheck = getline('.')
                            if match(l:endCheck, '^}') >= 0
                                let l:result = 0
                            endif
                        endif
                        if l:result == 0
                            let l:findFlg = 1
                            call cursor(l:cursorPos + 1, 1)
                            execute 'keepjumps normal' . '0'
                            break
                        endif
                    endif
                endif
            endif

            let l:cursorPos -= 1
        endfor
        " not found to Top
        if l:findFlg == 0
            call cursor(1, 1)
        endif
    endif
endfunction

" check ignore string pattern
function! s:checkIgnorePattern(checkString)
    for i in s:ignoreList
        let l:ignoreString = '\<' . i
        " if match(a:checkString, l:ignoreString) >= 0
        "   return 1
        " endif

        " case-sensitive
        if a:checkString ==# l:ignoreString
            return 1
        endif
    endfor
    return 0
endfunction

" count character
function! s:matchCount(checkString, pattern, ...)
    let l:start = get(a:, "1", 0)
    let l:result = match(a:checkString, a:pattern, start)
    return l:result == -1 ? 0 : s:matchCount(a:checkString, a:pattern, l:result+1) + 1
endfunction

" check ignore string
function! s:checkIgnoreString(checkString)
    let l:result = 0
    if match(a:checkString, '\t') >= 0
        " ignore tab
        let l:result = 1
    elseif match(a:checkString, ' ') == 0
        " ignore space
        let l:result = 2
    elseif match(a:checkString, '/') == 0
        " ignore slash
        let l:result = 3
    else
        if s:checkIgnorePattern(a:checkString) != 0
            let l:result = 4
        endif
    endif
    return result
endfunction

