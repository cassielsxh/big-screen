(function () {
  const nextKeys = new Set(['ArrowRight', 'PageDown', ' ', 'Spacebar']);
  const prevKeys = new Set(['ArrowLeft', 'PageUp']);

  function getLinks() {
    return Array.from(document.querySelectorAll('[data-next-page], [data-prev-page]'));
  }

  function navigate(selector) {
    const target = document.querySelector(selector);
    if (target && target.getAttribute('href')) {
      window.location.href = target.getAttribute('href');
      return true;
    }
    return false;
  }

  document.addEventListener('keydown', function (event) {
    if (nextKeys.has(event.key)) {
      if (!navigate('[data-next-page]')) {
        window.scrollTo({ left: window.innerWidth, behavior: 'smooth' });
      }
      event.preventDefault();
    }

    if (prevKeys.has(event.key)) {
      if (!navigate('[data-prev-page]')) {
        window.scrollTo({ left: 0, behavior: 'smooth' });
      }
      event.preventDefault();
    }
  });
})();
