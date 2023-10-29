#! /bin/sh

# how to make the style.css file:
#
# pygmentize -f html -S gruvbox-dark > ~/src/sogaiu.github.io/test/style.css

# how to make the boot.janet.hl file:
#
# pygmentize -P style=gruvbox-dark \
#             -f html \
#             -O full,debug_token_types \
#             -o  ~/src/sogaiu.github.io/test/boot.janet.hl \
#             ~/src/janet/src/boot/boot.janet

cat header boot.janet.hl footer > boot.janet.html
