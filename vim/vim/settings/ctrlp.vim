let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$|coverage|tmp|vendor$',
	\ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
	\ }
let g:ctrlp_extensions = ['cmdline', 'yankring', 'undo']
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'