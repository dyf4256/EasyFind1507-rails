// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener('turbo:load', function() {
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
});
