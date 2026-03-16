
#let count = 3
#let start = 1
#let fill_text(dx: relative, dy: relative, body) = place(alignment.top, dy: dy, dx: dx, body)
#let filled_out = ({
  fill_text(dy: 4.8cm, dx: 5.5cm, [Nummer])
  fill_text(dy: 5.55cm, dx: 5.5cm, [Behn])
  fill_text(dy: 6.2cm, dx: 5.5cm, [Maarten])
  fill_text(dy: 8.1cm, dx: -0.5cm, [
    Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen 

    Welten-Generation.])
  fill_text(dy: 18.56cm, dx: -0.28cm, [X])
}, {
  fill_text(dy: 9.67cm, dx: -0.56cm, [X])
  fill_text(dy: 12.85cm, dx: -0.52cm, [X])
}, {
  fill_text(dy: 6.56cm, dx: -0.45cm, [X])
})
#[
  // this depends on you needs, you may omit parts of this
  // we reset the styles for the pages here to ensure we don't draw
  // over the included pages
  #set page(numbering: none, footer: none, header: none, )
  #for p in range(start, count + 1) {
    // using `page` to ensure each included page is it's own page
    // in the final document
    // using `page.background` to ensure we use the margins too
    page(background: image("../assets/eigenständigkeit_" + str(p) + ".svg"), filled_out.at(p - start))
  }
]
// reset our page counter to ensure they don't interfere with it
// this depends on your document, you may omit this
#counter(page).update(n => n - count)
