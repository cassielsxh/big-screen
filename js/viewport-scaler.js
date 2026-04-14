(function () {
  const BASE_WIDTH = 9120;
  const BASE_HEIGHT = 1120;

  function applyScale() {
    const root = document.querySelector('[data-viewport-root]');
    if (!root) return;

    const scaleX = window.innerWidth / BASE_WIDTH;
    const scaleY = window.innerHeight / BASE_HEIGHT;
    const scale = Math.min(scaleX, scaleY);
    const scaledWidth = BASE_WIDTH * scale;
    const scaledHeight = BASE_HEIGHT * scale;

    root.style.transform = `scale(${scale})`;
    root.style.transformOrigin = 'top left';
    root.style.position = 'absolute';
    root.style.left = `${Math.max((window.innerWidth - scaledWidth) / 2, 0)}px`;
    root.style.top = `${Math.max((window.innerHeight - scaledHeight) / 2, 0)}px`;
  }

  window.addEventListener('resize', applyScale);
  window.addEventListener('load', applyScale);
  document.addEventListener('DOMContentLoaded', applyScale);
})();
