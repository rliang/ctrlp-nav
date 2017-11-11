if get(g:, 'loaded_ctrlp_nav', 0) | fini | en
let g:loaded_ctrlp_nav = 1

cal add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#nav#init()',
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

fu! ctrlp#nav#init()
  exe 'nn' '<buffer>' get(g:, 'ctrlp#nav#map_up', '<c-u>') ':call ctrlp#nav#accept("", "..")<cr>'
  setl wig+=./,../
  retu glob('{,.}*', 0, 1, 1)
endf

fu! ctrlp#nav#accept(mode, path)
  if isdirectory(a:path)
    sil! exe get(g:, 'ctrlp#nav#cd', 'cd') a:path
    cal ctrlp#exit()
    cal ctrlp#init(ctrlp#nav#id(),{'mode':''})
  el
    cal ctrlp#acceptfile(a:mode, a:path)
  en
endf

