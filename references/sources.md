# Sources beyond the canon

Where to read the commentaries, manuals, and scholarship that the MCP servers do not carry. URLs checked 2026-10-31. Read on demand with `scripts/fetch-text.sh <url> <pattern>`, which prints the matching passage verbatim; do not download these into the repo.

## Theravāda commentaries and manuals

| Work | What it answers | Where |
| --- | --- | --- |
| Nārada, *A Manual of Abhidhamma* (Abhidhammattha Saṅgaha in English) | Counts and classifications: citta, cetasika, process, matter, relations; his notes carry many Aṭṭhasālinī glosses | `https://budsas.org/ebud/abhisgho/abhis0N.htm`, N = chapter 1–9 (00 is the contents). Ch. I citta, II cetasika, III miscellaneous, IV thought-processes, V process-freed, VI matter, VII categories, VIII relations, IX meditation. Section marks appear as `§ 6.` |
| *Visuddhimagga* (Buddhaghosa), tr. Ñāṇamoli, *The Path of Purification* | The commentarial system as a whole: meditation, the divine abidings (IX), the aggregates (XIV), dependent arising (XVII), insight knowledges | HTML with § numbers: `https://edhamma.github.io/vism/latex/html/ch-NN.html`, where NN = chapter + 6 (ch. I = `ch-07`, IX = `ch-15`, XIV = `ch-20`, XVII = `ch-23`). Grep for `§98\.`. The [BPS PDF](https://www.accesstoinsight.org/lib/authors/nanamoli/PathofPurification2011.pdf) also works through the script (poppler) but is slower |
| *Aṭṭhasālinī* (Buddhaghosa), tr. Pe Maung Tin, *The Expositor* (PTS 1920–21) | Commentary on the Dhammasaṅgaṇī: the characteristic, function, manifestation, and proximate cause of each factor; why prompting matters | [HathiTrust](https://catalog.hathitrust.org/Record/009013683) (vol. 2 full view). Nārada's notes quote it often, so cite it as "via Nārada" when that is the route |
| *Abhidhammattha-saṅgaha*, Bodhi ed., *A Comprehensive Manual of Abhidhamma* | The standard modern guide; its explanatory guide carries the commentarial reasoning behind each count | Not free. [BPS](https://bps.lk/cover.php?id=bp304s); library ebook via OverDrive. Do not use the unofficial PDFs. |
| Pāli commentaries and sub-commentaries (aṭṭhakathā, ṭīkā), Chaṭṭha Saṅgāyana edition | The Pāli original when no English exists (most Abhidhamma commentaries are untranslated) | [tipitaka.org](https://tipitaka.org) (VRI) |
| Nina van Gorkom, *Abhidhamma in Daily Life* | A teacher's explanation of citta and cetasika in lived terms | `https://vipassana.info/nina-abhi-NN.htm`, NN = chapter, two digits (ch. 19 "The Sobhana Cittas in Our Life" = `nina-abhi-19.htm`). The buddho.org page has no text |
| Ñāṇamoli, *The Practice of Loving-Kindness* (Wheel 7); Nyanaponika, *The Four Sublime States* (Wheel 6) | Short practical treatments of the divine abidings, drawing on Vism IX | [Wheel 7](https://accesstoinsight.org/lib/authors/nanamoli/wheel007), [Wheel 6](https://www.accesstoinsight.org/lib/authors/nyanaponika/wheel006.html). Prefer Vism IX itself for claims about the method |
| Nyanatiloka, *Buddhist Dictionary* (4th ed.) | Short doctrinal definitions with canonical and commentarial references | `https://www.buddhismtoday.com/english/beg/dic3_<letter>.htm` (e.g. `dic3_s.htm` for *saddhā*; W–Z is `dic3_w-z.htm`). Copy status unconfirmed; [BPS](https://bps.lk/book/buddhist-dictionary) is the publisher |

## Dictionaries

- DPD JSON: `https://dpdict.net/search_json?q=<word>`; works best on the stem (`okappana`, not `okappanā`).
- `fojin` MCP `lookup_dictionary` returns DPD, PTS, and NCPED together.

## Scholarship

| Work | Use it for |
| --- | --- |
| Noa Ronkin, "Abhidharma," *Stanford Encyclopedia of Philosophy* — [plato.stanford.edu/entries/abhidharma](https://plato.stanford.edu/entries/abhidharma/) | Theravāda and Sarvāstivāda dhamma theory side by side, with a bibliography |
| `paper-search` MCP (OpenAlex, Semantic Scholar, CORE) | Journal articles. Prefer peer-reviewed work by established scholars (Ronkin, Heim, Bodhi, Karunadasa, Cousins, Gethin); flag self-published or AI-coauthored papers as such |
| *Journal of Buddhist Ethics*, *Contemporary Buddhism*, *Buddhist Studies Review* | Open or partly open journals that the search tools reach |

## Other traditions

For the Sarvāstivāda *Abhidharmakośa* and Yogācāra treatises, use `fojin` (CBETA T1558, T1585). For Tibetan Mahāyāna in English, 84000 ([read.84000.co](https://read.84000.co)) is readable with WebFetch.
