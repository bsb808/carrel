# Publishing Plan: Quarto + GitHub + Zenodo

> Status: design document. Repo name and personal details are placeholders.
> Refine and rename as the setup matures.

## Goal

A lightweight but professional venue for publishing short articles —
essays, technical notes, and high-level concept pieces — aimed primarily
at engineering academic colleagues and educators.

Explicitly *not* a peer-reviewed venue. Pieces are working thoughts shared
early, with revision over time as thinking evolves.

## Requirements

The chosen infrastructure must support:

- **Free distribution.** No paywalls, no platform lock-in.
- **Readership signal.** Some way to see whether anyone reads what's posted.
- **Discoverability via Google Scholar.** Pieces should accrue to academic
  metrics, not just sit as blog posts.
- **LinkedIn-friendly.** Colleagues will most likely encounter the work
  via LinkedIn, so previews need to look good there.
- **Git version control.** Source lives in a repo, with full history.
- **Claude Code integration.** Drafting, editing, and maintenance happen
  through Claude Code in the normal repo workflow.
- **Instagram (secondary).** Enough hooks (hero images, pull quotes) to
  support occasional cross-posting, without distorting the primary design.

Explicitly *not* required:

- Peer review.
- Subscriber/newsletter mechanics (LinkedIn covers distribution).
- Algorithmic discovery (the audience is colleagues, not strangers).

## Venues considered and rejected

**Academic networking sites** (ResearchGate, Academia.edu) — automatically
dismissed by most of the target audience.

**Preprint servers** (arXiv, TechRxiv, engrXiv) — culturally oriented around
paper-shaped research results. Essays and concept pieces feel out of place.

**Substack / Medium** — strong on reading experience and analytics, but no
git integration, no Claude Code workflow, weak Scholar indexing, and a
"this is just a blog" credibility signal that undercuts academic colleagues
treating the work as serious.

**SSRN** — accepts essays and working papers, but Elsevier-owned and more
oriented to economics/law/social sciences than engineering.

**Personal blog only** (WordPress, Ghost, etc.) — fine reading experience,
but no built-in path to DOIs and Scholar indexing without bolt-ons.

## Chosen architecture: Quarto + GitHub Pages + Zenodo

### What each piece does

**Quarto** is the publishing engine. Markdown source files in, polished
website out. Handles academic features (citations, math, cross-references,
code execution, figure numbering) and web features (typography, responsive
layout, RSS, Open Graph metadata for social previews).

**GitHub** is the source of truth and the host. Articles live as markdown
in a git repository. GitHub Pages serves the rendered site for free at a
stable URL. Every change is tracked, diffable, recoverable.

**Zenodo** is the academic registrar. Takes a snapshot of an article and
mints a DOI — a permanent identifier indexed by Google Scholar, immune to
site reorganization, signaling "citable scholarly artifact" rather than
"blog post." Zenodo also commits to long-term archival.

### How they compose

The split of responsibility is clean:

- Quarto handles **presentation** — what readers see when they click a link.
- GitHub handles **source and hosting** — where content lives, how it
  reaches the web.
- Zenodo handles **scholarly identity** — making pieces citable and
  discoverable through academic channels.

Reading experience and citation record are deliberately decoupled. A reader
on LinkedIn clicks through to a clean web page. A researcher doing a
literature search finds the same content via DOI in Scholar. Both point at
the same writing; each audience gets the affordances that suit them.

### What this architecture buys

- *Reading experience* of a modern blog.
- *Workflow* of a code project (git, CI, Claude Code, local preview).
- *Scholarly properties* of a preprint server (DOI, archival, Scholar).
- *No platform lock-in.* If Zenodo disappeared, content is unaffected. If
  GitHub changed terms, the repo moves elsewhere in an afternoon. If
  Quarto stopped being maintained, the markdown files are still markdown.

### What this architecture costs

- *No algorithmic discovery.* No recommendation engine surfaces work to
  strangers. Distribution depends on LinkedIn, the existing professional
  network, and whatever cross-posting effort is made.
- *No built-in subscriber list.* Readers don't opt in to a feed. RSS is
  available but rarely used by the target audience.
- *Manual Zenodo deposits* for per-article DOIs (a few minutes each).

For an audience of colleagues, these are the right tradeoffs.

## Workflow

### Drafting

