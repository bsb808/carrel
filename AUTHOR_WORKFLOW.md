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
and (optionally) deposit to Zenodo.

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
