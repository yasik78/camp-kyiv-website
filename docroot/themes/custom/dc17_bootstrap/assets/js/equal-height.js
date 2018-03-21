function spHeight($selector, $parent, $adding) {
  var elem = $($selector);
  var parent = $($parent);

  var screenSmMax = 767;

  if($(window).width() > screenSmMax) {
    if (elem.length > 0) {
      var elemHeights = elem.map(function() {
        return $(this).height();
      }).get();

      var maxHeight = Math.max.apply(null, elemHeights);

      parent.css({
        'height': maxHeight
      });

    }
  } else {
    parent.css({
      'height': 'auto'
    });
  }
}

function frontSliderHeight($selector, $parent, $adding) {
  var elem = $($selector);
  var parent = $($parent);

    if (elem.length > 0) {
      var elemHeights = elem.map(function() {
        return $(this).height();
      }).get();

      var maxHeight = Math.max.apply(null, elemHeights);

      parent.css({
        'height': maxHeight
      });

    }
}