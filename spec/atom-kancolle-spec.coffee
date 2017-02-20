char = require "../lib/character"
kancolle = require "../lib/atom-kancolle"
moment = require 'moment-timezone'

describe "Kancolle", ->
  time = Math.floor(Math.random() * 10 + 1)

  now = char.Yamato.notification.hour
  hour = moment().hour()
  voice = now.voice

  it "should store time", ->
    console.log kancolle

  it "can get Time", ->
    expect(kancolle.getTime(0)).toBe "0000"

  it "can read the kancolle of the character yamato", ->
    expect(kancolle.getHourNotification(1)).toBe now.japanese["0100"]

  it "can get the noti src", ->
    expect(kancolle.getSoundSrc("0000")).toBe voice["0000"]

  it "should notify me", ->
    expect(kancolle.notify).not.toBe undefined

  it "can calculate the remaining time", ->
    expect(kancolle.remains(59)).toBe 1
    expect(kancolle.remains(30)).toBe 30
    expect(kancolle.remains()).toBe 60 - new Date().getMinutes()
