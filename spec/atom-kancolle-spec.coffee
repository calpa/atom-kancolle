char = require "../lib/character"
kancolle = require "../lib/atom-kancolle"

describe "Kancolle", ->
  time = Math.floor(Math.random() * 10 + 1)

  now = char.Yamato.notification.hour
  hour = new Date().getHours()
  voice = now.voice

  it "should store time", ->
    console.log kancolle

  it "can get Time", ->
    expect(kancolle.getTime(0)).toBe "0000"

  it "can read the kancolle of the character yamato", ->
    expect(kancolle.getHourNotification(1)).toBe now.japanese["0100"]

  it "can get the noti src", ->
    expect(kancolle.getSoundSrc(hour)).not.toBe undefined

  it "can play sound", ->
    res = kancolle.getTime(time)
    expect(kancolle.playSound(voice[res])).not.toBe undefined

  it "should notify me", ->
    expect(kancolle.notify).not.toBe undefined
