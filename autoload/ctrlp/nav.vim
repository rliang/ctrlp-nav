if get(g:, 'loaded_ctrlp_nav', 0) | fini | en
let g:loaded_ctrlp_nav = 1

cal add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#nav#init()',
      \ 'exit': 'ctrlp#nav#exit()',
      \ 'accept': 'ctrlp#nav#accept',
      \ 'lname': 'nav',
      \ 'sname': 'nav',
      \ 'type': 'file',
      \ 'nolim': 1,
      \ 'sort': 1,
      \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

fu! ctrlp#nav#id()
  retu s:id
endf

let s:wpm = 0

fu! ctrlp#nav#init()
  let s:wpm = get(g:, 'ctrlp_working_path_mode', 0)
  let g:ctrlp_working_path_mode = 0
  exe 'nn' '<buffer>' get(g:, 'ctrlp#nav#map_up', '<c-u>') ':call ctrlp#nav#accept("", "..")<cr>'
  setl wig+=./,../
  retu glob('{,.}*', 0, 1, 1)
endf

fu! ctrlp#nav#exit()
  let g:ctrlp_working_path_mode = s:wpm
endf

fu! ctrlp#nav#accept(mode, path)
  if isdirectory(a:path)
    sil! exe get(g:, 'ctrlp#nav#cd', 'cd') a:path
    cal ctrlp#exit()
    cal ctrlp#init(ctrlp#nav#id())
  el
    cal ctrlp#acceptfile(a:mode, a:path)
  en
endf

