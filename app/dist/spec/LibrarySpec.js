// Generated by CoffeeScript 1.9.3
(function() {
  describe("Library", function() {
    var library;
    library = void 0;
    it("should be able to generate the tab images1", function() {
      library = new Library('../images', '../video');
      return expect(library.images1.length).toEqual(1);
    });
    it("should be able to generate the tab images2V", function() {
      library = new Library('../images', '../video');
      return expect(library.images2V.length).toEqual(1);
    });
    it("should be able to generate the tab images2H", function() {
      library = new Library('../images', '../video');
      return expect(library.images2H.length).toEqual(1);
    });
    it("should be able to generate the tab images3V", function() {
      library = new Library('../images', '../video');
      return expect(library.images3V.length).toEqual(1);
    });
    it("should be able to generate the tab images3H", function() {
      library = new Library('../images', '../video');
      return expect(library.images3H.length).toEqual(1);
    });
    it("should be able to generate the tab images4", function() {
      library = new Library('../images', '../video');
      return expect(library.images4.length).toEqual(1);
    });
    return it("should be able to generate the tab images9", function() {
      library = new Library('../images', '../video');
      return expect(library.images9.length).toEqual(1);
    });
  });

}).call(this);
