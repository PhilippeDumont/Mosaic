fs = require('fs')
sizeOf = require('image-size')


class Weather
  constructor : (@location = 'Luxembourg') ->
    @info

  test : () ->
    console.log(@info)

  getWheater : () ->
    url = 'http://api.openweathermap.org/data/2.5/weather?q=Luxembourg,lu'

    $.getJSON(url , (data) ->
      @info = data
      @test()
    )



library = new Library('./images', './video')
view = new GenerateHtml()


display = (elements) ->
  template = ''
  i = 0
  x = 0

  for image in elements
    y = i % 3
    template += view.getHtml(image, x, y)

    if y == 2
      x++
    i++

  $el = $('#app')
  $el.html(template)



state = 0
currentPosition = 0
currentBigImage = 0
currentMovie = 0


readSmalImage = () ->

  if library.images1.length > 0

    tab = []
    j = 0
    while j < 9

      if(currentPosition >= library.images1.length)
        currentPosition = 0

      tab.push(library.images1[currentPosition])
      currentPosition++
      j++

    display(tab)

  state = 1


readBigImage = () ->

  if library.bigImages.length > 0

    tab = []

    if(currentBigImage >= library.bigImages.length)
      currentBigImage = 0

    tab.push(library.bigImages[currentBigImage])
    currentBigImage++

    display(tab)

  state = 2


readMovie = () ->

  if library.movies.length > 0

    tab = []
    if(currentMovie >= library.movies.length)
      currentMovie = 0

    tab.push(library.movies[currentMovie])
    currentMovie++

    display(tab)

  state = 0



run = () ->

  tab = []

  if state == 0

    readSmalImage()

    setTimeout(refresh, 2000)
    `function refresh() {
      run();
    }`

  else if state == 1

    readBigImage()

    setTimeout(refresh, 2000)
    `function refresh() {
      run();
    }`

  else if state == 2

    readMovie()

    myVideoPlayer = document.getElementById('video')

    myVideoPlayer.addEventListener('loadedmetadata', () ->
      timeout = myVideoPlayer.duration
      console.log(timeout)
      setTimeout(refresh, timeout * 1000)
      `function refresh() {
      run();
      }`
    )


setTimeout(refresh, 2000)
`function refresh() {
  run();
}`




`//FULL SCREEN
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
`
