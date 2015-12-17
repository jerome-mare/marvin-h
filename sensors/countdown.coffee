HubotSensor = require('../sensor')

class CountDownSensor extends HubotSensor
  constructor: (@robot) ->
    super(60 * 1000, false)
    @_init()

  check: () ->
    --@minutes
    @minutes == 0

  fire: () ->
    @notify "Countdown is over!"
    @_init()

  info: () ->
    return "A countdown sensor fired each #{@minutes} minutes"

  _init: () ->
    @minutes = 10

module.exports = CountDownSensor
