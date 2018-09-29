#!/usr/bin/env zsh

gen_pdf_writeup_box() {
  local writeup_name="$(basename $(pwd))"
  local root_flag=$(cat writeup.md | rg -A 4 "## Flags" | rg "\`root\`" | rg "[[:alnum:]]{32}" -o)
  pandoc -V geometry:margin=1cm writeup.md --pdf-engine=xelatex -o /tmp/${writeup_name}.pdf && \
  qpdf --encrypt ${root_flag} ${root_flag} 128 --use-aes=y -- /tmp/${writeup_name}.pdf ${writeup_name}.pdf
}

gen_pdf_writeup_chl() {
  for w in *.md; do
    echo $w
    local root_flag=$(cat ${w} | rg -A 4 "## Flag" | rg "\`HTB" | cut -d \` -f2)
    print ${root_flag}
    pandoc -V geometry:margin=1cm ${w} --pdf-engine=xelatex -o /tmp/${w:r}.pdf && \
    qpdf --encrypt ${root_flag} ${root_flag} 128 --use-aes=y -- /tmp/${w:r}.pdf ${w:r}.pdf
    rm /tmp/*.pdf
  done
}
