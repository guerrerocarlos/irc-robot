# Allows Hubot to do mathematics.
#
# cuanto da <ecuacion> - Resultado matematico de ecuacion 
# convierte de <tanto> a <tantootro> - Convierte de una unidad a otra 
module.exports = (robot) ->
  robot.respond /(cuanto|calculame|convierte|convierteme)( de| me| da| es|cuanto da|cuanto es)? (.*)/i, (msg) ->
    msg
      .http('http://www.google.com/ig/calculator')
      .query
        hl: 'en'
        q: msg.match[3]
      .headers
        'Accept-Language': 'en-us,en;q=0.5',
        'Accept-Charset': 'utf-8',
        'User-Agent': "Mozilla/5.0 (X11; Linux x86_64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"
      .get() (err, res, body) ->
        # Response includes non-string keys, so we can't use JSON.parse here.
        json = eval("(#{body})")
        msg.send json.rhs || 'Could not compute.'
