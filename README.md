# Abhidhamma Q&A

A workspace for asking questions about the Theravāda Abhidhamma and getting plain-English answers that are checked against sources.

It is set up for Claude Code. `AGENTS.md` (also linked as `CLAUDE.md`) holds the rules: answer first in plain English, check every claim about what the Abhidhamma says against a source in the same session, and end with a short list of sources.

## What's here

- `AGENTS.md` / `CLAUDE.md`: how answers are written and checked.
- `.mcp.json`: the canon and dictionary servers (`tripitaka`, `fojin`).
- `scripts/fetch-text.sh`: fetches a web page or PDF as plain text and prints only the passages that match a pattern, so quotes come from the real text and not a summary. Needs `curl`, `python3`, and `pdftotext` (poppler) for PDFs.
- `references/sources.md`: where to read each commentary, manual, and dictionary, with working URL patterns.
- `references/sheets/`: quick-reference sheets on citta, cetasika, sampayoga, and vithi. **These are AI-written and only a rough map.** `references/sheet-accuracy-check.md` records the latest check and what's still open; `/check-sheets` re-runs it. Don't cite them as a source.

## Using it

Open the folder in Claude Code and ask a question. For example: "What are the 25 beautiful mental factors?"

Example lookup with the script:

```
scripts/fetch-text.sh https://edhamma.github.io/vism/latex/html/ch-15.html '§98\.' 250
```

## Sources

Answers rest on the Pāli canon (through the `tripitaka` server), Nārada's *Manual of Abhidhamma*, Ñāṇamoli's *Visuddhimagga* translation, and modern teachers. This repo holds no copies of those works, only links and notes.
