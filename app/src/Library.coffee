fs = require('fs')
sizeOfImage = require('image-size')

class Library

  constructor : (@imageDirectory, @movieDirectory) ->
    @images1 = []
    @images2V = []
    @images2H = []
    @images3V = []
    @images3H = []
    @images4 = []

    @movies = []
    @bigImages = []
    @listElements()

  listElements : () ->
    @_reset()

    imageFiles = fs.readdirSync(@imageDirectory)
    @_sortImage(imageFiles)

  _reset : () ->
    @images1 = []
    @images2V = []
    @images2H = []
    @images3V = []
    @images3H = []
    @images4 = []
    @images9 = []


  _sortImage : (images) ->
    for file in images
      link = 'images/' + file
      imageDimension = sizeOfImage(link)

      if(imageDimension.height == 1080 and imageDimension.width == 1920)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images1.push(image)

      if(imageDimension.height == 1080*2 and imageDimension.width == 1920)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images2V.push(image)

      if(imageDimension.height == 1080 and imageDimension.width == 1920*2)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images2H.push(image)

      if(imageDimension.height == 1080*3 and imageDimension.width == 1920)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images3V.push(image)

      if(imageDimension.height == 1080 and imageDimension.width == 1920*3)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images3H.push(image)

      if(imageDimension.height == 1080*2 and imageDimension.width == 1920*2)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images4.push(image)

      if(imageDimension.height == 1080*3 and imageDimension.width == 1920*3)
        image = new Element('image', '../' + file, imageDimension.width, imageDimension.height)
        @images9.push(image)

  _sortVideo : () ->
    @movies = []
    movieFiles = fs.readdirSync(@movieDirectory)
    for file in movieFiles
      link = './video/' + file
      movie = new Element('video', link, 0, 0)
      @movies.push(movie)

window.Library = Library