Work in a local clone of the repo, editing markdown files. Claude Code
operates on these files like any other code project — drafting,
restructuring, checking references, generating figures.

### Publishing

`git push` to main. GitHub Actions runs Quarto, renders the site, deploys
to GitHub Pages. The article is live on the web within a minute or two.

### Promoting

Share the article URL on LinkedIn. The Open Graph metadata Quarto generates
produces a clean preview card. Optionally cross-post to Instagram as a
hero image or carousel with "link in bio" pointing at the latest piece.

### Archiving (substantive pieces only)

Render the article to PDF, upload to Zenodo with metadata, receive a DOI.
Add the DOI to the article's front matter; next push updates the live page
to display it. Google Scholar picks up the deposit on its next crawl, and
the piece begins accruing citation metrics.

### Iterating

Edits to the live web version happen freely via git. The Zenodo deposit is
a frozen snapshot — substantive revisions get a new deposit, which Zenodo
links to the original via a versioned DOI chain. Web reads as current;
scholarly record reads as versioned.

## Per-platform considerations

### LinkedIn (primary distribution)

- Open Graph metadata in `_quarto.yml` and per-post front matter ensures
  preview cards render with title, description, and hero image.
- Posts should include a substantive caption — LinkedIn rewards posts that
  read as standalone thoughts, not just link drops.
- Track which pieces resonate by watching LinkedIn's own engagement
  metrics; treat this as the primary readership signal alongside Zenodo
  download counts.

### Google Scholar

- Indexing happens through the Zenodo deposit, not the GitHub Pages site.
- Each DOI'd piece accrues to author metrics if the ORCID is set
  consistently across deposits.
- Allow a few weeks after deposit for Scholar's crawler to pick up new
  records.

### Instagram (secondary distribution)

Instagram is hostile to outbound links by design — no clickable links in
captions or comments, only in bio (one link) and Stories (business account
required). It is not an efficient traffic driver.

If used at all, the realistic patterns are:

- *Hero image post* with key figure or pull quote, caption summarizing the
  idea, "link in bio" pointing at the latest article.
- *Carousel post* (5–10 slides) treating the article itself as the content,
  with "full version at link in bio" as the closer.
- *Stories with link stickers* for new-article announcements (ephemeral,
  saved as Highlights for persistence).

To support this without distorting the architecture: every post should
have a hero image (already useful for LinkedIn Open Graph) and at least
one pull-quote-worthy sentence. Carousel generation is a Canva or Figma
task downstream of the article; can be scripted later if it becomes
frequent.

For the target audience (engineering academics and educators), Instagram
is probably low-priority. LinkedIn is where the readers are.

## Organizing threads, projects, and topics

Writing here will span several threads — some sustained, multi-post explorations
of a topic, others one-off pieces. The site needs to support both without
imposing structure prematurely.

### Mechanisms

Quarto provides several tools, each doing different work:

- **Categories.** Tags on individual posts (`categories: [computing-history]`)
  declared in front matter. A post can have several. The default index page
  shows category filters, so readers can narrow by tag. Lightest-weight option;
  adopt from day one.
- **Multiple listings.** Separate landing pages for different threads
  (`computing-history.qmd`, `usv-control.qmd`), each filtering posts by
  category or path. A few lines of YAML each. Adds a thread-level entry point
  without restructuring the post folder.
- **Folder-based grouping.** Subdirectories under `posts/` for sustained
  threads (`posts/computing-history/`, `posts/usv-control/`). Organizational,
  not required by Quarto. Useful once a thread has enough posts that scanning
  the flat folder gets noisy.
- **Series.** A Quarto convention for ordered multi-part work, providing
  prev/next navigation and "Part N of M" framing. Distinct from categories:
  a series is a *sequence*, a category is a *bucket*.

### When to use what

- **Always:** Categories on every post, even if there's just one tag at first.
- **At 3+ posts in a thread:** Move into a dedicated subfolder under `posts/`.
- **At 5+ posts in a thread:** Add a dedicated thread page with its own
  intro/listing, linked from the navbar.
- **For genuinely sequential work only:** Use the series mechanism (annual
  scorecards, multi-part deep dives, course-like progressions).

### Naming threads

Use short, stable category names — kebab-case, lowercase, ideally one or two
words. Once a thread is named, keep using the same tag; reserve renaming for
genuinely necessary cases. Sample threads (illustrative, not commitments):

