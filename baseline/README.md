# No-Protocol Baseline

Materials behind the paper's no-protocol baseline (Table II): the scoring protocol, the
prompt every model received, the SUO-KIF each model produced, the scorer and its output,
and the criterion 3 proof runs.

## Design

Three terms the human-LLM workflow had already formalized, one per domain (`Fork`,
`SoftwareBug`, `Nocturnal`), were given to five general-purpose LLM chat interfaces
without the workflow's protocol, knowledge-base access, or human review. Each
(model, term) pair ran once, in a fresh session with web access off. Claude was not among
the five because it is the LLM the workflow itself uses.

The protocol was written and locked on 2026-08-08, before the first model run on
2026-08-29, and it records later changes with their dates: the model list (2026-08-11 and
2026-08-29), the term descriptions (2026-08-29, to take them from dictionaries), and the
grouping of runs by web access (2026-09-03, after the runs). The scoring criteria and the
acceptance criterion did not change. The protocol file also holds working notes and is
not reproduced here; the criteria and prompt below are taken from it, and this folder was
added on 2026-10-09. The scoring criteria, applied in order to every output:

1. Syntactic validity, pass or fail.
2. Type-check, pass or fail. Requires syntax to pass.
3. Proof outcome against the same Tell/Ask conjecture used for the workflow-authored
   version of the term.
4. Error taxonomy, scoreable only if criteria 1 and 2 pass: wrong causal direction,
   tool-versus-container confusion, and absolute-versus-tendency properties (the error
   categories in Section VI of the paper).

Its acceptance criterion: "The ablation is treated as supporting the paper's
central claim if pipeline-assisted terms show fewer [taxonomy] errors than
baseline-model terms in at least 2 of the 3 domains tested." The protocol commits to reporting the
outcome as it comes out. On the taxonomy categories alone, the criterion is met in one of
the three domains, `Nocturnal`. For `Fork` and `SoftwareBug`, most baseline outputs
failed criterion 1 or 2, which makes criterion 4 unscoreable under the protocol, and the
outputs that were scoreable showed none of the named categories. The paper therefore
reports the comparison for those two terms on criteria 1 and 2.

The protocol named the Java SigmaKEE toolchain for criteria 1 to 3. All three were run on
sigma-rs instead: criteria 1 and 2 with the scorer in this folder, criterion 3 on
sigmakee.dev with sigma-rs's native (and optimized for SUMO work) prover, SUPr.

## Prompt

Every run received this prompt, with only the term and its one-line description changed:

```text
You are writing a formal ontology term in SUO-KIF for SUMO, the Suggested Upper Merged Ontology. SUO-KIF terms use predicate logic. A typical term definition includes:
- a class or instance declaration, e.g. `(subclass TermName ParentClass)` or `(instance TermName SomeClass)`
- a documentation string: `(documentation TermName EnglishLanguage "...")`
- a display format: `(termFormat EnglishLanguage TermName "...")`
- zero or more axioms expressing what the term implies, using standard first-order logic connectives (`=>`, `and`, `or`, `not`, `exists`, `forall`)

Write a complete SUO-KIF definition for the term below. Use your own judgment for what parent class it belongs to, what its documentation should say, and what axioms follow from that documentation.

Term: [NAME]
One-line description: [DESCRIPTION]
```

The descriptions came from a dictionary or standard usage, never from SUMO's own
documentation strings, so the prompt could not leak SUMO's framing of the term:

- `Fork`: "An implement with two or more prongs used especially for taking up food,
  pitching, or digging." (Merriam-Webster)
- `SoftwareBug`: "An error, flaw, failure, or fault in a computer program or system that
  causes it to produce an incorrect or unexpected result, or to behave in unintended
  ways." (standard software-engineering usage)
- `Nocturnal`: "Of, relating to, or occurring in the night; active mainly during the
  night." (Merriam-Webster)

## Runs

| Model | Interface and version, as displayed | Run date |
|---|---|---|
| ChatGPT (`Fork`, `SoftwareBug`) | chat.openai.com, temporary chat; version not displayed | 2026-08-29 |
| ChatGPT (`Nocturnal`) | chat.openai.com, unpersonalized temporary chat; GPT-5.6 "Sol", thinking effort High | 2026-09-03 |
| DeepSeek | OpenRouter chat; DeepSeek V4 Flash (0731 build); web tools off | recorded 2026-09-03 |
| Gemini | Google AI Studio, temporary chat; gemini-3.8-flash, thinking Medium; grounding off | 2026-09-03 |
| Llama | OpenRouter chat; Llama Maverick; web off | 2026-09-03 |
| Mistral | Le Chat, incognito; model not displayed; Think mode on; tools off | 2026-09-03 |

