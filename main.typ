#import "./layout/ba.typ": *

#set document(title: [Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen Welten-Generation])

#show: scrartcl.with(
  title: "Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen Welten-Generation",
  authors: (
    (
      name: "Maarten Behn",
      email: "behn@uni-bremen.de"
    )
  ),
  supervisors: ("Prof. Dr. Gabriel Zachmann", "Prof. Dr. Nico Hochgeschwender")
)

#let show_images = false;

= Einleitung

#include "./1_introduktion/goal.typ"

#outline(depth: 2)

= Stand der Technik

#include "./2_state_of_art/intro.typ"

#include "./2_state_of_art/noise.typ"

#include "./2_state_of_art/model_synthesis.typ"

#include "./2_state_of_art/graph_grammers.typ"

#include "./2_state_of_art/ai_based_procedual_generation.typ"

#include "./2_state_of_art/houdini_and_blender.typ"

= Theoretische Grundlagen 

#include "./3_theory/intro.typ"

#include "./3_theory/lazy_loading.typ"

#include "./3_theory/graphs.typ"

#include "./3_theory/csg.typ"

#include "./3_theory/graphical_programing.typ"

= Mein Lösungsansatz

#include "./4_core/intro.typ"

#include "./4_core/dependency-graph.typ"

#include "./4_core/framework.typ"

#include "./4_core/implementation.typ"

#include "./4_core/result.typ"

= Bewertung

#include "./5_evaluation/how_to_compare.typ"

#include "./5_evaluation/reduction_of_regeneration.typ"

#include "./5_evaluation/overhead.typ"

#include "./5_evaluation/usability.typ"

#include "./5_evaluation/extensibility.typ"

#include "./5_evaluation/future_work.typ"

#show bibliography: set heading(numbering: "1")
#bibliography("citations.bib")

#include "./layout/eigenständigkeit.typ"

#include "./layout/ai_disclaimer.typ"


