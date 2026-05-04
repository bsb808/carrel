# TODO

Running list of deferred work. Strike items as they're completed.

## Setup

- [x] **Personalization sweep for `carrel`.** Done in commits
      `0c6bf2d`–`b50f2ae` and `5f6e615`: about.qmd, index.qmd,
      _quarto.yml, LICENSE, CITATION.cff, README.md, profile photo,
      deploy workflow, hero image. See `HANDOFF.md` for the full
      checkpoint.

- [ ] **Verify deploy Action goes green.** Check at
      <https://github.com/bsb808/carrel/actions>, or `gh run list`
      from a machine with `gh` CLI.

- [ ] **Configure DNS for `carrel.bbingham.dev`** at Porkbun.
      CNAME `carrel` → `bsb808.github.io`. The existing wildcard
      `*.bbingham.dev` is fine to leave; specific records take
      precedence.

- [ ] **Connect repo to GitHub Pages.** Settings → Pages → Source
      "Deploy from a branch", Branch `gh-pages`, Folder `/ (root)`,
      Custom domain `carrel.bbingham.dev`. Enable "Enforce HTTPS"
      only after the DNS check goes green and the cert finishes
      provisioning.

- [ ] **Connect repo to Zenodo.** zenodo.org → sign in with GitHub →
      Settings → GitHub → toggle `bsb808/carrel` on.

- [ ] **End-to-end verification.** Visit
      <https://carrel.bbingham.dev>, confirm landing page lists the
      article, click through to verify hero image, callout,
      footnotes. Test LinkedIn preview card.

- [ ] **Delete `HANDOFF.md`** once the site is live and verified.

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
