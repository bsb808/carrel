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

## Open questions

- **One tag or several at the project/thread layer?** Can an article be
  in two threads? (Probably yes, but only when the overlap is genuine —
  not as a SEO-style tagging habit.)
- **Backfill policy for emerging themes.** Recommend: when a theme is
  recognized, do one batch backfill across older articles, then tag
  forward as you write. Don't keep re-scanning the archive.
- **Project + thread on the same article?** Plausible: a `usv-control`
  project article that also belongs to an `engineering-pedagogy` thread.
  Allow it; flag as unusual when it happens.
