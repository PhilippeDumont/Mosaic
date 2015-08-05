describe "Library", ->

  library = undefined

  it "should be able to generate the tab images1", ->
    library = new Library('../images', '../video')
    expect(library.images1.length).toEqual(1)

  it "should be able to generate the tab images2V", ->
    library = new Library('../images', '../video')
    expect(library.images2V.length).toEqual(1)

  it "should be able to generate the tab images2H", ->
    library = new Library('../images', '../video')
    expect(library.images2H.length).toEqual(1)

  it "should be able to generate the tab images3V", ->
    library = new Library('../images', '../video')
    expect(library.images3V.length).toEqual(1)

  it "should be able to generate the tab images3H", ->
    library = new Library('../images', '../video')
    expect(library.images3H.length).toEqual(1)

  it "should be able to generate the tab images4", ->
    library = new Library('../images', '../video')
    expect(library.images4.length).toEqual(1)

  it "should be able to generate the tab images9", ->
    library = new Library('../images', '../video')
    expect(library.images9.length).toEqual(1)
