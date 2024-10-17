$(function() {
  // #header.on
  $('#header .gnb>li>a').on('mouseenter', function() {
    $('#header').addClass('on');
  });
  $('#header').on('mouseleave', function() {
    $('#header').removeClass('on');
  });
  
  // 스와이퍼
  var swiper = new Swiper('.tag .swiper', {
	loop: true,
	slidesPerView: 6,  
	spaceBetween: 20,
	centeredSlides: false,
  });
  
  // 스와이퍼
   var swiper = new Swiper('.doctor .swiper', {
    loop: false,
    slidesPerView: 3,  
  	spaceBetween: 20,
  	centeredSlides: false,
  });
});