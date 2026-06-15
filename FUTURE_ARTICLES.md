# Future Articles

Running list of article ideas. Each entry is a sketch, not a commitment.
Promote to a draft under `posts/` when ready to write.

## The PMR workflow, and "workflows" as the new interface

**Working title (placeholder):** *Process My Review: A Workflow for Writing
With an AI Assistant*

**Sketch.** Two arguments braided together:

1. **The specific workflow is productive — for certain people.** The
   `git diff` plus inline `% CLAUDE:` comments pattern (see
   `~/WorkingCopies/claude-global/review_workflow.md`) gives the author a
   single top-to-bottom pass: direct edits and action requests resolved
   together, applied at once, reviewed in one diff editor. Suits authors
   who already think in version control and who want the model's help
   without surrendering authorship. Probably does not suit everyone, and
   the article should be honest about that.

2. **"Workflows" are emerging as the unit of human-computer interaction.**
   We used to interact via *commands* (CLI), then *applications* (GUI),
   then *documents* (the web). With capable assistants, the durable
   artifact is increasingly a **workflow** — a named, shareable recipe
   that combines human judgment, tool calls, and conventions for how to
   collaborate with a model on a recurring kind of task. PMR is one
   instance; many more will appear. The shift matters because workflows
   are *authored* by users (or small teams) rather than shipped by vendors.

**Link to existing thread.** Connect to the planned article on the
canonical *roles* of humans in computing (within the `computing-history`
thread). The roles piece argues that as abstraction and automation rise,
human roles shift but do not disappear; this PMR piece is a concrete
example of one such role — the *workflow author* — and how it differs
from "user" or "programmer."

**Anticipated tags:**

- Thread: `computing-history` (via the roles connection) — possibly also
  a new thread on AI-assisted writing/work if a second article in that
  vein emerges.
- Themes (do not tag yet): `human-roles`, `abstraction`, possibly
  `pedagogy` if the piece leans toward teaching the workflow.

**Open questions before drafting.**

- Lead with the workflow (concrete) or the thesis (abstract)? Probably
  concrete — show PMR, then generalize.
- How much to explain `git diff` mechanics for readers who do not live
  in version control? The audience is engineering colleagues, so
  probably brief.
- Is the "workflows as interface" claim strong enough to stand alone, or
  does it need a companion piece tracing CLI → GUI → web → workflow?

## Using AI — a thread of short, practical pieces on Claude Code

**Sketch.** A small thread of short articles (not papers) on *how* I
actually use an AI coding assistant — Claude Code specifically — in
day-to-day technical and writing work. Concrete, workflow-first, honest
about what suits me and what may not generalize. Candidate pieces:

1. **The review workflow, and why it's how I already work with students.**
   The `git diff` + inline `% CLAUDE:` review pass (see
   `~/WorkingCopies/claude-global/review_workflow.md`) is not a new way of
   working — it's the *same* loop I run with graduate students on their
   drafts: they hand me work, I mark it up with direct edits and margin
   questions, we resolve the marks together in one pass, and authorship
   stays with the student. The AI just fills the advisor's seat in a loop
   I already trust. The interesting claim: a good human–AI workflow often
   recapitulates a good human–human mentoring workflow, and that's a
   feature — it means the conventions are already battle-tested. Honest
   counterpoint: it suits people who already think in version control and
   who want help without surrendering authorship; it may not suit everyone.

2. **The three-level summary document.** A markdown convention where a
   document (or project, or chapter) carries its summary at three nested
   levels of depth — e.g. a one-line headline, a paragraph abstract, and a
   fuller section-by-section synopsis — so a reader (human *or* model) can
   zoom to the granularity they need without reading the whole artifact.
   Pairs naturally with AI-assisted work: the assistant maintains the
   summary layers, and the layered structure is itself how you orient an
   assistant to a large body of work quickly. Likely the same family as
   the review workflow — a small, authored convention that makes
   human–AI collaboration legible. *(Confirm with the user the exact
   three levels intended before drafting.)*

3. **(Open slot)** Additional short "using Claude Code" pieces as patterns
   accrue — e.g. drafting-with-an-assistant, the PMR diff loop mechanics,
   note migration, figure generation.

**Relation to the PMR entry above.** Overlaps deliberately. The PMR entry
leans *abstract* (workflows as the emerging unit of HCI, tied to the
`computing-history` roles thread). This thread leans *concrete and
practical* (here's the loop, here's why it works, try it). They can be
companion pieces: the practical one shows the workflow, the abstract one
generalizes it. Decide before drafting whether the student-mentoring
parallel belongs here as its own piece or folded into the PMR article.

