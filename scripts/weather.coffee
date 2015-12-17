# Description:
#   Tells the weather
#
# Configuration:
#   HUBOT_WEATHER_API_URL - Optional openweathermap.org API endpoint to use
#   HUBOT_WEATHER_UNITS - Temperature units to use. 'metric' or 'imperial'
#
# Commands:
#   weather in <location> - Tells about the weather in given location
#
# Author:
#   spajus

process.env.HUBOT_WEATHER_API_URL ||=
  'http://api.openweathermap.org/data/2.5/weather'
process.env.HUBOT_WEATHER_UNITS ||= 'metric'

module.exports = (robot) ->
  robot.hear /meteo a (\w+)/i, (msg) ->
    city = msg.match[1]
    query = { units: process.env.HUBOT_WEATHER_UNITS, q: city, lang:'fr', APPID: 'e0c7fc36e50292f9b00704bd4eede937' }
    url = process.env.HUBOT_WEATHER_API_URL
    msg.robot.http(url).query(query).get() (err, res, body) ->
      data = JSON.parse(body)
      weather = [ "#{Math.round(data.main.temp)}°C" ]
      for w in data.weather
        weather.push w.description
       msg.reply "Il fait #{weather.join(', ')} à #{data.name}, #{data.sys.country}"
