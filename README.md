# Supplementary Artifacts

Supplementary material for a submission on LLM-assisted SUMO ontology engineering under
human-gated agency. This repository holds the four things the paper's Conclusion
promises: the system prompt, the external validation checklist, the constraint
architecture diagram, and the proof transcripts behind the paper's proof-complexity
table.

## Contents

- **`system-prompt.md`**: the seven-step protocol and hard constraints given to the
  LLM at the start of every term-authoring session (Layer 1 of the constraint
  architecture).
- **`validation-checklist.md`**: the five deterministic checks every drafted file
  passed before being loaded into SigmaKEE, independent of the LLM (Layer 2).
- **`protocol-diagram.tex`** / **`protocol-diagram.pdf`**: the four-layer constraint
  architecture: System Prompt, External Pipeline, Human Judgment, Theorem Prover, each
  layer catching what the previous layer misses.
- **`proofs/`**: the ten proofs and one timeout reported in the paper's
  proof-complexity table, one file per proof, run via SigmaKEE's Ask/Tell interface
  with Vampire 5.0.1 against the full SUMO knowledge base except where noted in the
  individual file. Each file's header states which table row it corresponds to and its
  wall-clock time; the complexity pattern is named right alongside. Vampire's internal
  file-provenance annotations (temp session-file paths from the machine the proofs were
  run on) have been removed; they're not needed to read the proof.

## What's not here

This repository does not include the ontology source files these proofs run against.
`Merge.kif` and the SUMO domain files referenced in these proofs are part of
[ontologyportal/sumo](https://github.com/ontologyportal/sumo), a large, multi-contributor
open community project, cited directly rather than duplicated here.
