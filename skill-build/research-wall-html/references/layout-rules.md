# Layout Rules

## Fixed Screen Contract

- The root screen must stay `9120px x 1120px`.
- The page must scale through the shared viewport script instead of changing the source canvas size.
- Use CSS Grid or flexible columns. Avoid dozens of absolutely positioned fragments.

## Readability

- Title: around `72px-116px`
- Section heading: around `34px-56px`
- Body copy: around `24px-34px`
- Captions and labels: around `20px-26px`
- Keep paragraphs short enough to scan from distance.

## Image Handling

- Wrap every image in a fixed-height frame.
- Use `width: 100%; height: 100%; object-fit: contain; object-position: center;`.
- If an image has a tall aspect ratio, pair it with a narrow text block instead of forcing it into a wide strip.
- If there are many source images, choose representative ones. Do not place all images just because they exist.

## Content Density

- One screen should usually carry 1 main story, 3-6 support points, and up to 6 visuals.
- Prefer summary labels and captions over long body text.
- Convert long source lists into grouped bullets, chips, timelines, or metric cards.

## Safe Editing Rules

- Keep asset references relative to the page folder.
- If a page already has `images/` and `css/`, reuse them.
- Add new CSS files only inside the target page folder unless the user asks for shared styles.
- Do not rewrite unrelated pages.
- Do not change shared scripts unless a layout bug requires it.

## Suggested Build Sequence

1. Extract source text and media.
2. Group the source into sections.
3. Sketch the grid using semantic sections.
4. Place visuals so each one has breathing room.
5. Trim copy until the screen reads cleanly at a glance.
6. Verify that no image is cropped unintentionally and no text block overflows.
