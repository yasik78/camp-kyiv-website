//= TimeCircles.js

(function ($) {
  $(document).ready(function () {
    labelColorToggle('.form-control', 'label.input-group-addon');
    labelColorToggle('.form-control', 'label.control-label');
    
    // Toggle button behavior for language button.
    toggleMenuLanguage();
    
    // Toggle button behavior for burger menu button.
    toggleMainMenu();
    
    // Equal height of content at information block.
    
    spHeight('.info-block__title .field--name-field-block-title', '.info-block .info-block__title', 10);
    spHeight('.info-block__body .field--type-text-long', '.info-block .info-block__body', 60);
    frontSliderHeight('.path-frontpage .block-views-blockpresentation-block-presentation .views-field-title',
      '.path-frontpage .block-views-blockpresentation-block-presentation .views-field-title');

    // Speaker view hover effect.
    // We need script due to the view structure.
    speakerHoverEffect();

    // Equal height of speakers content and micro button.
    speakersMicrophoneHeight();

    alertMessageSuccess();

  });
  
  $(window).on('load', function () {
    preloader();
  });
  
  $(window).resize(function () {
    spHeight('.info-block__title .field--name-field-block-title', '.info-block .info-block__title', 10);
    spHeight('.info-block__body .field--type-text-long', '.info-block .info-block__body', 60);

    // Equal height of speakers content and micro button.
    speakersMicrophoneHeight();
  });
  
  $(document).ajaxComplete(function() {

    speakerHoverEffect();
  });
  
  document.addEventListener("DOMContentLoaded", function () {
    var elements = document.getElementsByTagName("INPUT");
    
    for (var i = 0; i < elements.length; i++) {
      
      elements[i].oninvalid = function (e) {
        e.target.setCustomValidity("");
        if (e.target.validity.patternMismatch && (e.target.type == 'tel')) {
          e.target.setCustomValidity(Drupal.t("Not the right format, please enter numbers only"));
        } else if ((e.target.value == '') && (e.target.type == 'email')) {
          e.target.setCustomValidity(Drupal.t("Please fill out this field"));
        } else if (e.target.type == 'email') {
          e.target.setCustomValidity(Drupal.t("Not correct format, the email must have @ and ."));
        } else if (!e.target.validity.valid) {
          e.target.setCustomValidity(Drupal.t("Please fill out this field"));
        }
      };
      
      elements[i].oninput = function (e) {
        e.target.setCustomValidity("");
      };
    }
  });
  
  function labelColorToggle(inputClass, labelClass) {
    var $input = $(inputClass);
    var label = $(labelClass);
    
    $input.on({
      'focus': function () {
        $(this).prev(labelClass).addClass('focused');
      },
      blur: function () {
        $(this).prev(labelClass).removeClass('focused');
      }
    });
  }
  
  //= slick-custom.js
  
  function toggleMenuLanguage() {
    var languageButton = document.querySelector('.language-block__button');
    var languageList = document.querySelector('.language-block__list');
    var activeLanguage = document.querySelector('li.is-active').children[0].innerHTML;
    
    document.querySelector('.language-block__text').innerHTML = activeLanguage;
    
    languageButton.addEventListener('click', function (e) {
      e.preventDefault;
      languageList.classList.toggle('show-list');
    });
  }
  
  function toggleMainMenu() {
    var menuButton = document.querySelector('.navbar-toggle');
    var menuList = document.querySelector('.navbar-nav');
    
    menuButton.addEventListener('click', function (e) {
      e.preventDefault;
      menuList.classList.toggle('show-list');
    });
  }
  
  //= front-welcome.js
  
  function preloader() {
    if (document.querySelector('.path-frontpage')) {
      var $preloader = $('#page-preloader'),
        $spinner = $preloader.find('.spinner');
      $spinner.fadeOut();
      $preloader.delay(600).fadeOut('slow');
    }
  }
  
  // Timer function for welcome block on main page.
  Drupal.behaviors.countDown = {
    attach: function (context, settings) {
      $("html #DateCountdown").TimeCircles({
        fg_width: 0.1,
        bg_width: 0.1,
        time: {
          Days: {
            color: "#65bd6a",
            text: Drupal.t('Days')
          },
          Hours: {
            color: "#65bd6a",
            text: Drupal.t('Hours')
          },
          Minutes: {
            color: "#65bd6a",
            text: Drupal.t('Minutes')
          },
          Seconds: {
            color: "#65bd6a",
            text: Drupal.t('Seconds')
          }
        }
      });
      
      var updateTime = function () {
        var date = $("#date").val();
        var time = $("#time").val();
        var datetime = date + ' ' + time + ':00';
        $("#DateCountdown").data('date', datetime).TimeCircles().start();
      };
    }
  };

  function speakerHoverEffect() {
    var $speakerLink = $('.speaker__block .views-field-view-node a');

    if ($speakerLink.length > 0) {

      $speakerLink.on('mouseover', function() {
        $(this).parent()
                .parent()
                .parent()
                .find('.views-field-field-double-speaker-image')
                .find('.wrapper-speaker-link').addClass('hovered');
      }).on('mouseleave', function () {
        $(this).parent()
          .parent()
          .parent()
          .find('.views-field-field-double-speaker-image')
          .find('.wrapper-speaker-link').removeClass('hovered');
      });
    }
  }

  function speakersMicrophoneHeight() {
    var breakpointMd = 769;

    var $contentSelector = $('.speakers-main article');
    var $speakersParticipant = $('.speakers-main .speakers--became-participant');

    if ($(window).width() > breakpointMd) {
      var $contentHeight = $contentSelector.height();
      $speakersParticipant.css('height', $contentHeight);
    } else {
      $speakersParticipant.css('height', 'auto');
    }
  }
  
  //= equal-height.js


  function alertMessageSuccess() {
    var alertMessage = document.querySelector('.alert.alert-success');

    if (alertMessage != null && alertMessage != undefined ) {
      var close = alertMessage.querySelector('.close');
      var body = document.querySelector('body');
      var layout = document.querySelector('.overflow-layout');

      body.classList.add('overflow-hidden');
      layout.classList.add('active');

      close.addEventListener('click', function (e) {
        e.preventDefault();
        layout.classList.remove('active');
        body.classList.remove('overflow-hidden');
      });

      body.addEventListener('click', function () {
        alertMessage.style.display = 'none';
        close.click();
      });

      setTimeout(function() {
        alertMessage.style.display = 'none';
        close.click();
      }, 5000);
    }
  }
  
})(jQuery);

