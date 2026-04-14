---
name: research-wall-html
description: Use when building or updating a research institute large-screen HTML page, exhibition wall, or stitched multi-screen dashboard. Best for fixed-size pages that must stay at 9120x1120, reuse existing asset folders and relative paths, keep images fully visible, avoid image pileups, improve readability, and make future stakeholder edits easy.
---

# Research Wall HTML

Use this skill for research institute big-screen pages built as plain HTML/CSS in an existing folder-based project.

## Core Rules

- Keep the canvas fixed at `width: 9120px; height: 1120px;`.
- Preserve the existing folder structure and relative asset paths.
- Do not rename, move, or flatten `images/`, `css/`, `shared/`, or existing page folders unless the user explicitly asks.
- Make images fully visible by default. Prefer `object-fit: contain` over cropped fills.
- Do not stack many unrelated images in one block. Spread visuals across the layout and interleave them with short text modules.
- Optimize for long-distance readability: strong hierarchy, large type, short paragraphs, clear captions, and high contrast.
- Make later edits easy: split content into named sections, keep CSS variables near the top, and avoid hard-coded positioning unless it is necessary.

## Workflow

1. Inspect the target page folder and existing shared scripts before editing.
2. If source material comes from PPTX, DOCX, or extracted media, summarize the narrative first:
   - title
   - 3-6 key messages
   - image groups
   - data points
3. Build the page around 5-8 modules max on a single `9120x1120` canvas.
4. Place each image inside a dedicated visual frame with a caption or nearby text.
5. Reuse `../shared/js/viewport-scaler.js` when the page sits under the project root.
6. Keep navigation links and neighboring page references consistent with the existing project.

## Preferred Layout Pattern

- Hero strip: title, subtitle, key metrics
- Narrative band: 2-3 short text blocks with a process or discipline map
- Evidence band: 2-4 image modules with captions
- Closing band: achievements, platforms, or curriculum/value summary

Read [references/layout-rules.md](references/layout-rules.md) before major edits or when creating a new page.

## Bundled Helpers

- Template starter: `assets/page-template/`
- Page scaffold script: `scripts/init_wall_page.py`

Use the script when a new page folder is needed and the project should keep the same `index.html + css + images` structure.
