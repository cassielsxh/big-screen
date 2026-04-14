#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path


HTML_TEMPLATE = """<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{title}</title>
  <link rel="stylesheet" href="./css/screen.css">
</head>
<body>
  <main class="screen" data-viewport-root>
    <section class="panel hero">
      <div>
        <p class="eyebrow">{eyebrow}</p>
        <h1>{title}</h1>
        <p class="lead">{subtitle}</p>
      </div>
      <div class="metrics">
        <article><strong>01</strong><span>Key message</span></article>
        <article><strong>02</strong><span>Key platform</span></article>
        <article><strong>03</strong><span>Key outcome</span></article>
      </div>
    </section>

    <section class="panel narrative">
      <h2>Core Narrative</h2>
      <div class="copy-grid">
        <p>Replace this text with the main program overview, discipline value, or institute mission.</p>
        <p>Keep paragraphs short and readable. Split long source material into concise statements.</p>
      </div>
    </section>

    <section class="panel visuals">
      <h2>Representative Visuals</h2>
      <div class="visual-grid">
        <figure class="visual-card">
          <div class="visual-frame"><img src="./images/placeholder-1.png" alt="visual 1"></div>
          <figcaption>Replace with a caption that explains why the image matters.</figcaption>
        </figure>
        <figure class="visual-card">
          <div class="visual-frame"><img src="./images/placeholder-2.png" alt="visual 2"></div>
          <figcaption>Keep images fully visible with contain mode.</figcaption>
        </figure>
      </div>
    </section>

    <section class="panel summary">
      <h2>Summary</h2>
      <ul>
        <li>Use short evidence-driven points.</li>
        <li>Keep the final band easy to revise after feedback.</li>
        <li>Do not change existing asset paths without approval.</li>
      </ul>
    </section>
  </main>

  <script src="../shared/js/viewport-scaler.js"></script>
  <script src="../shared/js/clicker.js"></script>
</body>
</html>
"""


CSS_TEMPLATE = """:root {
  --bg: #08111d;
  --panel: rgba(8, 18, 32, 0.9);
  --panel-alt: rgba(13, 28, 48, 0.92);
  --line: rgba(91, 160, 255, 0.24);
  --accent: #65b2ff;
  --accent-2: #f0c86f;
  --text: #f4f8ff;
  --muted: #b8c7db;
}

* { box-sizing: border-box; }

html, body {
  margin: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background:
    radial-gradient(circle at 12% 18%, rgba(101, 178, 255, 0.22), transparent 28%),
    radial-gradient(circle at 86% 20%, rgba(240, 200, 111, 0.18), transparent 24%),
    linear-gradient(160deg, #060b14 0%, #08111d 52%, #10233a 100%);
  color: var(--text);
  font-family: "Microsoft YaHei", "Noto Sans SC", sans-serif;
}

.screen {
  width: 9120px;
  height: 1120px;
  padding: 28px;
  display: grid;
  grid-template-columns: 2.2fr 1.7fr 1.7fr 1.4fr;
  grid-template-rows: 1.12fr 1fr;
  gap: 22px;
}

.panel {
  overflow: hidden;
  border: 1px solid var(--line);
  background: linear-gradient(180deg, var(--panel-alt), var(--panel));
  box-shadow: inset 0 0 40px rgba(101, 178, 255, 0.07);
  padding: 28px 34px;
}

.hero { grid-column: 1 / span 2; grid-row: 1; display: grid; grid-template-columns: 1.6fr 1fr; gap: 24px; align-items: end; }
.narrative { grid-column: 3 / span 2; grid-row: 1; }
.visuals { grid-column: 1 / span 3; grid-row: 2; }
.summary { grid-column: 4; grid-row: 2; }

.eyebrow { margin: 0 0 12px; color: var(--accent); font-size: 30px; letter-spacing: 1px; text-transform: uppercase; }
h1 { margin: 0 0 16px; font-size: 104px; line-height: 1.06; color: #fff2c5; }
h2 { margin: 0 0 18px; font-size: 42px; color: var(--accent-2); }
.lead, .copy-grid p, figcaption, li { font-size: 28px; line-height: 1.5; color: var(--muted); }

.metrics {
  display: grid;
  grid-template-columns: 1fr;
  gap: 14px;
}

.metrics article {
  padding: 18px 20px;
  border: 1px solid rgba(240, 200, 111, 0.26);
  background: rgba(7, 15, 28, 0.72);
}

.metrics strong {
  display: block;
  font-size: 52px;
  color: var(--accent-2);
}

.metrics span { font-size: 24px; color: var(--text); }

.copy-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 20px;
}

.visual-grid {
  height: calc(100% - 72px);
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 20px;
}

.visual-card {
  margin: 0;
  display: grid;
  grid-template-rows: 1fr auto;
  gap: 12px;
}

.visual-frame {
  min-height: 0;
  border: 1px solid rgba(101, 178, 255, 0.22);
  background: rgba(6, 12, 22, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 18px;
}

.visual-frame img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  object-position: center;
  display: block;
}

.summary ul {
  margin: 0;
  padding-left: 28px;
}

.summary li + li { margin-top: 12px; }
"""


def write_text(path: Path, content: str, force: bool) -> None:
    if path.exists() and not force:
        return
    path.write_text(content, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Scaffold a fixed-size research wall page.")
    parser.add_argument("page_dir", help="Target page directory, for example page10")
    parser.add_argument("--title", default="Research Institute Wall")
    parser.add_argument("--eyebrow", default="Research Institute Display")
    parser.add_argument("--subtitle", default="Update this subtitle with concise source-driven narrative.")
    parser.add_argument("--force", action="store_true")
    args = parser.parse_args()

    root = Path(args.page_dir)
    (root / "css").mkdir(parents=True, exist_ok=True)
    (root / "images").mkdir(parents=True, exist_ok=True)

    write_text(
        root / "index.html",
        HTML_TEMPLATE.format(title=args.title, eyebrow=args.eyebrow, subtitle=args.subtitle),
        args.force,
    )
    write_text(root / "css" / "screen.css", CSS_TEMPLATE, args.force)


if __name__ == "__main__":
    main()
