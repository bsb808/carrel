# Vocabulary for Site Structure

> Status: proposal for review. The terms below are intended to be the
> controlled vocabulary used in CLAUDE.md, PLAN.md, and Claude Code
> sessions. Once accepted, those documents will be updated to match.

## Why this file exists

The words "thread," "topic," and "project" were used loosely in early
drafting. This document fixes meanings so that author and Claude Code use
the same terms for the same things.

## The five concepts

### 1. Article

The atomic unit of writing. One folder, one `index.qmd`, optional figures
and `references.bib`.

Synonyms in casual use: *post*, *piece*. Use freely.

### 2. Project

A **bounded** body of work — defined scope, identifiable goal or
end-state. Often technical. Produces a related cluster of articles that
share a deliverable.

Examples:

- `usv-control` — unmanned surface vessel modeling and autopilot work
- `predictions-scorecard` — annual review of standing predictions

Characteristics: has a goal; finite (even if long-running); articles
relate by shared deliverable.

### 3. Thread

An **open-ended** line of inquiry — a subject returned to repeatedly
without a fixed endpoint.

Examples:

- `computing-history` — history of computing and the role of humans in
  rising abstraction and automation
- `engineering-pedagogy` — teaching engineering during the AI transition

Characteristics: no fixed scope; can run indefinitely; articles relate by
shared subject, not deliverable.

### 4. Theme

A **cross-cutting** concept that emerges from the body of work and is
recognized retrospectively. Themes span projects and threads.

Examples (illustrative — none declared yet):

- `abstraction` — could surface in `computing-history` and in `usv-control`
- `human-roles` — could surface wherever humans-in-the-loop is at issue

Characteristics: not declared in advance; identified once several
articles exist; often applied retroactively.

### 5. Series

A genuinely **sequenced** set of articles meant to be read in order
(Part 1, Part 2, …). Distinct from threads, which are unordered.

Mechanism: Quarto's `series:` front-matter field, not `categories`.

Examples: a multi-part deep dive; a course-like progression.

## How these map to Quarto mechanics

| Concept   | Quarto mechanism                                                     |
|-----------|----------------------------------------------------------------------|
| Article   | Folder under `posts/` (or under `posts/<project-or-thread>/`)        |
| Project   | Folder + `categories` tag + (eventually) landing page                |
| Thread    | Folder + `categories` tag + (eventually) landing page                |
| Theme     | `categories` tag only — no folder, no landing page                   |
| Series    | `series:` field in front matter                                      |
| One-off   | `posts/<slug>/` — no project/thread tag, possibly theme tags later   |

Mechanically, project and thread are identical (tag + folder + maybe
page). The distinction matters for *authorial planning*, not site
machinery.

## Tag namespace

All tags live in the same `categories:` array. No syntactic prefix
distinguishes project / thread / theme — context tells you which is which.

```yaml
categories:
  - computing-history    # thread
  - abstraction          # theme (retroactive)
  - human-roles          # theme (retroactive)
```

If the flat namespace later gets confusing, prefixing is an escape hatch
(`thread/computing-history`, `theme/abstraction`). Defer until needed.

## Naming conventions

- **All tags:** kebab-case, lowercase, ASCII.
- **Project tags:** noun phrase, specific to the project's domain.
  Examples: `usv-control`, `predictions-scorecard`.
- **Thread tags:** noun phrase naming the line of inquiry.
  Examples: `computing-history`, `engineering-pedagogy`.
- **Theme tags:** short concept, often a single word.
  Examples: `abstraction`, `human-roles`, `pedagogy`.
- **Avoid:** plurals (`notes` → `note`?), gerunds when a noun reads
  better (`teaching` → `pedagogy`), and unestablished abbreviations.

## Lifecycle

**A theme cannot exist before the writing exists.** Themes are recognized,
not declared. The workflow:

1. Draft an article. Tag with its project or thread (if any). Skip themes
   — too early.
2. Once roughly 3+ articles exist, scan for cross-cutting concepts.
3. Propose theme tags. Apply retroactively where they fit; use forward.
4. Retire or merge themes that don't accrue.

**Projects and threads, by contrast, can be declared up front.** If you
know the next article is the start of an open-ended inquiry, name the
thread and create its folder before writing article 1.

## Folder placement (resolves the threshold ambiguity)

Decision rule at draft time:

- **Genuinely one-off?** → `posts/<slug>/`. No project/thread tag.
- **Likely to have a second article?** → Name the thread or project
  *now* and put the article in `posts/<thread-or-project-slug>/<post-slug>/`
  from day 1.
- **Started as one-off, but a thread emerged later?** → Move the article
  into the newly named folder. URL changes; add a Quarto redirect so old
  links don't 404.

