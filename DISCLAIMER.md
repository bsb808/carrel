# AI Co-Authorship Disclosure

Site-wide policy. Every article on this site discloses that it was
written in collaboration with Claude Code (Anthropic). Two versions: a
brief callout for the web rendering, and an expanded version for the
PDF deposited to Zenodo.

## Web (top of every article)

Placed as a Quarto callout above the first heading.

```markdown
::: {.callout-note appearance="simple" icon=false}
I write these with Claude Code. I lead, it drafts and revises on my
instruction, and I review the final carefully before posting. Mistakes
are mine.
:::
```

## Zenodo PDF

Replaces the web callout in the rendered PDF, or appears in the PDF's
"AI use" / Methods section, depending on Zenodo deposit conventions.

```markdown
::: {.callout-note appearance="simple" icon=false}
**AI assistance disclosure.** This essay was drafted in collaboration
with Claude Code (Anthropic, Claude Opus 4.7). My role: framing the
argument, supplying sources, directing revisions, and a careful read
of the final text. Claude's role: drafting and revising on instruction,
and copyediting. I take full responsibility for the content, including
any errors.
:::
```

## Notes

- Place the callout *above* the first heading, not in the colophon.
- Update the model identifier (`Claude Opus 4.7`) when the working
  model version changes for substantive drafting.
- AI is never listed as an author in `_quarto.yml` author blocks or in
  `CITATION.cff`. Nature and COPE policy, and the convention emerging
  on academic blogs in 2026, both reject AI authorship on the grounds
  that an AI cannot bear authorship accountability.
- The wording was selected after a survey of AI co-authorship
  disclosures from Feb–May 2026 (academic blogs, Substack, LessWrong,
  Towards AI). Re-survey if this article is still in service after a
  year — convention is moving fast.
