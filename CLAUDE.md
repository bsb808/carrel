# Notes for Claude Code

This file orients a Claude Code session to this repository. Read it first.

## What this repo is

A Quarto-based personal academic site. Short essays and technical notes,
not peer-reviewed, aimed at engineering colleagues. Deployed to GitHub Pages
via GitHub Actions. Substantive pieces are archived to Zenodo for DOIs and
Google Scholar indexing.

## Architecture in one paragraph

Quarto is the publishing engine (markdown → website with academic features).
GitHub is source-of-truth and host (markdown in git, GitHub Pages serves the
rendered site). Zenodo is the academic registrar (per-article DOIs, archival,
Scholar indexing). Reading experience and citation record are deliberately
decoupled: LinkedIn readers click through to a clean web page; researchers
find the same content via DOI in Scholar.

## Conventions

- One folder per post. One-offs go directly under `posts/<slug>/`. Posts in
  a sustained thread go under `posts/<thread>/<slug>/` (e.g.
  `posts/computing-history/where-are-the-humans/`).
- Front matter follows the pattern in `posts/welcome/index.qmd`. Always
  include `title`, `description`, `author`, `date`, `categories`, `image`.
  Add `doi` and `citation: true` only after a Zenodo deposit exists.
- The `categories` field should include the thread tag (kebab-case,
  lowercase, e.g. `computing-history`) even before that thread has its own
  folder or landing page. This lets thread structure emerge from tags.
- Posts are written in plain markdown with Quarto extensions (citations,
  cross-refs, math, callouts). Avoid raw HTML unless necessary.
- Images live alongside the post that uses them, not in a global assets dir.
- Bibliography, when needed, lives in the post folder as `references.bib`
  and is referenced from front matter.
- AI co-authorship disclosure: every article includes the web callout
  from `DISCLAIMER.md` above the first heading. The expanded form is
  used for Zenodo PDFs. Disclosure is added in stage 3 of article
  development, not earlier.
- Article development: substantive articles are developed in stages per
  `AUTHOR_WORKFLOW.md` — outline → annotated outline → draft → final —
  with a PMR review between stages.

## Thread structure thresholds

- **Always:** Apply a thread category tag, even if there's only one post.
- **At 3+ posts in a thread:** Move into a dedicated subfolder under
  `posts/`. Update internal links accordingly.
- **At 5+ posts in a thread:** Add a dedicated thread landing page (e.g.
  `computing-history.qmd`) at the repo root, with its own listing block,
  and link it from the navbar in `_quarto.yml`.
- **For genuinely sequential work:** Use Quarto's series mechanism for
  prev/next navigation. Distinct from categories; only use for true
  sequences (multi-part deep dives, annual scorecards).

When a thread crosses one of these thresholds, suggest the change rather
than making it silently — the user may want to weigh in on naming or
landing-page framing.

## Tasks Claude Code is likely to be asked to do

1. **Draft a new post.** Create `posts/<slug>/index.qmd` with proper front
   matter, write the content, suggest categories, generate any figures.
2. **Edit and restructure existing posts.** Tighten prose, fix references,
   improve headings, check internal links.
3. **Prepare a Zenodo deposit.** Render the post to PDF, draft the Zenodo
   metadata (title, description, keywords, authors, license), and after the
   user supplies the minted DOI, update the post's front matter. Full
   procedure: `AUTHOR_WORKFLOW.md` Stage 5 (per-article manual deposits).
4. **Maintain the site.** Update `_quarto.yml`, tune `styles.css`, adjust
   the GitHub Actions workflow, fix broken builds.

## Things to check before committing

- `quarto render` succeeds locally without errors.
- New posts have all required front matter fields.
- Internal links resolve.
- Open Graph metadata is present (title, description, image if available)
  so LinkedIn previews look good.
- No accidentally-committed `_site/`, `.quarto/`, or `_freeze/` directories.

## Things to leave alone unless asked

- The deploy workflow (`.github/workflows/publish.yml`) — works as-is.
- Author identity / ORCID in `_quarto.yml` and `CITATION.cff` — user
  manages these.
- Zenodo deposits themselves — user handles these on the Zenodo web UI.
  Claude Code's role is to prepare the PDF and metadata, not to talk to
  Zenodo directly.

## Style notes for writing

- Short essays, not papers. 800–2500 words is typical.
- Plain prose, minimal jargon, no academic throat-clearing.
- Headings used sparingly; the piece should read as continuous argument.
- Citations only when they actually do work — not as decoration.