So the "move at 3+ articles" rule in PLAN.md applies *only* to
retroactive thread recognition. Day-1 thread recognition avoids
migration entirely.

The 5+ articles → dedicated landing page + navbar entry rule still
stands, regardless of whether the thread was declared on day 1 or
recognized retroactively.

## Worked example: the first article

The first article will be in this thread:

- **Thread tag:** `computing-history`
- **Folder:** `posts/computing-history/<article-slug>/`
- **Anticipated themes** (do *not* tag yet — wait for them to emerge across
  articles): possibly `abstraction`, `human-roles`, `pedagogy`.

Front matter sketch:

```yaml
title: <to be drafted>
description: <one-sentence summary>
author: Brian Bingham
date: <publication date>
categories: [computing-history]
image: <hero-image.png>
```

## Policies

- **Multi-thread tagging.** An article can carry tags for two threads
  when the overlap is genuine — not as an SEO-style tagging habit.
- **Backfill policy for emerging themes.** When a theme is recognized,
  do one batch backfill across older articles, then tag forward as you
  write. Don't keep re-scanning the archive.
- **Project + thread on the same article.** Allowed when the article
  genuinely belongs to both — e.g. a `usv-control` project article
  that also fits an `engineering-pedagogy` thread. Flag as unusual
  when it happens.

## Technical-note + companion-essay pattern

A specialized pattern for releasing pre-existing LaTeX technical notes
(originally drafted in `~/WorkingCopies/OceanNotes/`) on the site. The
pattern keeps the technical writing in its native form (PDF rendered
from `.tex`) while giving it a friendly entry point on the web.

### Two-artifact model

Every release is two co-located artifacts:

- **The technical note** — PDF rendered from a `.tex` source. The
  primary scholarly artifact; carries the DOI.
- **The companion essay** — a short (~300–700 word) `index.qmd` that
  frames the note for a general engineering audience and links to the
  PDF for download.

Reading and citing diverge: a colleague on LinkedIn finds the essay; a
researcher in Google Scholar finds the PDF via DOI. Both point at the
same work.

### Folder layout

```
posts/<thread>/<slug>/
├── index.qmd        # companion essay
├── <slug>.tex       # LaTeX source (renamed to match slug)
├── <slug>.pdf       # the deposited PDF
├── hero.<ext>       # hero image (often a key figure from the PDF)
├── <figure>.png     # per-note figures
└── <support>.cls    # shared .cls/.sty/.bst/.bib copied per-note
```

Shared LaTeX resources (e.g. `npsreport2018.cls`, `math_bbing.sty`,
`bbing_master.bib`) are copied into each post folder rather than
centralized — self-contained folders are easier to reason about and
survive future restructuring at modest storage cost.

The `.tex` filename matches the slug, not the original filename
(e.g. `techreport_timeseries_from_psd.tex` → `spectra-from-psd.tex`).

### Categories

Two tags:

- `technical-note` — meta tag identifying companion-to-PDF essays
  (singular, per the "avoid plurals" lean above).
- The topical thread tag — `spectra`, `sonar`, `usv-control`, etc.

### Front matter

```yaml
title: <human-friendly title; not necessarily the PDF title>
description: <one-sentence summary aimed at LinkedIn readers>
author: Brian Bingham
date: <publication date on this site>
categories: [technical-note, <thread-tag>]
image: hero.<ext>
doi: 10.5281/zenodo.NNNNNNNN
citation: true
resources:
  - <slug>.pdf
```

The `date` field is the publication date on the carrel, not the
original `.tex` date. Original-write date goes in the body as
provenance.

### Companion-essay body

About 300–700 words, structured as:

1. Pull quote or abstract excerpt as a callout.
2. What the note is.
3. Why it's being released now.
4. Who it's for.
5. Original date / provenance.
6. Download block: `[Download PDF](<slug>.pdf) · DOI: …`

No format-conditional (`when-format`) blocks — the `.qmd` is HTML-only,
since the deposited PDF is rendered separately from the `.tex`. This
is the main divergence from the standard article pattern, which
renders one `.qmd` to both HTML and PDF.

### AI disclosure

Standard web callout, with one added sentence noting that the
technical note itself predates AI assistance and only the companion
essay was drafted with Claude Code. Exact wording will settle during
the first migration.

### Drafting and deposit

The companion essay is short enough to collapse `AUTHOR_WORKFLOW.md`'s
four-stage process — single annotated-outline pass, then draft, then
PMR. The Zenodo deposit procedure is `AUTHOR_WORKFLOW.md` Stage 5b.

### Landing page

A `technical-notes.qmd` landing page is deferred until 3+ technical
notes exist on the site (per the threshold in `CLAUDE.md`).
