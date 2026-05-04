# Handoff Notes — 2026-05-03

Resume notes for picking up the carrel deploy from a Linux machine
with sudo rights and `gh` CLI. Written at the end of a session on
macOS without admin / Quarto / `gh`. Delete this file once the site
is live and verified.

## Where we are

- Branch `main` pushed to `git@github.com:bsb808/carrel.git`, latest
  commit `7c56006` ("add CNAME file for custom-domain persistence")
  at handoff time. Working tree was clean.
- First article at `posts/computing-history/where-are-the-humans/`
  is fully drafted with `draft: false`. Site infrastructure
  (`_quarto.yml`, `index.qmd`, `about.qmd`, `LICENSE`, `CITATION.cff`,
  `README.md`, `.github/workflows/publish.yml`, `CNAME`, profile
  photo, hero image with Wikimedia attribution) all in place.
- Two GitHub Actions runs have been triggered by pushes during this
  session (commits `647ec1e` and `7c56006`). As of handoff, run
  status is unverified from this machine — check
  <https://github.com/bsb808/carrel/actions> or `gh run list` from
  the Linux side.

## What's pending — web UI work (unchanged across machines)

1. **Verify the latest deploy Action went green.**
   From Linux: `gh run list --limit 5`. If a run failed, click in to
   see the failing step. Common first-run issues: Quarto syntax in a
   `.qmd`, or `gh-pages` permissions.

2. **Configure GitHub Pages.** Repo Settings → Pages:
   - Source: "Deploy from a branch"
   - Branch: `gh-pages`, Folder: `/ (root)`. Save.
   - Custom domain: `carrel.bbingham.dev`. Save.
   - Leave **Enforce HTTPS UNCHECKED** until the DNS check goes
     green and the Let's Encrypt cert finishes provisioning
     (5–60 min after DNS resolves). Checking too early can lock
     you out for ~24h.

3. **Add Porkbun DNS record.** porkbun.com → bbingham.dev → DNS:
   - Type: `CNAME`
   - Host: `carrel` (Porkbun appends `.bbingham.dev`)
   - Answer: `bsb808.github.io`
   - TTL: default (600s)
   - The existing wildcard `*.bbingham.dev` is fine to leave —
     specific records take precedence.

4. **Verify DNS** after ~5–10 min:
   `dig +short carrel.bbingham.dev CNAME` should print
   `bsb808.github.io.`. Then refresh the GitHub Pages settings page;
   the DNS check should turn green.

5. **Enable HTTPS** once the cert spinner is gone.

6. **Connect Zenodo.** zenodo.org → sign in with GitHub → Settings
   → GitHub → toggle `bsb808/carrel` on. Future tagged releases
   will auto-deposit with metadata pulled from `CITATION.cff`.

## What's now possible on Linux (with sudo + gh)

- **Install Quarto CLI.** Either `sudo apt install quarto-cli` if
  the distro has it, or download the `.deb` from quarto.org and
  `sudo dpkg -i quarto-*.deb`. Confirm `quarto --version`.
- **Local preview.** `quarto preview` from repo root — full-fidelity
  render with live reload. Use this to verify the article and the
  about/landing pages before relying on the deployed site.
- **`gh` CLI.** If not pre-installed: `sudo apt install gh` (or
  download from cli.github.com). Authenticate with `gh auth login`.
- **Watch the deploy.** `gh run watch` after pushing to follow the
  workflow live; `gh run view --log-failed` to debug failed runs.

## Open questions worth revisiting (from PLAN.md)

- **Per-article concept DOIs.** The Zenodo–GitHub release
  integration creates one Zenodo record per repo with each tag as a
  version — so the repo gets one concept DOI, not one per article.
  If per-article concept DOIs matter, manual deposits or scripted
  Zenodo API use are the alternatives. Decide before the first
  tagged release.
- **Comments engine pilot** (Giscus / Utterances / Hypothesis) —
  enable on early posts and pick a default after a few articles.

## Gotchas worth re-checking after deploy

- **CNAME persistence.** `_quarto.yml`'s `resources: [CNAME]` ensures
  the file is copied to `_site/` on every render and lands in
  `gh-pages`. If a future workflow change moves the publish target,
  re-verify CNAME survives.
- **OG preview card.** Front-matter `image: hero.jpg` should drive
  LinkedIn/Slack preview cards. Test by drafting (not posting) a
  LinkedIn post with the live URL — the card should show title,
  description, and the Moore School photo.

## Reference

- `PLAN.md` — full publishing-architecture design doc
- `CONVENTIONS.md` — vocabulary (article / project / thread / theme
  / series) and tag/folder policies
- `AUTHOR_WORKFLOW.md` — 4-stage article development workflow
- `DISCLAIMER.md` — AI co-authorship disclosure policy
- `FUTURE_ARTICLES.md` — sketches for next pieces
- `TODO.md` — task list (kept in sync with this handoff)
