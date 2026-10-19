export default (function onDOMContentLoaded() {
  const callbacks: Array<() => void> = [];
  let domLoaded = false;

  const executeCallbacks = () => {
    domLoaded = true;
    while (callbacks.length) {
      const cb = callbacks.shift();
      if (cb) cb.call(null);
    }
  };

  if (typeof document !== 'undefined') {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', executeCallbacks);
    } else {
      domLoaded = true;
    }
  }

  return (callback: () => void) => {
    if (domLoaded) {
      setTimeout(callback, 0);
    } else {
      callbacks.push(callback);
    }
  };
})();