The ChatGPT `Nocturnal` run shared a session with two earlier terms in which the model
fetched SUMO source files mid-generation; those two runs were excluded, and no search or
fetch occurred for `Nocturnal`. Other runs made in the same period had web search or
fetch enabled, some of them without that being planned, or were superseded, or used a
model outside the intended category. Under the protocol, none of them were scored, and
none are reported.

## Criteria 1 and 2

`score-ablation-candidate.mjs` loads SUMO's `Merge.kif` into sigma-rs (the `sigmakee`
npm package, version 2.1.3, WASM build), loads one candidate, and reports the candidate's
parse errors and validation issues. `candidates/` holds the SUO-KIF each model produced,
extracted unedited from the saved chat transcripts; the models' prose explanations are
not reproduced. `scores/` holds the scorer's output for each candidate. In this copy of
the scorer, the path to the SUMO checkout is read from the `SUMO_DIR` environment
variable; the script is otherwise unchanged.

| Model | Term | Syntax | Type | Proof | Notes |
|---|---|---|---|---|---|
| ChatGPT | `Fork` | Fail | Fail | | bare `=` for inequality |
| ChatGPT | `SoftwareBug` | Fail | Fail | | malformed `and`/`causes` nesting |
| ChatGPT | `Nocturnal` | Pass | Fail | | `(subclass Nocturnal Attribute)` |
| DeepSeek | `Fork` | Pass | Pass | Fail | |
| DeepSeek | `SoftwareBug` | Pass | Pass | Fail | |
| DeepSeek | `Nocturnal` | Pass | Fail | | `(subclass Nocturnal Attribute)` |
| Gemini | `Fork` | Pass | Fail | | `Solid` used as a class |
| Gemini | `SoftwareBug` | Pass | Pass | Pass* | |
| Gemini | `Nocturnal` | Pass | Pass | Pass* | `(instance Nocturnal BiologicalAttribute)` |
| Llama | `Fork` | Fail | Fail | | bare `=` and `>=` |
| Llama | `SoftwareBug` | Pass | Fail | | undeclared relations |
| Llama | `Nocturnal` | Pass | Fail | | `(subclass Nocturnal Attribute)`; variable typo |
| Mistral | `Fork` | Fail | Fail | | unparenthesized quantifier variables and unbalanced parentheses; undeclared `fn` |
| Mistral | `SoftwareBug` | Pass | Fail | | non-standard `axiom` wrapper; undeclared relations |
| Mistral | `Nocturnal` | Fail | Fail | | unparenthesized quantifier variable; `(subclass Nocturnal Attribute)` |

\* conjecture adapted to the candidate's own rule (see below). A blank proof cell means
the pair failed criterion 1 or 2 and was not eligible for criterion 3.

## Criterion 3

Only the four pairs that passed criteria 1 and 2 were eligible. Each ran on sigmakee.dev
with SUPr. So that SUMO's real definitions could not answer the conjecture for the
candidate, the one rule that is the withheld answer was removed from the loaded files:

- `Fork`: `Merge.kif`, `Mid-level-ontology.kif`, and `Objects.kif` without
  `(=> (instance ?F Fork) (exists (?T) (and (instance ?T Tine) (component ?T ?F))))`.
- `SoftwareBug`: `Merge.kif` and `Mid-level-ontology.kif`; the workflow's own
  `SoftwareBug` definitions in `Cyber.kif` were not loaded.
- `Nocturnal`: `Merge.kif`, `Mid-level-ontology.kif`, and `Animals.kif` without
  `(=> (and (instance ?H Human) (attribute ?H Nocturnal)) (not (attribute ?H Healthy)))`.

| Pair | Tell | Ask | Outcome |
|---|---|---|---|
| DeepSeek `Fork` | `(instance Fork1 Fork)` | `(exists (?X) (and (instance ?X Tine) (component ?X Fork1)))` | Not proved (step budget exhausted). DeepSeek's axioms use its own class `Prong` with no connection to SUMO's `Tine`, so the conjecture is not entailed. |
| DeepSeek `SoftwareBug` | `(instance Bug1 SoftwareBug)` `(instance Prog1 ComputerProgram)` `(part Bug1 Prog1)` `(instance Proc1 ComputerProcess)` `(realization Proc1 Prog1)` `(causes Bug1 Proc1)` | `(exists (?PURPOSE) (and (hasPurpose Prog1 ?PURPOSE) (not (realization Proc1 ?PURPOSE))))` | Not proved (step budget exhausted). Confounded: the candidate's parent class `InformationRepresentation` is not defined in SUMO, and `ComputerProcess` is defined only in a file that was not loaded. |
| Gemini `SoftwareBug`* | `(instance Bug1 SoftwareBug)` | `(exists (?SYS) (and (or (instance ?SYS ComputerProgram) (instance ?SYS ComputerSystem)) (property ?SYS Bug1)))` | Proved. |
| Gemini `Nocturnal`* | `(instance Org1 Organism)` `(attribute Org1 Nocturnal)` | `(exists (?TIME ?NIGHT) (and (instance ?NIGHT Nighttime) (during ?TIME ?NIGHT) (holdsDuring ?TIME (property Org1 Awake))))` | Proved, through SUMO's `(subrelation attribute property)`. `Nighttime` is Gemini's own spelling; SUMO's term is `NightTime`. |

