describe "GenerateHtml", ->

  element = undefined
  generateHtml = undefined

  it "should be able to generate the html of an image", ->
    element = new Element('image', '', 0, 0)
    generateHtml = new GenerateHtml()
    htmlExpect = '<img src="" style="position:absolute; top:0px; left:0px;"/>'
    expect(generateHtml.getHtml(element, 0, 0)).toEqual(htmlExpect)

  it "should be able to generate the html of an image 100*100", ->
    element = new Element('image', '', 100, 100)
    generateHtml = new GenerateHtml()
    htmlExpect = '<img src="" style="position:absolute; top:0px; left:0px;"/>'
    expect(generateHtml.getHtml(element, 0, 0)).toEqual(htmlExpect)

  it "should be able to generate the html of an image 100*100 in random position", ->
    element = new Element('image', '', 100, 100)
    generateHtml = new GenerateHtml()

    htmlExpect = '<img src="" style="position:absolute; top:1200px; left:400px;"/>'
    expect(generateHtml.getHtml(element, 12, 4)).toEqual(htmlExpect)

  it "should be able to generate the html of a video", ->
    element = new Element('video', 'link', 0, 0)
    generateHtml = new GenerateHtml()
    htmlExpect = '<video id="video" autoplay src="link"></video>'
    expect(generateHtml.getHtml(element, 0, 0)).toEqual(htmlExpect)
