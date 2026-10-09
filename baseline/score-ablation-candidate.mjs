#!/usr/bin/env node
// score-ablation-candidate.mjs: sigma-rs (WASM) syntax and type-check scorer for a single
// candidate SUO-KIF file against SUMO's Merge.kif, used to score criteria 1 and 2 of the
// no-protocol baseline (see README.md in this folder). Cyber.kif is intentionally not
// loaded; the baseline terms (Fork, SoftwareBug, Nocturnal) are not cyber-domain terms.
//
// Usage:
//   SUMO_DIR=/path/to/sumo node score-ablation-candidate.mjs <candidate.kif>
//
// Output: JSON { file, ingest_errors: [...], candidate_validation_issues: [...] }
// candidate_validation_issues is validate()'s full-KB output filtered to only issues whose
// file field matches the candidate's ingest name, so pre-existing Merge.kif noise isn't
// misattributed to the candidate.

import { readFile } from "node:fs/promises";
import { createRequire } from "node:module";
import path from "node:path";

const req = createRequire(import.meta.url);
const SUMO_DIR = process.env.SUMO_DIR ?? "./sumo"; // path to an ontologyportal/sumo checkout
const MERGE_PATH = `${SUMO_DIR}/Merge.kif`;

async function main() {
  const candidatePath = process.argv[2];
  if (!candidatePath) {
    console.error("usage: score-ablation-candidate.mjs <candidate.kif>");
    process.exitCode = 64;
    return;
  }

  const sdk = await import("sigmakee/sdk");
  await sdk.init({ module_or_path: await readFile(req.resolve("sigmakee/sumo_parser_wasm_bg.wasm")) });
  const cfg = new sdk.Config();
  cfg.timeLimitSecs = 30;
  const session = new sdk.Session({ backend: sdk.Backend.Native, config: cfg });

  await session.ingest(sdk.Source.kif(await readFile(MERGE_PATH, "utf8"), "Merge.kif"));

  const candidateName = path.basename(candidatePath);
  const candidateText = await readFile(candidatePath, "utf8");
  const candidateReport = await session.ingest(sdk.Source.kif(candidateText, candidateName));

  const validation = session.validate();
  const candidateIssues = validation.filter(v => v.file === candidateName);

  console.log(JSON.stringify({
    file: candidateName,
    ingest_errors: candidateReport.errors ?? [],
    candidate_validation_issues: candidateIssues,
  }, null, 2));
}

main();
