# TODO

Running list of deferred work. Strike items as they're completed.

## Setup

- [ ] **Personalization sweep for `carrel`.** Replace placeholders across the
      repo now that the name is decided. Wait until vocabulary is settled and
      the first article is drafted, so site title and tagline can be anchored
      against real content. Touches:
      - `PLAN.md` (placeholder language)
      - `_quarto.yml` — site title, description, `site-url` (will be
        `https://carrel.bbingham.dev`), author block, ORCID
      - `CITATION.cff` — name, ORCID, repo URL
      - `about.qmd` — bio, GitHub/LinkedIn links
      - `index.qmd` — tagline, intro paragraph
      - `README.md` — replace `yourname` placeholders

- [ ] **Configure DNS for `carrel.bbingham.dev`.** Add CNAME record at
      registrar pointing to `bsb808.github.io`. Add custom domain in repo
      Settings → Pages. GitHub auto-provisions Let's Encrypt.

- [ ] **Connect repo to GitHub Pages** (Settings → Pages → `gh-pages` branch).

- [ ] **Connect repo to Zenodo** (zenodo.org → GitHub → toggle the repo on).

- [ ] **Verify a test deploy succeeds** before the first real article.

## Migrate technical notes from `~/WorkingCopies/OceanNotes/`

Each technical note follows the same pattern: render the existing `.tex`
to PDF, deposit the PDF to Zenodo for an arXiv-style citable ID (DOI),
and publish a companion essay on the site that summarizes the work, says
why it's being released, and links to the DOI'd PDF for download. The
`.tex` source stays in `OceanNotes`; only the rendered PDF and the
companion essay land here.

- [ ] **Define the "technical note + companion essay" pattern** (do this
      first — TODO 1 is the first instance). Decide:
      - Category name for these companion essays (e.g., `technical-notes`),
        applied alongside the topical thread tag.
      - Where the PDF lives in the repo (proposed:
        `posts/<thread>/<slug>/<filename>.pdf` so the site serves a direct
        download in addition to the Zenodo copy).
      - Front-matter conventions: DOI field, "download PDF" button/link,
        abstract excerpt or pull quote, hero image strategy.
      - Whether to add a `technical-notes.qmd` landing page (deferred
        until 3+ notes exist, per the thread thresholds in `CLAUDE.md`).
      - Update `CONVENTIONS.md` and `CLAUDE.md` so future migrations
        follow the pattern without re-deciding.

- [ ] **Release spectra & stochastic-simulation notes.** Start with
      `techreport_timeseries_from_psd.tex` — most release-ready (formal
      abstract, NPS techreport polish, dated April 2023). Render PDF,
      deposit to Zenodo, write companion essay, publish. Then assess
      `spectra_notes.tex`: separate release or folded into the techreport
      essay? Thread tag: `spectra` (or preferred name — settle in the
      umbrella TODO).

- [ ] **Release sonar beam notes** (`sonar_beam_notes.tex`). Same
      pattern. Seeds a `sonar` (or `acoustics`) thread; one post for now,
      tagged with the thread name so future notes accrue.

- [ ] **Release CUSV modeling notes** (`cusv_model.tex`). Same pattern.
      Anchors the `usv-control` thread named in `PLAN.md`.
