// document.addEventListener('turbo:load', function() {
//   // Check if we're on the home page
//   if (window.location.pathname === '/') {
//     // Your scroll disabling code here
//     function preventScroll(e) {
//       e.preventDefault();
//     }

//     window.addEventListener('scroll', preventScroll, { passive: false });
//     window.addEventListener('wheel', preventScroll, { passive: false });
//     window.addEventListener('touchmove', preventScroll, { passive: false });

//     window.addEventListener('beforeunload', function(event) {
//       window.removeEventListener('scroll', preventScroll, { passive: false });
//       window.removeEventListener('wheel', preventScroll, { passive: false });
//       window.removeEventListener('touchmove', preventScroll, { passive: false });
//     });
//   }
// });
