# Description:
#   Prints out this month's ASCII calendar.
#
# Commands:
#   hubot calendar [me] - Print out this month's calendar

child_process = require('child_process')
module.exports = (robot) ->
  robot.respond /calendar( me)?/i, (res) ->
    child_process.exec 'cal -h', (error, stdout, stderr) ->
      res.send(stdout)
