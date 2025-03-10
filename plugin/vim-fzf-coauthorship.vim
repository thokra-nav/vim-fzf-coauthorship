function! AttributeCoauthorship(nameAndEmail)
  let attribution = "Co-authored-by: " . a:nameAndEmail
  silent put =attribution
endfunction

function! Coauthorship()
  call fzf#run({
    \ 'source': "bash -c '{ git log --format=\"%n %(trailers:key=Co-authored-by)\" | grep -oP \"(?<=Co-authored-by: )(.*)\" & git log --pretty=\"%an <%ae>\" ;} | sort | uniq | grep -v dependabot'",
    \ 'sink': function('AttributeCoauthorship'),
    \ 'options': "-i --multi --preview 'git log -1 --author {} --pretty=\"authored %h %ar:%n%n%B\"'"
    \ })
endfunction

command! Coauthorship call Coauthorship()
