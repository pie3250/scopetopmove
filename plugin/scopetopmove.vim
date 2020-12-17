" //--------------------------------------------------------------------------------------------------
" /**
"  * @file    scopetopmove.vim
"  * @brief   scopetop move script
"  * @author  pie3250
"  * @date    2018.03.27 (Tue)
"  */
" //--------------------------------------------------------------------------------------------------
" // Last Change:2020/12/17 23:25:29 (Thu).

"encoding
scriptencoding utf-8

nnoremap ]] :call scopetopmove#searchAndMoveNormal()<CR>
nnoremap [[ :call scopetopmove#searchAndMoveReverse()<CR>

