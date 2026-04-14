(function () {
  const pages = window.CENTER_PAGES || [];
  const root = document.querySelector("[data-center-slug]");
  if (!root) return;

  const slug = root.getAttribute("data-center-slug");
  const index = pages.findIndex((page) => page.slug === slug);
  const page = pages[index];

  if (!page) {
    root.innerHTML = "<section class='panel'><h2>页面未找到</h2><p>请检查中心标识是否与共享数据一致。</p></section>";
    return;
  }

  document.title = page.title + " | 研究院各中心成果展示";

  const prev = index > 0 ? pages[index - 1] : null;
  const next = index < pages.length - 1 ? pages[index + 1] : null;

  const metrics = page.metrics.map((metric) => (
    "<article class='metric'><strong>" + metric.value + "</strong><span>" + metric.label + "</span></article>"
  )).join("");
  const focuses = page.focuses.map((item) => "<li>" + item + "</li>").join("");
  const projects = page.projects.map((item) => "<li>" + item + "</li>").join("");
  const achievements = page.achievements.map((item) => "<li>" + item + "</li>").join("");
  const keywords = page.focuses.map((item) => "<span class='chip'>" + item.replace(/[。]/g, "") + "</span>").join("");
  const visuals = page.visuals.map((visual) => (
    "<figure class='visual-card'>" +
      "<div class='visual-frame'><img src='" + visual.src + "' alt='" + page.title + "素材'></div>" +
      "<figcaption>" + visual.caption + "</figcaption>" +
    "</figure>"
  )).join("");

  root.innerHTML =
    "<section class='panel hero'>" +
      "<div class='hero-copy'>" +
        "<p class='eyebrow'>" + page.tag + "</p>" +
        "<h1>" + page.title + "</h1>" +
        "<p class='hero-summary'>" + page.summary + "</p>" +
        "<dl class='meta-block'>" +
          "<dt>负责人</dt><dd>" + page.pi + "</dd>" +
          "<dt>团队概况</dt><dd>" + page.team + "</dd>" +
        "</dl>" +
      "</div>" +
      "<div class='hero-side'><div class='metric-grid'>" + metrics + "</div></div>" +
    "</section>" +
    "<section class='panel'><h2>研究方向</h2><ul class='bullet-list'>" + focuses + "</ul></section>" +
    "<section class='panel team-panel'>" +
      "<div><h2>团队与协同</h2><p>" + page.team + "</p></div>" +
      "<div class='chip-row'>" + keywords + "</div>" +
      "<div class='summary-list'>" +
        "<article><h3>编辑方式</h3><span>文案、指标、图片路径统一维护在共享数据文件，领导改动时不需要重排整个页面。</span></article>" +
        "<article><h3>素材策略</h3><span>默认引用解包文档中的原始媒体目录，路径不搬迁，后续可直接替换同目录素材。</span></article>" +
      "</div>" +
    "</section>" +
    "<section class='panel'><h2>项目布局</h2><ul class='bullet-list'>" + projects + "</ul></section>" +
    "<section class='panel'><h2>代表成果</h2><ul class='highlight-list'>" + achievements + "</ul></section>" +
    "<section class='panel visual-panel'><h2>素材与图示</h2><div class='visual-grid'>" + visuals + "</div></section>" +
    "<p class='edit-note'>维护提示：优先修改 ./shared/js/center-pages-data.js 中对应中心的数据和图片路径。</p>" +
    "<nav class='pager' aria-hidden='true'>" +
      "<a href='" + (prev ? "../" + prev.slug + "/index.html" : "../index.html") + "'>" + (prev ? "上一中心" : "返回导航") + "</a>" +
      "<a href='../index.html'>中心导航</a>" +
      "<a href='" + (next ? "../" + next.slug + "/index.html" : "../index.html") + "'>" + (next ? "下一中心" : "返回导航") + "</a>" +
    "</nav>";
}());
