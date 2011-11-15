# Pugme is the most important thing in your life
#
# cachorrito para mi - Te da un cachorrito 
# bomba de cachorritos N - Te da N cachorritos 

module.exports = (robot) ->

  robot.respond /cachorrito para mi/i, (msg) ->
    msg.http("http://pugme.herokuapp.com/random")
      .get() (err, res, body) ->
        msg.send JSON.parse(body).pug

  robot.respond /bomba de cachorritos ( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    msg.http("http://pugme.herokuapp.com/bomb?count=" + count)
      .get() (err, res, body) ->
        msg.send pug for pug in JSON.parse(body).pugs

  robot.respond /cuantos cachorritos hay alli/i, (msg) ->
    msg.http("http://pugme.herokuapp.com/count")
      .get() (err, res, body) ->
        msg.send "There are #{JSON.parse(body).pug_count} pugs."


