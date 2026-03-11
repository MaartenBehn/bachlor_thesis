#let alignbase(body, superscript) = (context {
  let totalwidth = measure($limits(body)^superscript$).width
  let bodywidth = measure(body).width
  let overlapwidth = (totalwidth - bodywidth) / 2 + 2pt
  let superscriptwidth = measure(superscript).width
  $#h(overlapwidth, weak: true)
  // The nested box ensures that the superscript is not broken into multiple lines
  &limits(body)^(#box(width:0pt, align(center, box(width: superscriptwidth, superscript))))
  #h(overlapwidth, weak: true)$
})


#let numberedBlock(content) = {
  set math.equation(numbering: "(1)")
  content
}


