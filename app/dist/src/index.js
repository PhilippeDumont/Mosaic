// Generated by CoffeeScript 1.9.3
(function() {
  var Library, Weather, currentBigImage, currentMovie, currentPosition, display, fs, library, readBigImage, readMovie, readSmalImage, run, sizeOf, state, view;

  fs = require('fs');

  sizeOf = require('image-size');

  Weather = (function() {
    function Weather(location) {
      this.location = location != null ? location : 'Luxembourg';
      this.info;
    }

    Weather.prototype.test = function() {
      return console.log(this.info);
    };

    Weather.prototype.getWheater = function() {
      var url;
      url = 'http://api.openweathermap.org/data/2.5/weather?q=Luxembourg,lu';
      return $.getJSON(url, function(data) {
        this.info = data;
        return this.test();
      });
    };

    return Weather;

  })();


  /*
  Library check in the file system to create all the Elements and put this element
  in arrays.
   */

  Library = (function() {
    function Library(imageDirectory, movieDirectory) {
      this.imageDirectory = imageDirectory;
      this.movieDirectory = movieDirectory;
      this.images = [];
      this.movies = [];
      this.bigImages = [];
      this.listElements();
    }

    Library.prototype.listElements = function() {
      var dimensions, file, image, imageFiles, k, l, len, len1, link, movie, movieFiles, results;
      this.images = [];
      imageFiles = fs.readdirSync(this.imageDirectory);
      for (k = 0, len = imageFiles.length; k < len; k++) {
        file = imageFiles[k];
        link = './images/' + file;
        dimensions = sizeOf(link);
        if (dimensions.height > 1080) {
          image = new Element('image', link, dimensions.width, dimensions.height);
          this.bigImages.push(image);
        } else {
          image = new Element('image', link, dimensions.width, dimensions.height);
          this.images.push(image);
        }
      }
      this.movies = [];
      movieFiles = fs.readdirSync(this.movieDirectory);
      results = [];
      for (l = 0, len1 = movieFiles.length; l < len1; l++) {
        file = movieFiles[l];
        link = './video/' + file;
        movie = new Element('video', link, 0, 0);
        results.push(this.movies.push(movie));
      }
      return results;
    };

    return Library;

  })();

  library = new Library('./images/', './video/');

  view = new GenerateHtml();

  display = function(elements) {
    var $el, i, image, k, len, template, x, y;
    template = '';
    i = 0;
    x = 0;
    for (k = 0, len = elements.length; k < len; k++) {
      image = elements[k];
      y = i % 3;
      template += view.getHtml(image, x, y);
      if (y === 2) {
        x++;
      }
      i++;
    }
    $el = $('#app');
    return $el.html(template);
  };

  state = 0;

  currentPosition = 0;

  currentBigImage = 0;

  currentMovie = 0;

  readSmalImage = function() {
    var j, tab;
    if (library.images.length > 0) {
      tab = [];
      j = 0;
      while (j < 9) {
        if (currentPosition >= library.images.length) {
          currentPosition = 0;
        }
        tab.push(library.images[currentPosition]);
        currentPosition++;
        j++;
      }
      display(tab);
    }
    return state = 1;
  };

  readBigImage = function() {
    var tab;
    if (library.bigImages.length > 0) {
      tab = [];
      if (currentBigImage >= library.bigImages.length) {
        currentBigImage = 0;
      }
      tab.push(library.bigImages[currentBigImage]);
      currentBigImage++;
      display(tab);
    }
    return state = 2;
  };

  readMovie = function() {
    var tab;
    if (library.movies.length > 0) {
      tab = [];
      if (currentMovie >= library.movies.length) {
        currentMovie = 0;
      }
      tab.push(library.movies[currentMovie]);
      currentMovie++;
      display(tab);
    }
    return state = 0;
  };

  run = function() {
    var myVideoPlayer, tab;
    tab = [];
    if (state === 0) {
      readSmalImage();
      setTimeout(refresh, 2000);
      return function refresh() {
      run();
    };
    } else if (state === 1) {
      readBigImage();
      setTimeout(refresh, 2000);
      return function refresh() {
      run();
    };
    } else if (state === 2) {
      readMovie();
      myVideoPlayer = document.getElementById('video');
      return myVideoPlayer.addEventListener('loadedmetadata', function() {
        var timeout;
        timeout = myVideoPlayer.duration;
        console.log(timeout);
        setTimeout(refresh, timeout * 1000);
        return function refresh() {
      run();
      };
      });
    }
  };

  setTimeout(refresh, 2000);

  function refresh() {
  run();
};

  //FULL SCREEN
//+++++++++++++++++++++++++++++++++++++++

document.addEventListener("keydown", function(e) {
  if (e.keyCode == 13) {
    toggleFullScreen();
  }
}, false);


function toggleFullScreen() {
  if (!document.fullscreenElement &&    // alternative standard method
      !document.mozFullScreenElement && !document.webkitFullscreenElement) {  // current working methods
    if (document.documentElement.requestFullscreen) {
      document.documentElement.requestFullscreen();
    } else if (document.documentElement.mozRequestFullScreen) {
      document.documentElement.mozRequestFullScreen();
    } else if (document.documentElement.webkitRequestFullscreen) {
      document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
    }
  } else {
    if (document.cancelFullScreen) {
      document.cancelFullScreen();
    } else if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen();
    } else if (document.webkitCancelFullScreen) {
      document.webkitCancelFullScreen();
    }
  }
}
;

}).call(this);
