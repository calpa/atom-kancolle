char = require "./character"

module.exports = AtomKanColle =

  activate: (state) ->
    @notify()

  remains: (nextHour)->
    if nextHour == undefined
      nextHour = new Date().getMinutes()

    remaining_time = 60 - nextHour

    if nextHour is 0
      @notify()
      return 0
    else
      setTimeout(@notify(), remaining_time * 60 * 1000)
      return remaining_time

  deactivate: ->

  notify: ->
    date = new Date()

    @message = @getHourNotification(date.getHours())
    atom.notifications.addSuccess(@message)

    @playSound(date.getHours())

  getTime: (time) ->
    if time < 10
      time = "0" + time # Check if the time is from 0 to 10
    time = time + "00"
    return time

  playSound: (time) ->
    time = @getTime(time)
    src = @getSoundSrc(time)
    audio = new Audio(src)
    audio.play()
    return src

  getSoundSrc: (hour) ->
    return char["Yamato"]["notification"]["hour"]["voice"][hour]

  getHourNotification: (hour) ->
    time = @getTime(hour) if hour.length isnt 4
    noti = char.Yamato.notification.hour.japanese[time]
    return noti
