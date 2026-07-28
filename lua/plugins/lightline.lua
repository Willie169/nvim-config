return {
	{
		"itchyny/lightline.vim",
		dependencies = {
			"tpope/vim-fugitive",
		},
		init = function()
			vim.cmd([[
                let g:lightline = {
                      \ 'colorscheme': 'wombat',
                      \ 'active': {
                      \   'left': [ ['mode', 'paste'],
                      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
                      \   'right': [ [ 'lineinfo' ], ['percent'] ]
                      \ },
                      \ 'component': {
                      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
                      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
                      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
                      \ },
                      \ 'component_visible_condition': {
                      \   'readonly': '(&filetype!="help"&& &readonly)',
                      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
                      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
                      \ },
                      \ 'separator': { 'left': ' ', 'right': ' ' },
                      \ 'subseparator': { 'left': ' ', 'right': ' ' }
                      \ }
            ]])
		end,
	},
}
