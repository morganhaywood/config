# kakrc

# init
set global ui_options ncurses_assistant=cat
set -add global ui_options ncurses_set_title=false
set -add global ui_options ncurses_enable_mouse=false

# indents
set global indentwidth 4
set global tabstop 4
set global scrolloff 10,1

# user
map global user = '<a-i>w:spell-replace<ret>' -docstring 'spell replace word'
map global user c ':comment-line<ret>' -docstring 'comment toggle selected lines'
map global user l ':lint-next-error<ret>' -docstring 'next lint error'
map global user L ':lint-previous-error<ret>' -docstring 'previous lint error'

## external commands
map global user f 'fmt -w 80<ret>' -docstring '|fmt -w 80'
map global user p '<a-!>pbpaste<ret>' -docstring 'append from clipboard'
map global user P '!pbpaste<ret>' -docstring 'insert from clipboard'
map global user r '|pbpaste<ret>' -docstring 'replace with clipboard'

# hooks
hook global WinCreate .* %{
    add-highlighter window/ number-lines -hlcursor -separator ' | '
    add-highlighter window/ show-matching
}

hook global InsertChar \t %{exec -draft h@ } #convert tabs to spaces
hook global NormalKey y|d|c %{ nop %sh{ printf %s "$kak_reg_dquote" | pbcopy }}

## go
hook global WinSetOption filetype=go %{
    set window lintcmd 'revive 2>&1'
    set window formatcmd goimports
    set window makecmd 'go build -x'

    lint-enable

    hook buffer BufWritePre .* %{ go-format -use-goimports }
    hook buffer BufWritePost .* lint
}

## shell
hook global WinSetOption filetype=sh %{
    set window lintcmd 'shellcheck -fgcc -Cnever'
    lint-enable
    hook buffer BufWritePost .* lint
}

## yaml
hook global WinSetOption filetype=yaml %{
    set window indentwidth 2
    set window tabstop 2
    set window lintcmd 'yamllint -f parsable'
    lint-enable
    hook buffer BufWritePost .* lint
}
