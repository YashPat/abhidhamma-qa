#!/usr/bin/env bash
# Fetch a source page as plain text, so quotes come from the real text
# rather than a WebFetch summary.
#
#   scripts/fetch-text.sh <url>                  print the whole text
#   scripts/fetch-text.sh <url> <pattern> [N]    print each match with N chars
#                                                of context (default 300)
#
# Handles HTML and PDF (needs pdftotext from poppler). Pages are cached in
# $TMPDIR/abhidhamma-cache for the session.
set -euo pipefail

url="${1:?usage: fetch-text.sh <url> [pattern] [context]}"
pattern="${2:-}"
ctx="${3:-300}"

cache="${TMPDIR:-/tmp}/abhidhamma-cache"
mkdir -p "$cache"
key=$(printf '%s' "$url" | shasum | cut -c1-16)
txt="$cache/$key.txt"

if [[ ! -s "$txt" ]]; then
  raw="$cache/$key.raw"
  ctype=$(curl -sSL --fail -A "Mozilla/5.0" -o "$raw" -w '%{content_type}' "$url")
  if head -c 5 "$raw" | grep -q '%PDF'; then
    pdftotext -layout "$raw" - 2>/dev/null | tr -s ' ' > "$txt" || true
    # A damaged PDF can yield no text; say so instead of reporting "no match".
    if ! grep -q '[^[:space:]]' "$txt"; then
      rm -f "$txt" "$raw"
      echo "fetch-text: pdftotext extracted no text from $url" >&2
      exit 1
    fi
  else
    python3 -I -c '
import sys, re, html, codecs
b = open(sys.argv[1], "rb").read()
# Charset from the HTTP header, else a <meta> tag, else UTF-8 if it decodes,
# else cp1252 (what browsers use for pages labelled ISO-8859-1).
m = (re.search(r"charset=[\"\x27]?([\w-]+)", sys.argv[2], re.I)
     or re.search(rb"<meta[^>]+charset=[\"\x27]?([\w-]+)", b[:4096], re.I))
enc = m and (m.group(1) if isinstance(m.group(1), str) else m.group(1).decode())
try:
    enc = codecs.lookup(enc).name if enc else None
except LookupError:
    enc = None
if enc in ("latin-1", "iso8859-1", "ascii"):
    enc = "cp1252"
if not enc:
    try:
        b.decode("utf-8")
        enc = "utf-8"
    except UnicodeDecodeError:
        enc = "cp1252"
t = b.decode(enc, errors="replace")
t = re.sub(r"(?is)<(script|style)[^>]*>.*?</\1>", " ", t)
t = re.sub(r"<[^>]+>", " ", t)
print(html.unescape(re.sub(r"\s+", " ", t)).strip())
' "$raw" "$ctype" > "$txt"
  fi
  rm -f "$raw"
fi

if [[ -z "$pattern" ]]; then
  cat "$txt"
else
  python3 -I -c '
import sys, re
t = open(sys.argv[1], encoding="utf-8").read()
pat, n = sys.argv[2], int(sys.argv[3])
hits = [m.start() for m in re.finditer(pat, t, re.I)]
if not hits:
    sys.exit("no match for: " + pat)
for i in hits[:10]:
    print("..." + t[max(0, i - n // 3):i + n] + "...\n")
if len(hits) > 10:
    print(f"[{len(hits) - 10} more matches]")
' "$txt" "$pattern" "$ctx"
fi
