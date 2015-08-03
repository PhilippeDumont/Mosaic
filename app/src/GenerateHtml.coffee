class GenerateHtml

  _getHtmlOfImage : (element, x, y) ->
    html = '<img src="'
    html += element.link
    html += '" style="position:absolute; top:'
    html += x * element.height
    html += 'px; left:'
    html += y * element.width
    html += 'px;"/>'
    return html

  _getHtmlOfVideo : (element, x, y) ->
    html = '<video id="video" autoplay src="'
    html += element.link
    html += '"></video>'
    return html

  getHtml : (element, x, y) ->
    #<image style="position:absolute; top:0px; left:0px;" src="images/test.jpg">
    html = ''
    if element.type == 'image'
      @_getHtmlOfImage(element, x, y)
    else if element.type == 'video'
     @_getHtmlOfVideo(element, x, y)

window.GenerateHtml = GenerateHtml
