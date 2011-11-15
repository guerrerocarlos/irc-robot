# Inspect the data in redis easily
#
#

Sys = require "sys"

module.exports = (robot) ->
  robot.respond /almacenamiento$/i, (msg) ->
    output = Sys.inspect(robot.brain.data, false, 4)
    msg.send output

  robot.respond /show users$/i, (msg) ->
    response = ""

    for own key, user of robot.brain.data.users
      response += "#{user.id} #{user.name}"
      response += " <#{user.email_address}>" if user.email_address
      response += "\n"

    msg.send response
