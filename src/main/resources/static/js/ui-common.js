$(function() {
  // #header.on
  $('#header .gnb>li>a').on('mouseenter', function() {
    $('#header').addClass('on');
  });
  $('#header').on('mouseleave', function() {
    $('#header').removeClass('on');
  });
});