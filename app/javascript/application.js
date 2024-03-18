// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener('turbo:load', function() {
  if (window.location.pathname === '/') {
    const images = document.querySelectorAll('.carousel-image');

    // Initially, position all images off-screen to the right, except the first one.
    images.forEach((img, index) => img.style.left = index === 0 ? "0" : "100%");

    let currentIndex = 0;

    function slideImages() {
      const outgoingIndex = currentIndex;
      const incomingIndex = (currentIndex + 1) % images.length;

      // Slide out the current image to the left
      images[outgoingIndex].style.left = '-100%';

      // Before moving the outgoing image back to the start, disable its transition
      images[outgoingIndex].addEventListener('transitionend', function handler(e) {
        if(e.propertyName === 'left') {
          this.style.transition = 'none'; // Disable transition for reset movement
          this.style.left = '100%'; // Move back to start position off-screen to the right

          setTimeout(() => {
            this.style.transition = 'left 1s ease-out'; // Re-enable transitions for next slide-in
          }, 20);

          this.removeEventListener('transitionend', handler); // Clean up the event listener
        }
      });

      // Prepare the incoming image by positioning it off-screen to the right, then slide it in
      // Increase this delay to allow more time before the incoming image starts its transition
      setTimeout(() => {
        images[incomingIndex].style.transition = 'left 1s ease-out'; // Ensure transition is enabled
        images[incomingIndex].style.left = '0'; // Slide in the incoming image
      }, 250); // Increased delay to ensure no overlap in movements

      currentIndex = incomingIndex; // Update the current index to the next image
    }

    setInterval(slideImages, 3000); // Change images every 3 seconds
  }
});

// document.addEventListener('touchmove', function(event) {
//   // Check if the target of the touchmove event is within a scrollable area
//   let isScrollable = event.target.closest('.scrollable');
//   if (!isScrollable) {
//     // Prevent the touchmove event's default action if outside of scrollable areas
//     event.preventDefault();
//   }
// }, { passive: false });

// document.addEventListener('touchstart', function(event) {
//   var startY = event.touches[0].pageY;
//   var scrollableElement = document.querySelector('.scrollable'); // Your scrollable element

//   scrollableElement.addEventListener('touchmove', function(event) {
//     var moveY = event.touches[0].pageY;
//     var isScrollingDown = moveY > startY;
//     var scrollTop = scrollableElement.scrollTop;

//     if (scrollTop === 0 && !isScrollingDown) {
//       // Trying to scroll up when already at the top
//       event.preventDefault();
//     }
//   }, { passive: false });
// }, { passive: true });

// let lastScrollTop = 0;
// window.addEventListener("touchmove", function(evt) {
//   var bodyScrollTop = document.body.scrollTop || document.documentElement.scrollTop;
//   var direction = evt.touches[0].pageY > lastScrollTop ? "down" : "up";
//   lastScrollTop = evt.touches[0].pageY <= 0 ? 0 : evt.touches[0].pageY; // For Mobile or negative scrolling

//   if (bodyScrollTop === 0 && direction === "up") {
//     evt.preventDefault(); // At the top, moving up
//   }
// }, { passive: false });
