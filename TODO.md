# TODO

Running list of deferred work. Strike items as they're completed.

## Setup

- [x] **Personalization sweep for `carrel`.** Done in commits
      `0c6bf2d`–`b50f2ae` and `5f6e615`: about.qmd, index.qmd,
      _quarto.yml, LICENSE, CITATION.cff, README.md, profile photo,
      deploy workflow, hero image. See `HANDOFF.md` for the full
      checkpoint.

- [x] **Verify deploy Action goes green.** Confirmed 2026-05-03: run
      25299007577 succeeded after seeding the `gh-pages` branch
      (orphan) — earlier runs failed only because the branch didn't
      yet exist on the remote.

- [x] **DNS for `carrel.bbingham.dev`.** Already configured at
      Porkbun; `dig +short carrel.bbingham.dev` returns
      `bsb808.github.io.` and the GitHub Pages IPs.

- [x] **GitHub Pages.** Already set: source `gh-pages` / root,
      custom domain `carrel.bbingham.dev`. HTTPS cert approved
      (expires 2026-08-01); `https_enforced` flipped to `true` on
      2026-05-03.

- [x] **Site renders end-to-end.** Verified 2026-05-03 at
      <https://carrel.bbingham.dev> — landing page lists the
      article, hero image and callout render.

- [ ] **Connect repo to Zenodo (path B option, deferred).**
      zenodo.org → Settings → GitHub → toggle `bsb808/carrel` on.
      Only needed if a repo-level concept DOI is ever wanted *in
      addition* to per-article DOIs. Path A (per-article manual
      deposits) is the canonical model and does not require this.

- [x] **First-article archival pass.** Done 2026-05-03 via path A.
      `where-are-the-humans` →
      [10.5281/zenodo.20018252](https://doi.org/10.5281/zenodo.20018252).
      Procedure now documented as `AUTHOR_WORKFLOW.md` Stage 5;
      apply to subsequent substantive articles.

- [ ] **LinkedIn preview card check.** Draft (don't post) a
      LinkedIn share of the live URL; confirm the OG card shows
      the title, description, and Moore School photo.

- [ ] **Bump `actions/checkout` to v5** in
      `.github/workflows/publish.yml`. Non-urgent: GitHub deprecates
      Node 20 actions on 2026-09-16.

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
