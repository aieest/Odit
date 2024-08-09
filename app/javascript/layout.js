import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
  if (typeof jQuery === 'undefined') {
    console.error('jQuery is not loaded');
    return;
  }

  jQuery(function($) {
    function checkScreenSize() {
      if ($(window).width() < 770) {
        $('.profile-info-div').empty();
        $('.profile-info-div').remove();
        console.log("mobile");
      } else {
        console.log("desktop test");
      }
    }

    checkScreenSize(); 
    $(window).resize(checkScreenSize);
  });
});