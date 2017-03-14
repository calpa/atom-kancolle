char = require "./character"
moment = require "moment-timezone"

module.exports = AtomKanColle =
  config:
    inJapan:
      title: 'Use the time in Japan?'
      type: 'boolean'
      default: true
    character:
      title: 'Your waifu?'
      type: 'string'
      default: 'Yamato'
      enum: ['Yamato']

  activate: (state) ->
    @notify()

  deactivate: ->

  notify: ->
    currentHour = moment().hour()
    currentHour += 1 if atom.config.get("atom-kancolle.inJapan") is true

    @message = @getHourNotification(currentHour)
    atom.notifications.addSuccess(@message)

    @playSound(currentHour)

  remains: (nextHour)->
    if nextHour == undefined
      nextHour = moment().minute()

    remaining_time = 60 - nextHour

    if nextHour is 0
      @notify()
      return 0
    else
      setTimeout(@notify(), remaining_time * 60 * 1000)
      return remaining_time

  getTime: (time) ->
    if time < 10
      time = "0" + time # Check if the time is from 0 to 10
    return time + "00"

  playSound: (time) ->
    time = @getTime(time)
    src = @getSoundSrc(time)
    audio = new Audio(src)
    audio.play()
    return src

  getSoundSrc: (hour) ->
    character = atom.config.get('atom-kancolle.character')
    return char[character]["notification"]["hour"]["voice"][hour]

  getHourNotification: (hour) ->
    time = @getTime(hour) if hour.length isnt 4
    character = atom.config.get('atom-kancolle.character')
    noti = char[character]["notification"]["hour"]["japanese"][time]
    return noti
