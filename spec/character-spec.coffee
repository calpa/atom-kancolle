char = require "../lib/character"

describe "Character", ->
  yamato = char.Yamato
  it "should be loaded", ->
    expect(char).not.toBe undefined
  describe "Yamato", ->
    it "should have 24 notifications", ->
      hour = yamato.notification.hour
      japanese = Object.keys(hour.japanese).length # Get the length of jp
      chinese = Object.keys(hour.chinese).length
      expect(japanese).toEqual 24
      expect(chinese).toEqual 24
