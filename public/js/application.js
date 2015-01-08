$(document).ready(function() {

  $('body').flowtype({
    minFont: 18,
    maxFont: 22,
    fontRatio: 30
  });

  $(".body-image").backstretch("https://ununsplash.imgix.net/34/BA1yLjNnQCI1yisIZGEi_2013-07-16_1922_IMG_9873.jpg?q=75&fm=jpg&s=8fac76943fb13ba5f0078d33e4eddd6a");
  $('.index-signup').addClass('animated fadeInDown');
  $('.index-login').addClass('animated fadeInUp');
  $('.index-welcome').addClass('animated fadeInDown');
  $('.index-resolutions').addClass('animated fadeInUp');
  $('.res-box').addClass('animated fadeIn');

  $('.modal-reveal').on('click', function(event) {
    event.preventDefault();
    $('#res-modal').foundation('reveal', 'open');
    $('#res-modal').foundation('reveal', 'close');
  });

  $('.res-box').on('submit', '.failed-form', function(event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      type: "PUT",
      url: $target.attr("action")
    }).done(function(response) {
      $target.parent().empty().append(response);
    });


  });
});