- `computing-history` — historical framing of computing transitions
- `usv-control` — unmanned surface vessel modeling and autopilot work
- `teaching` — engineering pedagogy, especially during the AI transition
- `notes` — short one-offs that don't (yet) belong to a thread

Threads that get named tend to get continued; one-offs tend to stay one-offs.
Worth naming a thread the first time you suspect there might be a second post.

## Repo layout

```
.
├── _quarto.yml              # site config: title, author, theme, OG tags
├── index.qmd                # landing page (lists all posts, filterable)
├── about.qmd                # about page
├── computing-history.qmd    # (example) per-thread landing page
├── usv-control.qmd          # (example) per-thread landing page
├── styles.css               # minimal custom CSS
├── CITATION.cff             # repo-level citation metadata
├── CLAUDE.md                # briefing for Claude Code sessions
├── README.md                # human-facing repo docs
├── PLAN.md                  # this file
├── .gitignore
├── posts/
│   ├── <one-off-slug>/
│   │   └── index.qmd        # one-off pieces live directly under posts/
│   ├── computing-history/   # sustained threads get their own subfolder
│   │   ├── <post-slug>/
│   │   │   ├── index.qmd
│   │   │   ├── figure1.png  # assets live alongside the post
│   │   │   └── references.bib
│   │   └── <another-slug>/
│   │       └── index.qmd
│   └── usv-control/
│       └── <post-slug>/
│           └── index.qmd
└── .github/workflows/
    └── publish.yml          # CI: render Quarto + deploy to gh-pages
```

## Conventions

- One folder per post. One-offs live directly under `posts/<slug>/`;
  posts in a sustained thread live under `posts/<thread>/<slug>/`.
- Front matter always includes: `title`, `description`, `author`, `date`,
  `categories`, `image` (for OG/Instagram).
- `categories` should include the thread tag (e.g. `[computing-history]`)
  even before the thread has its own folder or landing page — this lets
  thread structure emerge from tags rather than be imposed up front.
- `doi` and `citation: true` added only after a Zenodo deposit exists.
- Plain markdown with Quarto extensions (citations, cross-refs, math,
  callouts). Avoid raw HTML unless necessary.
- Bibliographies, when needed, live in the post folder as `references.bib`.
- Posts are 800–2500 words typically. Short essays, not papers.
- Plain prose, minimal jargon, no academic throat-clearing.

## Personalization checklist (before first deploy)

- [ ] Choose final repo name (current: placeholder)
- [ ] `_quarto.yml`: site title, description, `site-url`, author block,
      ORCID
- [ ] `CITATION.cff`: name, ORCID, repo URL
- [ ] `about.qmd`: bio, GitHub/LinkedIn links
- [ ] `index.qmd`: tagline, intro paragraph
- [ ] `README.md`: replace `yourname` placeholders
- [ ] Connect repo to GitHub Pages (Settings → Pages → `gh-pages` branch)
- [ ] Connect repo to Zenodo (zenodo.org → GitHub → toggle the repo on)
- [ ] Verify a test deploy succeeds before writing the first real post

## Open questions to revisit

- **Custom domain?** A `yourname.dev` or similar would future-proof the URL
  beyond `*.github.io`. Easy to add later via GitHub Pages settings + DNS.
- **Per-article DOI vs per-release DOI?** Current plan: per-article via
  manual PDF upload to Zenodo for substantive pieces. The
  Zenodo–GitHub release integration is an alternative if manual uploads
  become friction.
- **Comments?** Quarto supports Hypothesis, Giscus, Utterances. Defer
  unless there's demand.
- **Newsletter?** A simple "subscribe via RSS" mention may suffice. If
  email becomes important later, Buttondown or similar can be bolted on
  without changing the underlying architecture.
- **Carousel automation?** Worth scripting only if Instagram cross-posting
  becomes a regular habit.

## Test cases this design should handle well

- **Predictions scorecard with annual updates** (Brooks-style). Git history
  serves as built-in audit trail of what was predicted when. Annual
  snapshots deposited to Zenodo for citability.
- **Conceptual essay aimed at educators** ("Where Are the Humans?
  Engineering Computation as a History of Roles"). Lives as a readable
  web essay for LinkedIn discovery; gets a DOI for Scholar indexing and
  citability. Falls cleanly between "preprint" and "blog post" without
  feeling out of place in either.
