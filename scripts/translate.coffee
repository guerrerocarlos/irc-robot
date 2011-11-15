# Allows Hubot to know many languages.
#
# traduce <frase> - traduce esa frase y la escribe en un idioma entendible 
#
# traduce de <idioma1> a <idioma2> <frase> - Traduce la frase de idioma1 a idioma2.
#

languages =
  "af":"Afrikaans",
  "sq":"Albanian",
  "ar":"Arabic",
  "be":"Belarusian",
  "bg":"Bulgarian",
  "ca":"Catalan",
  "zh-CN":"Simplified Chinese",
  "zh-TW":"Traditional Chinese",
  "hr":"Croatian",
  "cs":"Czech",
  "da":"Danish",
  "nl":"Dutch",
  "en":"English",
  "et":"Estonian",
  "tl":"Filipino",
  "fi":"Finnish",
  "fr":"French",
  "gl":"Galician",
  "de":"German",
  "el":"Greek",
  "iw":"Hebrew",
  "hi":"Hindi",
  "hu":"Hungarian",
  "is":"Icelandic",
  "id":"Indonesian",
  "ga":"Irish",
  "it":"Italian",
  "ja":"Japanese",
  "ko":"Korean",
  "lv":"Latvian",
  "lt":"Lithuanian",
  "mk":"Macedonian",
  "ms":"Malay",
  "mt":"Maltese",
  "no":"Norwegian",
  "fa":"Persian",
  "pl":"Polish",
  "pt":"Portuguese",
  "ro":"Romanian",
  "ru":"Russian",
  "sr":"Serbian",
  "sk":"Slovak",
  "sl":"Slovenian",
  "es":"Spanish",
  "sw":"Swahili",
  "sv":"Swedish",
  "th":"Thai",
  "tr":"Turkish",
  "uk":"Ukranian",
  "vi":"Vietnamese",
  "cy":"Welsh",
  "yi":"Yiddish"
  
getCode = (language,languages) ->
  for code, lang of languages
      return code if lang.toLowerCase() is language.toLowerCase()

module.exports = (robot) ->
  robot.respond /(?:traduce)(?: me)?(?:(?: de) ([a-z]*))?(?:(?: (?:a)?para) ([a-z]*))? (.*)/i, (msg) ->
    term   = "\"#{msg.match[3]}\""
    origin = if msg.match[1] isnt undefined then getCode(msg.match[1], languages) else 'auto'
    target = if msg.match[2] isnt undefined then getCode(msg.match[2], languages) else 'es'
    
    msg.http("http://translate.google.com/translate_a/t")
      .query({
        client: 't'
        hl: 'en'
        multires: 1
        sc: 1
        sl: origin
        ssel: 0
        tl: target
        tsel: 0
        uptl: "en"
        text: term
      })
      .get() (err, res, body) ->
        data   = body
        if data.length > 4 && data[0] == '['
          parsed = eval(data)
          language =languages[parsed[2]]
          parsed = parsed[0] && parsed[0][0] && parsed[0][0][0]
          if parsed
            if msg.match[2] is undefined
              msg.send "#{term} es #{language} para #{parsed}"
            else
              msg.send "En #{language} #{term} traduce como #{parsed} en #{languages[target]}"

