# A way to interact with the Google Images API.
#
# imagen de <palabra>    - Busca una imagen en google images
# una animacion de <palabra>  - Igual que el anterior pero intenta que sea una animacion en gif  
# poner bigote <url>   - Le pone un bigote a la imagen de esa url.
# poner bigote <palabra> - Busca en google y le pone un bigote a lo que encuentra 

module.exports = (robot) ->
  robot.respond /(imagen|img)( de)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /una animacion de (.*)/i, (msg) ->
    imageMe msg, "animated #{msg.match[1]}", (url) ->
      msg.send url

  robot.respond /ponle bigote (.*)/i, (msg) ->
    imagery = msg.match[1]

    if imagery.match /^https?:\/\//i
      msg.send "#{mustachify}#{imagery}"
    else
      imageMe msg, imagery, (url) ->
        msg.send "#{mustachify}#{url}"

mustachify = "http://mustachify.me/?src="

imageMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData.results
      image  = msg.random images
      cb "#{image.unescapedUrl}#.png"