The protocol calls for the conjecture already used for the workflow-authored term. Both
Gemini conjectures were adapted because the originals are not fair to a cold baseline:
`SoftwareBug`'s original uses `bugInProgram`, a relation the workflow itself created, and
`Nocturnal`'s rests on the human-health rule removed above, which its own source comment
marks as a simplification. The adapted conjecture Tells the antecedent of the candidate's
own top-level rule and Asks its consequent, which makes both a weaker test than `Fork`'s.
For both Gemini proofs the negated conjecture was also asked against the same Tell facts,
and it did not prove, so neither result comes from an inconsistent knowledge base.

### Workflow-authored reference rows

`SoftwareBug` was run the same way, against the workflow's own `Cyber.kif` rule; the full
transcript is `criterion3/sodat-softwarebug-supr.txt` (proved, 1 given-clause step,
3.3 s). `Fork` and `Nocturnal` use their original conjectures, proved with Vampire through
SigmaKEE on the full knowledge base: `../proofs/fork-has-a-tine.txt` and
`../proofs/nocturnal-human-not-healthy.txt`.

### Formulas inside `holdsDuring`

Two of these proofs involve a formula embedded under `holdsDuring`: Gemini's `Nocturnal`
conjecture, and the `Cyber.kif` rule behind the workflow's `SoftwareBug` proof. sigma-rs's
first-order translation, which feeds Vampire and E, drops any sentence that uses a
relation as an argument; SUPr keeps such sentences by treating the embedded formula as a
term. That is why, on sigmakee.dev, Vampire and E return Unknown for the `SoftwareBug`
query, wherein the rule never reaches them. Neither proof reasons inside the embedded formula, and
both hold when the formula is typed as a real formula in higher-order logic.
 `hol-check/` contains minimal versions of both problems with Vampire 5.0.1 and E 2.6 output:

| Problem | Vampire | E |
|---|---|---|
| `A_rule_dropped`: the rule omitted, as the first-order translation sends it | CounterSatisfiable | CounterSatisfiable |
| `B_rule_fo_part`: the rule without its `holdsDuring` conjunct | Theorem | Theorem |
| `C_rule_quoted`: the full rule, embedded formula as a term (SUPr's treatment) | Theorem | Theorem |
| `D_rule_thf`: the full rule in THF, `holdsDuring : $i > $o > $o` | Theorem | not run (first-order prover) |
| `B_negated`: the rule's first-order part with the Ask negated | CounterSatisfiable | |
| `N_C_quoted`: Gemini's `Nocturnal` rule and Ask, embedded formula as a term | Theorem | Theorem |
| `N_D_thf`: Gemini's `Nocturnal` rule and Ask in THF | Theorem | not run (first-order prover) |

## Criterion 4

One rater, an author, read each output against the error categories. The outputs that
were formally scoreable, because they passed criteria 1 and 2, were DeepSeek `Fork`,
DeepSeek `SoftwareBug`, and Gemini `SoftwareBug`, with none of the categories found, and
Gemini `Nocturnal`, which states nocturnality's consequences as absolute. Reading all
fifteen outputs directly, four of the five models typed `Nocturnal` as
`(subclass Nocturnal Attribute)` where SUMO uses an instance of `BiologicalAttribute`, as
it does for the comparable `(instance Carnivore DietaryAttribute)`, and none of the five
used a tendency-qualified construction for nocturnality's behavioral consequences.

## Limitations

Each pair ran once, under each interface's default sampling settings, so the results
carry no measure of run-to-run variation. Two interfaces did not display a model version.
Criterion 4 rests on a single rater, with no second rater or inter-rater statistic. The
baseline differs from the workflow in model, knowledge-base access, number of turns,
validation feedback, and human involvement, so it supports only the claim that
unvalidated one-shot output is not admissible.
