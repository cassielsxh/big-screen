(function () {
  const pages = window.CENTER_PAGES || [];
  const root = document.querySelector("[data-center-hub]");
  if (!root) return;

  document.title = "研究院各中心成果展示导航";

  const cards = pages.map((page) => {
    const metrics = page.metrics.slice(0, 2).map((metric) => "<span>" + metric.label + " " + metric.value + "</span>").join("");
    return (
      "<a class='hub-card' href='./" + page.slug + "/index.html'>" +
        "<p class='tag'>" + page.tag + "</p>" +
        "<h2>" + page.title + "</h2>" +
        "<p>" + page.summary + "</p>" +
        "<div class='meta'>" + metrics + "</div>" +
      "</a>"
    );
  }).join("");

  root.innerHTML =
    "<section class='hub-hero'>" +
      "<div>" +
        "<p class='hub-eyebrow'>RESEARCH CENTER WALL | 9120 x 1120 FIXED CANVAS</p>" +
        "<h1 class='hub-title'>研究院各中心成果展示导航</h1>" +
        "<p class='hub-summary'>已按“一中心一页”生成固定尺寸展示页，统一复用共享脚本与集中式数据配置。后续若领导调整文案、指标或图片，只需要修改共享数据文件中的对应中心内容即可。</p>" +
      "</div>" +
      "<div class='hub-metrics'>" +
        "<div class='hub-metric'><strong>" + pages.length + "</strong><span>中心页面</span></div>" +
        "<div class='hub-metric'><strong>9120×1120</strong><span>固定画布</span></div>" +
        "<div class='hub-metric'><strong>1处</strong><span>集中维护数据</span></div>" +
        "<div class='hub-metric'><strong>原路径</strong><span>素材目录保留</span></div>" +
      "</div>" +
    "</section>" +
    "<section class='hub-grid'>" + cards + "</section>";
}());
