#import "./notes.typ": *
#import "./theorems.typ": *
#import "./utils.typ": *
#import "./images.typ": *

#let scrartcl(
  doc,
  title: str,
  subtitle: "",
  date: datetime.today().display("[day]. [month repr:long] [year]"),
  authors: array,
  supervisors: array,
  preface: none,
  pageMargins: (left: 15%, top: 10%, right: 15%, bottom: 9%),
  cols: 1,
  showOutline: false,
  numberingPattern: "1",
  pageHeader: none,
  pageFooter: align(center, context { counter(page).get().at(0) }),
  paragraphSpacing: .8em,
  fontSize: 11pt,
) = [
  #if pageHeader == none {}

  // Uni logo in corner
  #set page(
    background: {
      place(dx: 11.4mm, dy: 11.4mm)[
        #image("./UHB_Logo_4c.svg", height: 18.5mm)
      ]
    },
    // dont number titlepage
    numbering: none,
    // center titlepage
    margin: (
      top: 1in,
      bottom: 1in,
      right: 1.5in,
      left: 1.5in,
    ),
  )
  // Create title
  #page()[
    #v(5%)
    #align(center)[
      #stack(dir: ttb, spacing: 3em)[
        #line(angle: 0deg, length: 100%)
      ][
        #set text(size: 2em)
        *#title*
      ][
        #set text(size: 1.5em)
        Bachelorarbeit zur Erlangung des akademischen
        Grades Bachelor of Science (B.Sc.) in Informatik ][
        #line(angle: 0deg, length: 100%)
      ]
    ]
    #v(5%)
    #align(center)[
      #stack(spacing: 1em)[
        *Eingereicht von*
      ][
        #authors.name
      ][
        #if (type(authors) == array) {
          authors
            .map(author => {
              link("mailto:" + str(author.email))
            })
            .join([, ])
        } else {
          link("mailto:" + str(authors.email))
        }
      ][][][
        *Prüfer*
      ][
        #supervisors.join("\n")
      ]
    ]
    #align(center + horizon)[
      #stack(spacing: 1em)[
        FB3
      ][
        Uni Bremen
      ][
        SoSe 2026
      ][
        #date
      ]
    ]
  ]
  #counter(page).update(n => n - 1)

  #set page(
    "a4",
    margin: pageMargins,
    columns: 1,
    numbering: numberingPattern,
    header: pageHeader,
    header-ascent: -25pt,
    footer: pageFooter,
    background: none,
  )
  #set par(leading: paragraphSpacing, first-line-indent: 0em, justify: true, hanging-indent: 0em, spacing: 1em)
  #set text(font: "New Computer Modern", size: fontSize, lang: "de")
  #show raw: set text(font: "New Computer Modern Mono")
  #show heading: set block(above: 1.4em, below: 1em)
  #show outline.entry.where(level: 1): entry => { strong(entry) }
  #show: thmrules.with(qed-symbol: $square$)
  #show ref: r => {
    if r.element != none and r.element.func() == math.equation {
      link(
        r.target,
        numbering(
          r.element.numbering,
          ..counter(math.equation).at(r.element.location()),
        ),
      )
    } else {
      r
    }
  }

  #show figure: set figure.caption(position: bottom)

  #if (showOutline) [
    #outline(indent: 2em)
    #pagebreak()
  ]

  #if (preface != none) {
    [= Vorwort]
    preface
    pagebreak()
  }

  #show heading: it => {
    if it.level == 1 {
      pagebreak(weak: true)
      it
    } else {
      it
    }
  }
  #set heading(numbering: "1.1")

  #doc
]
