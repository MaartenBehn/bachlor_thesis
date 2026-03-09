#import "./layout/ba.typ": *

#set document(title: [Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen Welten-Generation])

#show: scrartcl.with(
  title: "Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen Welten-Generation",
  authors: (
    (
      name: "Maarten Behn",
      email: "maarten.behn@uni-bremen.de"
    )
  ),
  supervisors: ("Prof. Dr. Gabriel Zachmann", "Prof. Dr. Nico Hochgeschwender")
)

= Einleitung

#include "./1_introduktion/goal.typ"

#include "./1_introduktion/strukture.typ"

= Stand der Technik

== Prozedurale Generation <prozedurale_generation>

#include "./2_state_of_art/noise.typ"

#todo("L-Systems")

#include "./2_state_of_art/model_synthesis.typ"

#include "./2_state_of_art/graph_grammers.typ"

#include "./2_state_of_art/ai_based_procedual_generation.typ"

#include "./2_state_of_art/lazy_recompute.typ"

= Theoretische Grundlagen 

#include "./3_theory/lazy_loading.typ"

#include "./3_theory/graphs.typ"

#todo("CSG")
#todo("Geometry Nodes")

#include "./3_theory/dependencies.typ"

= Meine Arbeit

#include "./4_core/idea.typ"

#include "./4_core/dependency-graph.typ"

#include "./4_core/framework.typ"

#include "./4_core/implementation.typ"

#include "./4_core/result.typ"

= Bewertung

#include "./5_evaluation/compare_to_similar_systems.typ" 

#include "./5_evaluation/future_work.typ"

#bibliography("citations.bib")

#idea("Text")
#todo("Text")
#itodo("Text")
#question("Text")

#numberedBlock($
  A = pi
$)

