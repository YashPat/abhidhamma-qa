---
name: check-sheets
description: Verify the reference sheets in references/sheets/ against Nārada's Manual, fix or trim what fails, then commit and push. Use when the user asks to check, verify, double-check, audit, clean up, or trim the reference sheets, or runs /check-sheets. Optional argument: one sheet name (citta, cetasika, sampayoga, vithi); default is all four.
---

# Check the reference sheets

Goal: sheets that are **roughly correct and short**. They are a quick map, not a textbook. When a passage is wrong or can't be confirmed, prefer cutting it to adding detail. A sheet should come out the same length or shorter.

## Source of truth

One source: **Nārada, *A Manual of Abhidhamma*** (the Abhidhammattha Saṅgaha), `https://budsas.org/ebud/abhisgho/abhis0N.htm`, N = chapter 1–9. It is free, complete, and covers every sheet:

| Sheet | Nārada chapter |
| --- | --- |
| `citta.md` | I (and III for roots, feelings, functions) |
| `cetasika.md` | II |
| `sampayoga.md` | II (combinations, §§10–17) |
| `vithi.md` | IV (and III §6 for functions, V for death and rebirth) |

Read it only with `scripts/fetch-text.sh <url> <pattern>`, never WebFetch, which summarises. Go beyond Nārada only when he is silent on a claim: then the Dhammasaṅgaṇī through the `tripitaka` MCP, or *Visuddhimagga* HTML (`references/sources.md`). If no source confirms a claim, it is **unsourced**.

## Budget

At most **10 subagents** in a whole run. Plan for: 4 checkers + up to 4 re-checkers + 1 final reviewer = 9. With one sheet, use 1 + 1 + 1. Never spawn a subagent to do what one fetch can do.

## Workflow

### 1. Check (one subagent per sheet, in parallel)

Spawn a `general-purpose` agent per sheet with this brief, filled in:

> Check `references/sheets/<sheet>` against Nārada's Manual ch. <N>, `https://budsas.org/ebud/abhisgho/abhis0<N>.htm`. Read the source only with `scripts/fetch-text.sh <url> '<pattern>' [chars]` (prints verbatim passages). Go claim by claim through every count, definition, list, rule ("only in", "never with"), and sequence. Skip pure teaching prose that makes no factual claim. For each claim that is **not** plainly confirmed, return one row: `line | claim (short) | verdict: WRONG or UNSOURCED | what Nārada actually says, verbatim, ≤40 words | URL + §`. Then give one line: how many claims were confirmed. Don't edit any file. Don't report style issues.

Also give each checker the rows for its sheet from the "Prioritized fix list" in `references/sheet-accuracy-check.md` as leads to test, not as findings to trust.

### 2. Re-check (blind, second pair of eyes)

For each sheet with any WRONG or UNSOURCED rows, spawn one fresh agent. Give it only the **claims and line numbers**, not the first checker's verdicts or quotes. Ask it to check each claim against the same source in the same way and return CONFIRMED, WRONG, or UNSOURCED with a verbatim quote.

Act only where **both passes agree** a claim is WRONG or UNSOURCED. If they disagree, read the passage yourself with the script. If it's still unclear, leave the text alone and list it as open.

### 3. Fix (you, not a subagent)

For each agreed finding, choose the smallest edit:
- **WRONG** → correct it in plain words, using only what the quote supports. If the fix would need a paragraph, cut the claim instead.
- **UNSOURCED** → delete it, or soften it to what the source does say. Similes and practice tips with no source go too, unless they're clearly marked as a reading aid.
- Also cut detail a beginner's map doesn't need (edge cases, alternate schemes, long lists) when it adds maintenance and no clarity.

Never add a new claim you didn't verify in this run. Keep the sheet's style.

### 4. Final review (one subagent)

Give one fresh agent `git diff references/sheets/` and ask it to confirm, using the script, that every changed or remaining sentence in the diff is supported by Nārada, and that no edit introduced an error. Fix anything it flags in the same way, or revert that hunk.

### 5. Record, commit, push

- Replace `references/sheet-accuracy-check.md` with a short status note (keep it under ~40 lines): date, source used, what was fixed or cut per sheet, and a `## Prioritized fix list` section holding only what's still open. `AGENTS.md` points to that heading by name, so keep the heading exactly and don't edit `AGENTS.md`: it says nothing about the findings themselves.
- Show the user a summary: per sheet, how many claims were confirmed, fixed, cut, or left open, and the net line change.
- Commit with a message naming the sheets and the source, then `git push`. If the push fails, say so and stop.
