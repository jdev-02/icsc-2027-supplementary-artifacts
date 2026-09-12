# External Validation Checklist

Before any file drafted under the system prompt was loaded into SigmaKEE, it passed
through an external validation pipeline: deterministic checks operationalizing the
prompt's constraints, independent of the LLM. This is Layer 2 of the constraint
architecture (`protocol-diagram.pdf`): it catches structural errors the LLM's own
self-report can miss, without depending on the LLM to run or self-report them
correctly.

1. **Parenthesis balance check** (automated script). SUO-KIF is fully parenthesized;
   an unbalanced file fails to parse at all. Flags truncated output and malformed
   nesting before anything downstream sees the file.

2. **Style convention scan.** Checks for notation artifacts that violate the target
   corpus's established conventions, for example characters the existing knowledge base
   never uses. Catches formatting habits an LLM imports from its training data instead
   of matching the target file's own house style.

3. **Variable scoping audit on all `=>` rules.** Verifies that every variable appearing
   in a consequent is either bound in the antecedent or introduced within an `exists`
   scope in the consequent. An unscoped consequent variable is a free variable: the rule
   asserts existence without grounding, which creates unprovable conclusions.

4. **Cross-reference of all referenced terms against the known SUMO term inventory.**
   Every term a drafted rule mentions must already exist in the loaded knowledge base
   or be defined in the same submission. Stops references to terms that don't exist
   and near-miss name or capitalization guesses.

5. **Bare existential audit.** Flags any top-level unconditional existence assertion.
   `(exists (?X) (instance ?X Dog))` at the top level asserts dogs exist even in empty
   worlds, a commitment the knowledge base almost never intends. SUMO's own corpus
   (`Merge.kif`, 18,800 lines) contains exactly one such axiom.

Each check is mechanical and deterministic: given the same file, it produces the same
pass/fail result every time, independent of which LLM or which session produced the
file. None of the five requires understanding what the term means; that judgment stays
with the human author (Layer 3) and the theorem prover (Layer 4).
