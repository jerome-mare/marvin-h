# Description:
#   Donne la meteo
#
# Configuration:
#   HUBOT_WEATHER_API_URL - Optionnel openweathermap.org API endpoint
#   HUBOT_WEATHER_UNITS - Unite de Temperature a utiliser. 'metric' or 'imperial'
#
# Commandes:
#   meteo a <location> - Donne la meteo a l'endroit passe en parametre
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
