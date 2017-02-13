char = require "./character"
{CompositeDisposable} = require 'atom'

module.exports = AtomKanColle =

  activate: ->
    self = this
    # Notify me every hour
    @remaining_time = (60 - new Date().getMinutes()) * 60 * 1000
    @message = "Notify you after " + @remaining_time / (60 * 1000) + " minutes"

    setInterval ->
      self.notify()
    , @remaining_time


    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-kancolle:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  notify: ->
    atom.notifications.addSuccess(@message)
    date = new Date()
    now = date.getHours()
    src = @getSoundSrc(now)
    @playSound(src)
    console.log(now + " : " + src)

  getTime: (time) ->
    time = "0" + time if time < 10 # Check if the time is from 0 to 10
    time = time + "00"
    return time

  playSound: (src) ->
    audio = new Audio(src)
    audio.play()

  getSoundSrc: (hour) ->
    time = @getTime(hour) if hour.length isnt 4
    src = char["Yamato"]["notification"]["hour"]["voice"][time]
    return src

  getHourNotification: (hour) ->
    time = @getTime(hour) if hour.length isnt 4
    noti = char.Yamato.notification.hour.japanese[time]
    return noti

  toggle: ->
    @notify()
