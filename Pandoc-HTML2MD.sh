#! /bin/bash
find . -name \*.html -type f -exec pandoc -o {}.md {} \;
