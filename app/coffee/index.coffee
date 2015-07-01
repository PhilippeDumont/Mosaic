fs = require('fs')
sizeOf = require('image-size')


###
Element can be a picture or a video.
type : movie or picture
link : It the absolute link to this element
###
class Element
  constructor : (@type, @link, @width, @height) ->


###
View display an Element at the specified x and y position.
###
class View
  getHtml : (@element, @x, @y) ->

    #<image style="position:absolute; top:0px; left:0px;" src="images/test.jpg">
    html = ''

    if @element.type == 'image'

      html += '<img src="'
      html += @element.link
      html += '" style="position:absolute; top:'
      html += @x * @element.height
      html += 'px; left:'
      html += @y * @element.width
      html += 'px;"'
      html += '/>'

    else if @element.type == 'video'

      html += '<video id="video" autoplay '
      html += 'src="'
      html += @element.link
      html += '">'
      html += '</video>'

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


###
Library check in the file system to create all the Elements and put this element
in arrays.
###
class Library
  constructor : (@imageDirectory, @movieDirectory) ->
    @images = []
    @movies = []
    @bigImages = []
    @listElements()

  listElements : () ->
    # Reset
    @images = []

    imageFiles = fs.readdirSync(@imageDirectory)
    for file in imageFiles
      link = './images/' + file
      dimensions = sizeOf(link) 
      if(dimensions.height > 1080)
        image = new Element('image', link, dimensions.width, dimensions.height)
        @bigImages.push(image)
      else
        image = new Element('image', link, dimensions.width, dimensions.height)
        @images.push(image)

    @movies = []
    movieFiles = fs.readdirSync(@movieDirectory)
    for file in movieFiles
      link = './video/' + file
      movie = new Element('video', link, 0, 0)
      @movies.push(movie)



library = new Library('./images/', './video/')
view = new View()


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

  if library.images.length > 0

    tab = []
    j = 0
    while j < 9

      if(currentPosition >= library.images.length)
        currentPosition = 0

      tab.push(library.images[currentPosition])
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