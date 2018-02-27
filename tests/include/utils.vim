" Section: Utility functions

" Utility function to assert whether a test file contains the expected content
function! s:assert_file_eq(fname, content)
  " Sleep briefly waiting for dispatched command to finish
  sleep 200m

  " Assemble shell script snippet for asserting the file content
  let l:command =
        \ 'if [[ ' .
        \ '"' . a:content . '" == "$(cat "/tmp/vmux_tests/' . a:fname . '")"' .
        \ ' ]]; then; echo "1"; else; echo "0"; fi'

  " Execute and assert with vader utility function
  Assert system(l:command), 'File content assertion failed for ' . a:fname
endfunction

" Section: Command wrappers for utility functions
command! -nargs=* AssertFileEq :call s:assert_file_eq(<f-args>)
