# Article Development Workflow

A staged process for developing articles on this site collaboratively
with Claude Code. Each stage produces a committed artifact; each
transition uses the **Process My Review (PMR) workflow** described in
`~/WorkingCopies/claude-global/review_workflow.md` (imported into
Claude's global config).

This file describes only the article-development *sequence* layered on
top of PMR. Per-stage review mechanics — commit baseline, scan for
`% CLAUDE:` comments, batch edits, open one diff editor — live in
`review_workflow.md` and are not duplicated here.

The workflow assumes the article's location, thread, and length target
are already agreed before stage 1 begins (see `CLAUDE.md`, `PLAN.md`,
`CONVENTIONS.md`).

## The four stages

### Stage 1 — Outline

Claude drafts a top-level outline of the article from the author's
concept, source material, and any constraints (thread, audience, length
target, intended payoff). The outline is a list of section headings
with one or two sentences under each describing the work that section
will do. No prose yet.

Output: `index.qmd` with front matter and the outline.

Commit message: `outline: <article-slug>`. Author runs PMR — direct
edits and `% CLAUDE:` comments — to restructure, drop, or add sections.

### Stage 2 — Annotated outline

Claude expands each section of the accepted outline with:

- a few notes on the argument or content the section will carry;
- key factors, distinctions, or claims to make;
- candidate quotes with sources;
- candidate images with Wikimedia / archival links and license notes;
- open questions for the author to resolve before prose is committed.

Still no full prose. The annotated outline is a working scaffold the
author can edit before paragraphs solidify.

Commit message: `annotated outline: <article-slug>`. Author PMRs.

### Stage 3 — Complete draft

Claude writes the article in full from the annotated outline. The
agreed length target governs — material overrun gets flagged in the
response, not silently expanded.

Output: complete `index.qmd` with prose, front matter, the AI
disclosure callout, references where applicable, and image references
selected in stage 2.

Commit message: `draft: <article-slug>`. Author PMRs.

### Stage 4 — Final review

Author reads the article end-to-end as published prose. Edits at this
stage are typically line-level: word choice, rhythm, citation polish,
image captions, disclaimer wording. Claude does not propose structural
changes at stage 4 unless asked.

Commit message: `final: <article-slug>`. The article is ready to render
and (optionally) move to Stage 5 for a Zenodo deposit.

### Stage 5 — Zenodo deposit (per-article DOI)

Optional. Substantive long-form pieces (typically 1500+ words, with
sources) get a per-article Zenodo deposit and a citable DOI. One-off
notes, status updates, and operational posts skip it.

The deposit is *manual* (path A in `PLAN.md` / `HANDOFF.md`): each
article gets its own concept DOI rather than one repo-level DOI for
the whole carrel. This is the model Google Scholar expects for
discrete works.

Procedure:

1. **Format-conditional AI disclosure.** Confirm the article wraps
   the web callout in `{.content-visible when-format="html"}` and
   provides an expanded `{.content-visible when-format="pdf"}`
   variant per `DISCLAIMER.md`.

2. **Render the PDF locally:**

   ```bash
   quarto render posts/<thread>/<slug>/index.qmd \
     --to pdf --pdf-engine pdflatex
   ```

   The PDF lands at `_site/posts/<thread>/<slug>/index.pdf`. Read it
   end-to-end — figures, footnotes, AI disclosure swap, page count.

3. **Upload to Zenodo (web UI).** At zenodo.org → *New upload*. Drag
   the PDF in. Fill metadata:

   - Resource type: *Publication → Preprint*
   - Creators with ORCID
   - License: *CC-BY-4.0*
   - Description: one-paragraph abstract
   - Keywords: thread + key concepts
   - Related identifier: URL of the live page; scheme *URL*;
     relation *is identical to*
   - Click **Reserve DOI** before publishing — gives the DOI string
     to wire into the article *before* the deposit becomes immutable.

4. **Wire the DOI in (commit on `main`):**

   - Front-matter additions:

     ```yaml
     doi: 10.5281/zenodo.<NNNNNNNN>
     citation: true
     resources:
       - <slug>.pdf
     ```

   - Add a format-conditional download/cite block above the hero
     image: HTML shows `[Download PDF](<slug>.pdf) · DOI: …`; PDF
     shows `DOI: …` only.
   - Re-render the PDF (now has the DOI on its title page).
   - Stage the rebuilt PDF in the post folder as `<slug>.pdf` (not
     `index.pdf` — avoids confusion with Quarto build output).
   - Commit + push. Auto-deploy puts the DOI live.

5. **Replace and publish on Zenodo.** Back on the draft, swap the
   originally-uploaded PDF for the freshly-rendered one (which now
   shows the DOI on page 1). Click **Publish**. The deposit becomes
   immutable; the DOI activates.

6. **Verify:**

   - `https://doi.org/10.5281/zenodo.<NNNNNNNN>` resolves
   - Live page renders with DOI + Download PDF link
   - PDF served from the live URL returns HTTP 200

Commit message: `<slug>: wire in Zenodo DOI <DOI>`.

**Versioning.** Substantive revisions after deposit warrant a new
Zenodo *version* (same concept DOI, new version DOI). Minor
copy-edits to the live HTML don't — the deposit stays the citable
version-of-record at the date of deposit. Note this in the Zenodo
description.

**Reference run:** First exercised on `where-are-the-humans`,
2026-05-03 → DOI [10.5281/zenodo.20018252](https://doi.org/10.5281/zenodo.20018252).

### Stage 5b — Zenodo deposit for externally-rendered technical notes

For pre-existing LaTeX technical notes (originally in `OceanNotes`),
the deposit procedure differs from Stage 5: the PDF is rendered from
`<slug>.tex` via `pdflatex`/`latexmk`, not from `index.qmd` via
Quarto. The companion essay (`index.qmd`) is HTML-only and links to
the deposited PDF. See `CONVENTIONS.md` § Technical-note +
companion-essay for the surrounding pattern.

Procedure:

1. **Render the PDF locally:**

   ```bash
   cd posts/<thread>/<slug>/
   latexmk -pdf <slug>.tex
   ```

   Proofread end-to-end — figures, footnotes, page count.

2. **Upload to Zenodo (web UI).** At zenodo.org → *New upload*. Drag
   the PDF in. Fill metadata:

   - Resource type: *Publication → Technical note* (not *Preprint*)
   - Creators with ORCID
   - License: *CC-BY-4.0*
   - Description: one-paragraph abstract (often the note's own
     abstract)
   - Keywords: thread + key concepts
   - Related identifier: URL of the live companion-essay page;
     scheme *URL*; relation *is identical to*
   - Click **Reserve DOI** before publishing.

3. **Inject the DOI into `<slug>.tex`** as a one-line title-page
   footer, then re-render with `latexmk -pdf`. Exact macro will
   settle during the first migration.

4. **Wire the DOI into the companion essay** (commit on `main`):

   - Front-matter additions:

     ```yaml
     doi: 10.5281/zenodo.<NNNNNNNN>
     citation: true
     resources:
       - <slug>.pdf
     ```

   - Add the download/cite block in the body:
     `[Download PDF](<slug>.pdf) · DOI: …`
   - Commit + push (PDF, `.tex`, `index.qmd` together). Auto-deploy
     puts the DOI live.

5. **Replace and publish on Zenodo.** Swap the originally-uploaded
   PDF for the DOI-stamped one, then click **Publish**. The deposit
   becomes immutable; the DOI activates.

6. **Verify:**

   - `https://doi.org/10.5281/zenodo.<NNNNNNNN>` resolves
   - Live page renders with DOI + Download PDF link
   - PDF served from the live URL returns HTTP 200

Commit message: `<slug>: wire in Zenodo DOI <DOI>`.

**AI disclosure asymmetry.** The `.tex` source predates AI assistance;
only the companion essay is AI-drafted. The disclosure callout in
`index.qmd` notes this with one added sentence appended to the standard
`DISCLAIMER.md` web callout: *"The technical note itself predates AI
assistance; only this companion essay was drafted with Claude."* Full
wording is in `CONVENTIONS.md` § Technical-note + companion-essay
→ AI disclosure.

**Reference run.** First exercised on `spectra-from-psd`, 2026-05-03
(Zenodo deposit pending). Document-class deviation: switched from
the original NPS class to `IEEEtran[journal]` to drop per-folder
class/sty/bst dependencies — see CONVENTIONS.md § "Document class:
prefer CTAN over custom".

**OceanNotes deprecation.** Each migrated note is removed from (or
marked-as-moved in) `~/WorkingCopies/OceanNotes/`. Once all migrations
are complete, archive that repo with a final tag and a README pointer
to carrel.

## When to deviate

Skip stages for short pieces. A one-paragraph technical note doesn't
need a stage 1 outline. A 500–750-word LinkedIn-targeted brief can
combine stages 1 and 2 into a single annotated outline.

For substantive long-form work — anything heading toward Zenodo with a
DOI — run all four stages.

## Triggers and the article slot

The author kicks off each stage by signalling readiness. Examples:

- *"start the outline"* → Claude does stage 1.
- *"PMR"* / *"process my review"* → Claude runs the standard PMR pass
  on the current stage's file.
- *"resolved"* → Claude commits the accepted state, then waits for
  *"next stage"* or *"start stage N"* to advance.
- *"start stage N"* / *"next stage"* → Claude does the next stage.

There is exactly one article in active development per session. If a
second article is started, the author names which slug Claude is
working on each turn, or the workflow runs sequentially.

## Disclaimer text

The AI co-authorship callout placed at the top of every article is
governed elsewhere — see the site-wide guideline (TBD). It is added in
stage 3, not stage 1 or 2.
