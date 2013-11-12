#
# Simple utility to convert between (row, column) and (characterOffset) in a text file
#
# parseText(textfile) creates an array of character offsets to start-or-ine for each row (starting at ZERO)
# getOffset(row, column) returns the character offset of (row, column) in (textfile)
# getRowFromOffset(offset) returns the row (starting at ZERO) of the file which has that offset in.
#   It is implemented as a binary search through the pre-parsed array of character offsets
#
# David Golds (@dgolds) November 2013

module.exports = utils =
  OffsetConverter: class OffsetConverter
    parseText: (text) =>
      @offsetArray = [0]
      offset = 0
      endofline = false
      length = text.length
      # Windows uses \r\n to signify there is a new line starting,
      #  while Linux and Unix use \n to signify that the new line is starting.
      #  Thus we will ignore \r and just count \n as the delimiter
      while (offset < length)
        if endofline
          @offsetArray.push(offset)
          endofline = false
        if (text[offset] is '\n')
          endofline = true
        offset++

    getRowCount: =>
      @offsetArray.length

    getOffset: (row, column = 0) =>
      @offsetArray[row] + column

    getRowFromOffset: (offset) =>
      alen = @offsetArray.length
      return 0 if (offset <= 0 or alen <= 0)                # First Row
      return alen-1 if (offset >= @offsetArray[alen - 1])   # Final Row
      lo_r = 0
      hi_r = alen - 1
      while (lo_r < hi_r)
        mid_r = ~~((hi_r + lo_r) / 2)                    # ~~ is a faster, better Math.floor()
        return mid_r if (offset >= @offsetArray[mid_r] and offset < @offsetArray[mid_r + 1])
        if offset < @offsetArray[mid_r] then hi_r = mid_r else lo_r = mid_r
      return -1     # SHOULD NEVER REACH HERE