**Anticipated tags.** A new thread tag for AI-assisted work (name TBD —
`using-ai`, `ai-workflows`, or similar); `pedagogy` on the
student-parallel piece. Apply the thread tag from the first post even
though the thread folder/landing page wait for the 3+/5+ thresholds
(per `CLAUDE.md`).

**Open questions before drafting.**

- Thread name. `using-ai` is broad; `claude-code` is specific but ties
  the thread to one tool's brand. Lean generic, mention the tool inside.
- Lead the student-parallel piece with the workflow (concrete) or the
  mentoring analogy (the hook)? Probably the analogy — it's the surprise.
- How much tool-specific detail before it dates quickly? Keep mechanics
  light; emphasize the transferable loop.

## Why CAD makes for terrible simulation models

**Sketch.** A short, opinionated engineering piece: a CAD model and a
simulation model are built for different purposes, and the temptation to
reuse CAD geometry directly as a simulation model usually produces a bad
simulation. CAD optimizes for *manufacturing fidelity* (every fillet,
fastener, and tolerance); simulation optimizes for *the right
abstraction* (the few parameters and idealizations that actually drive
the dynamics you care about). Importing CAD wholesale drags in
irrelevant detail, blows up cost, and obscures the physics — you end up
debugging mesh artifacts instead of understanding the system.

**Show our process.** Walk through how we actually build a simulation
model: start from the governing physics and the question being asked,
choose deliberate idealizations, pull *only* the parameters that matter
from the CAD (masses, inertias, key dimensions) rather than the geometry
itself. The CUSV modeling note (`posts/usv-control/cusv-model/`) is a
ready-made example — the deliberate top–bottom symmetry idealization and
the reduction to a 6-DOF parameter set are exactly this CAD-vs-sim
distinction in practice. Use it as the worked example.

**The AI angle (kept honest).** There are projects aiming to use AI to
*author* simulation models — potential future. But temper the hype: good
simulation models are already cheap to build once you know the
abstraction, so AI authoring won't be the big speed-up people imagine.
The expensive, valuable part is *choosing the right abstraction* —
judgment about what to keep and what to throw away — and that's the part
AI doesn't shortcut. The bottleneck was never the typing.

**Anticipated tags.** Topical: `usv-control` (via the CUSV example) and/or
a `modeling` / `simulation` thread tag; possibly `using-ai` for the
final section's connection to the AI thread above.

**Open questions before drafting.**

- Lead with the provocation ("CAD makes terrible sim models") or the
  worked CUSV example? Probably the provocation, then earn it with the
  example.
- How much of the CUSV note to reproduce vs link? Likely link to the
  PDF/essay and lift one figure.
- Name the AI-authoring projects specifically, or keep it general to
  avoid dating the piece? Lean general.

## Open-loop vs closed-loop robot sim — why sim still sucks for low-level control

**Sketch.** Simulation is great for some things and bad for others, and
the dividing line runs right through the control hierarchy. High-level,
open-loop or kinematic behavior (planning, geometry, "does the arm reach
the target") simulates well. Low-level *closed-loop* control — the tight
feedback loops at the actuator, where timing, latency, sensor noise,
friction, backlash, contact, and unmodeled dynamics dominate — is exactly
where sim still falls down. The model abstractions that make simulation
cheap and useful are the same ones that erase the effects a low-level
controller actually has to fight. So a controller that's beautiful in sim
can be useless on hardware, and sim-to-real for low-level control remains
hard for reasons that aren't going away just because compute got cheaper.

**Likely structure.** Draw the open-loop/closed-loop (or
high-level/low-level) distinction; explain *why* the gap is fundamental,
not just a fidelity problem you can mesh-refine away (it's about which
dynamics you chose to idealize); give a concrete example of a low-level
loop that sim flatters and hardware punishes (actuator latency, stiction,
contact). Honest takeaways about when to trust sim and when to get on
hardware early.

**Relation to the CAD/sim piece above.** Same family — both are about
"simulation is a deliberate abstraction, and trouble comes when you forget
what you abstracted away." The CAD piece is about *building* the model;
this one is about the *limits* of even a well-built model for a specific
job (low-level feedback). Could be companion pieces in a `simulation` /
`modeling` thread; cross-reference.

**Anticipated tags.** `usv-control` and/or a `simulation` / `modeling`
thread tag; possibly `controls`.

**Open questions before drafting.**

- Best worked example — a USV/robot actuator loop from our own work, or a
  generic stiction/latency illustration? Prefer something we've actually
  hit.
- Frame as "sim still sucks" (punchy, matches the user's phrasing) or a
  more measured "where sim's abstractions break for feedback"? Keep the
  punch in the hook, the nuance in the body.
- One thread for all the modeling/sim pieces (CAD, low-level control,
  possibly the AI-authoring angle), or keep them as separate topical
  tags? Decide once a second sim piece is actually drafted.