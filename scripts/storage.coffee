# Inspect the data in redis easily
#
# a quienes conoces - da la lista de los usuarios de los que sabe algo 
# almacenamiento - muestra el contenido de la informacion en la base de datos Redis 
#

Sys = require "sys"

module.exports = (robot) ->
  robot.respond /show storage$/i, (msg) ->
    output = Sys.inspect(robot.brain.data, false, 4)
    msg.send output

  robot.respond /show users$/i, (msg) ->
    response = ""

    for own key, user of robot.brain.data.users
      response += "#{user.id} #{user.name}"
      response += " <#{user.email_address}>" if user.email_address
      response += "\n"

    msg.send response
