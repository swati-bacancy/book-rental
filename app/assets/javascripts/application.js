// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree .
You need to modify your HTML population and JS code. Also, an action in Application Controller to respond to the request to fetch the cities of that state.

---
JS
---
$(document).on('change', '#states-of-country', function(e) {
  var cities_of_state, input_state, state;
  input_state = $(this);
  cities_of_state = $('#cities-of-state');
  state = this.options[e.target.selectedIndex].id;
  if (state === 'no-state') {
    return cities_of_state.html('');
  } else {
    $.ajax({
      url: '/cities/' + $(this).children(':selected').attr('id'),
      success: function(data) {
        var opt;
        opt = '<option value="" selected>Select Your City</option>';
        if (data.length === 0) {

        } else {
          data.forEach(function(i) {
            opt += '<option value="' + i + '">' + i + '</option>';
          });
          cities_of_state.html(opt);
        }
      }
    });
  }
});
