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
