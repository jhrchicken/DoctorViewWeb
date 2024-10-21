document.addEventListener("DOMContentLoaded", function () {
  // #header.on
  $('#header .gnb>li>a').on('mouseenter', function() {
    $('#header').addClass('on');
  });
  $('#header').on('mouseleave', function() {
    $('#header').removeClass('on');
  });
  
  // 스와이퍼
  var swiperTag = new Swiper('.tag .swiper', {
    loop: true,
    slidesPerView: 6,  
    spaceBetween: 20,
    centeredSlides: false,
  });
  
  // 스와이퍼
  var swiperDoctor = new Swiper('.doctor .swiper', {
    loop: false,
    slidesPerView: 3,  
    spaceBetween: 20,
    centeredSlides: false,
  });
  var swiperTime = new Swiper('.time .swiper', {
	loop: false,
	slidesPerView: 4,  
    spaceBetween: 20,
    centeredSlides: false,
  });
});