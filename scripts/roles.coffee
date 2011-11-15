# Assign roles to people you're chatting with
#
# <usuario> es un gran gitarrista - asigna ese rol a ese usuario 
# <usuario> no es un gran gitarrista - le quita ese rol a ese usuario
# quien es <usuario> - dice cual es el rol de ese usuario 

# hubot holman is an ego surfer
# hubot holman is not an ego surfer
#

module.exports = (robot) ->
  robot.respond /quien es ([\w .-]+)\?*$/i, (msg) ->
    name = msg.match[1]

    if name is "tu"
      msg.send "Soy un robot, programado por Carlos Guerrero."
    else if name is robot.name
      msg.send "El mejor."
    else if user = robot.userForName name
      user.roles = user.roles or [ ]
      if user.roles.length > 0
        msg.send "#{name} is #{user.roles.join(", ")}."
      else
        msg.send "#{name} ni idea."
    else
      msg.send "#{name}? nunca lo habia escuchado."

  robot.respond /([\w .-]+) es (["'\w: ]+)[.!]*$/i, (msg) ->
    name    = msg.match[1]
    newRole = msg.match[2].trim()

    unless name in ['quien', 'que', 'donde', 'cuando', 'porque','por que']
      unless newRole.match(/^not\s+/i)
        if user = robot.userForName name
          user.roles = user.roles or [ ]

          if newRole in user.roles
            msg.send "Yo se"
          else
            user.roles.push(newRole)
            if name.toLowerCase() is robot.name
              msg.send "Bien, yo soy #{newRole}."
            else
              msg.send "Entendido, #{name} es #{newRole}."
        else
          msg.send "No se nada sobre #{name}."

  robot.respond /([\w .-]+) is not (["'\w: ]+)[.!]*$/i, (msg) ->
    name    = msg.match[1]
    newRole = msg.match[2].trim()

    unless name in ['quien', 'que', 'donde', 'cuando', 'por que','porque']
      if user = robot.userForName name
        user.roles = user.roles or [ ]

        if newRole not in user.roles
          msg.send "Yo se."
        else
          user.roles = (role for role in user.roles when role isnt newRole)
          msg.send "Entendido, #{name} ya no es #{newRole}."

      else
        msg.send "No se nada sobre #{name}."
