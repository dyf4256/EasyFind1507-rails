document.addEventListener('turbo:load', function() {
  // Function to disable scrolling based on the current path
  function disableScrollIfNeeded() {
    // Get the current path
    const currentPath = window.location.pathname;

    // List of paths where scrolling should be disabled
    const pathsToDisableScrolling = ['/', '/categories']; // Add your desired paths here

    // Check if the current path is in the list of paths to disable scrolling
    const shouldDisableScrolling = pathsToDisableScrolling.includes(currentPath);

    // If scrolling should be disabled, add a class to the body to prevent scrolling
    if (shouldDisableScrolling) {
      document.body.classList.add('disable-scroll');
    } else {
      // If scrolling shouldn't be disabled, remove the class to enable scrolling
      document.body.classList.remove('disable-scroll');
    }
  }

  // Call the function initially to handle the current path
  disableScrollIfNeeded();

  // Listen for Turbo navigation events and call the function to handle the new path
  document.addEventListener('turbo:before-render', function() {
    disableScrollIfNeeded();
  });
});
