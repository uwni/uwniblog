
#set heading(numbering: "1.1")
#show heading: it => {
  it.depth
}

= A
=== N
=== D

#context counter(heading).at(here())