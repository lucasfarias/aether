Aether = require '../aether'

describe "Utils test suite", ->
  describe "Offset Conversion Utility", ->
    code1 = """
        function fib(n) {
          return n < 2 ? n : fib(n - 1) + fib(n - 2);
        var chupacabra = fib(5)
        //console.log("I want", chupacabra, "gold.");
        return chupacabra;
      """
    aether = new Aether()
    utils = aether.utilityHelpers()

    it "should return the OffsetConverter Objects", ->
      expect(utils).toBeDefined()
      expect(utils.OffsetConverter).toBeDefined()

    it "should be able to parse a text file", ->
      oc = new utils.OffsetConverter()
      oc.parseText(code1)

    it "should correctly count number of lines", ->
      oc = new utils.OffsetConverter()
      oc.parseText(code1)
      expect(oc.getRowCount()).toBe(5)

    it "should correctly go from offset to row", ->
      oc = new utils.OffsetConverter()
      oc.parseText(code1)
      expect(oc.getRowFromOffset(15)).toBe(0)
      expect(oc.getRowFromOffset(30)).toBe(1)

