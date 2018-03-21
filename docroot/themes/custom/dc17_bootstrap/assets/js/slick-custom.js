$('.gallery').slick({
  slidesToShow: 1,
  slidesToScroll: 1,
  fades: true,
  asNavFor: '.gallery--nav',
  draggable: true
});

$('.gallery--nav').slick({
  slidesToShow: 5,
  slidesToScroll: 1,
  arrows: false,
  asNavFor: '.gallery',
  centerMode: true,
  focusOnSelect: true
});

$('.path-frontpage .block-views-blockpresentation-block-presentation .view-content').slick({
  slidesToShow: 4,
  slidesToScroll: 4,
  arrows: false,
  draggable: true,
  autoplay: true,
  autoplaySpeed: 1500,
  dots: true,
  responsive: [
    {
      breakpoint: 1200,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3
      }
    },
    {
      breakpoint: 870,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2,
        dots: false
      }
    },
    {
      breakpoint: 590,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        dots: false
      }
    }
  ]
});
