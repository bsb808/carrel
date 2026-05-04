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
`.tex` source moves into `carrel` alongside the PDF and essay; OceanNotes
is being deprecated as a separate repo.

- [x] **Define the "technical note + companion essay" pattern** (do this
      first — TODO 1 is the first instance). Settled proposal below;
      AI-disclosure wording deferred to first migration.

      **Two-artifact model.** The PDF (rendered from `.tex` co-located
      in the post folder) is the primary scholarly artifact and carries
      the DOI. The companion essay (`index.qmd`) is a short framing
      piece. LinkedIn readers find the essay; researchers find the PDF
      via DOI in Scholar.

      **Folder + filenames.**
      - `posts/<thread>/<slug>/index.qmd` — companion essay
      - `posts/<thread>/<slug>/<slug>.tex` — LaTeX source (renamed from
        the original to match the slug; e.g.
        `techreport_timeseries_from_psd.tex` → `spectra-from-psd.tex`)
      - `posts/<thread>/<slug>/<slug>.pdf` — the deposited technical
        note (slug-based filename matches `where-are-the-humans`
        convention)
      - `posts/<thread>/<slug>/hero.<ext>` — usually a key figure
        lifted from the PDF
      - Per-note figures, `.bib` excerpts, etc. live alongside.

      **Shared LaTeX resources.** OceanNotes carries shared
      `.cls`/`.sty`/`.bst`/`.bib` files (`npsreport2018.cls`,
      `math_bbing.sty`, `my_acronyms.sty`, `nps_sf298.sty`,
      `npsthesis.bst`, `bbing_master.bib`, `ocean_notes.bib`). The
      needed subset is copied into each post folder — self-contained
      folders match the "one folder per post" spirit elsewhere in the
      repo, and the duplication is small.

      **Categories.** Two tags:
      - `technical-note` — meta tag for companion-to-PDF essays
        (singular, per CONVENTIONS.md "avoid plurals" lean).
      - Topical thread tag — `spectra`, `sonar`, `usv-control`, etc.

      **Front-matter template.**

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

      The `date` field is the carrel publication date, not the original
      `.tex` date — the original date goes in the body as provenance.

      **Body structure** (~300–700 words):
      1. Pull quote / abstract excerpt as callout.
      2. What it is.
      3. Why release it now (typical motives: useful to colleagues,
         pedagogical value, no peer-review pipeline planned).
      4. Who it's for.
      5. Original date / provenance — when the `.tex` was written;
         the Zenodo deposit dates the *release*, not the science.
      6. Download block: `[Download PDF](<slug>.pdf) · DOI: …`

      **No format-conditional blocks.** The `.qmd` is HTML-only — we
      do not render it to PDF. (Main divergence from
      `where-are-the-humans`, which renders the same `.qmd` to both.)

      **AI disclosure.** Standard web callout for the essay, with one
      added sentence noting that the technical note itself predates AI
      assistance and only the companion essay was drafted with Claude
      Code. *Exact wording deferred until first migration.*

      **Zenodo deposit.** Modeled on `AUTHOR_WORKFLOW.md` Stage 5, with
      the `.tex` pipeline replacing the `.qmd → PDF` render:

      1. Render `<slug>.tex` to PDF locally
         (`pdflatex` / `latexmk -pdf`); proofread.
      2. Upload to Zenodo, fill metadata (resource type:
         *Publication → Technical note* — not *Preprint*),
         **Reserve DOI**.
      3. Inject the reserved DOI into `<slug>.tex` (one-line footer
         on the title page; exact macro TBD), re-render.
      4. Wire DOI into `index.qmd` front matter, commit, push, deploy.
      5. Replace the deposited PDF with the DOI-stamped one, publish
         on Zenodo.
      6. Verify resolution + live page + PDF HTTP 200.

      **Companion-essay drafting.** Short enough to collapse the
      `AUTHOR_WORKFLOW.md` four-stage process — single annotated-outline
      pass, then draft, then PMR. Skip the formal Stage 1 outline.

      **Landing page.** Deferred until 3+ technical notes exist (per
      CLAUDE.md threshold). Then `technical-notes.qmd`.

      **OceanNotes deprecation.** Each migrated note is removed from
      OceanNotes (or marked as moved). Once all migration TODOs below
      are done, archive the OceanNotes repo with a README pointer to
      carrel and a final tag.

      **Doc updates once settled.**
      - `CONVENTIONS.md` — add "Technical-note + companion-essay"
        section
      - `CLAUDE.md` — one paragraph pointer to the new section
      - `AUTHOR_WORKFLOW.md` — note Stage 5 deltas (or add Stage 5b)

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
      *Stash 2026-05-03:* source moved as-is to
      `posts/sonar/single-beam-sonar/` for later cleanup. The `.tex` is
      draft-quality (fragmentary intro, no abstract, all figures
      commented out, ends mid-section) but renders to an 8-page PDF.
      No companion essay, no Zenodo deposit. Original kept in
      `OceanNotes/` until release proper.

- [ ] **Release CUSV modeling notes** (`cusv_model.tex`). Same pattern.
      Anchors the `usv-control` thread named in `PLAN.md`.
