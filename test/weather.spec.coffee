Helper = require('hubot-test-helper')
# helper loads all scripts passed a directory

# helper loads a specific script if it's a file
helper = new Helper('../scripts/weather.coffee')

co     = require('co')
expect = require('chai').expect
nock   = require('nock')

process.env.EXPRESS_PORT = 9090

describe 'hello-world', ->

  beforeEach ->
    @room = helper.createRoom()
    @myresponse =
      name: 'Toulouse'
      sys:
        country: 'fr'
      main:
        temp: 10
      weather: [
        {
          description: 'nuageux'
        }
      ]
    nock('http://api.openweathermap.org')
      .get('/data/2.5/weather')
    .query(true)
    .reply(200, @myresponse);

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  context 'user asks meteo in Toulouse to hubot', ->
    beforeEach (done) ->
      @room.user.say 'toto', 'meteo a toulouse'
      setTimeout done, 100

    it 'should reply to user', ->
      expect(@room.messages).to.eql [
        ['toto', 'meteo a toulouse']
        ['hubot', '@toto Il fait 10°C, nuageux à Toulouse, fr']
      ]
