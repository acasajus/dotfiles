nnoremap <leader>c :Neomake<CR> 


let g:neomake_cpp_enable_makers = ['clang']
let g:neomake_cpp_clang_args = ["-std=c++11", "-Wextra", "-Wall", "-fsanitize=undefined","-g","-I/usr/local/Cellar/boost/1.58.0/include","-I/usr/local/include/","-stdlib=libc++"]

"Open the window automatically when Neomake is run, but without moving your cursor
let g:neomake_open_list = 2

"autocmd! BufWritePost,BufEnter * Neomake

