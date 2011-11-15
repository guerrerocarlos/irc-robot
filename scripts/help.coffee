# Generates help commands for Hubot.
#
# These commands are grabbed from comment blocks at the top of each file.
#
# ayuda - muestra esta lista de opciones posibles

module.exports = (robot) ->
  robot.respond /ayuda$/i, (msg) ->
    msg.send robot.helpCommands().join("\n")

