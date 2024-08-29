let s:emj_data = json_decode(readfile(expand('<sfile>:p:h:h') . '/emoji.json'))

fu! s:format_item(item) abort
	let char = a:item['char']
	let cldr = a:item['cldr']
	return char . "\t" . cldr
endfu

fu! s:insert_callback(item, mode) abort
	if type(a:item) == type(v:null)
		return
	endif

	let char = a:item['char']
	if a:mode == 'n'
		call feedkeys('i' . char . "\<Esc>l")
	endif
endfu

fu! emjpick#insert() abort
	let mode = mode()
	if mode != 'n'
		echoerr 'Unsupported mode: "' . mode . '"'
		return
	endif

	cal fzyselect#start(s:emj_data, #{prompt:'emjpick', format_item: {i -> s:format_item(i)}}, {i -> s:insert_callback(i, mode)})
endfu
