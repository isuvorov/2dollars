$$ = {}

###
  Массовая замена в строке
  key => val
###
$$.strtr = (str, replacePairs) ->
  for key, val of replacePairs
    regexp = new RegExp(key, 'g')
    str = str.replace(regexp, val)
  return str

$$.base64UrlDic =
  '\\+': '-'
  '/': '_'
  '=': ','
$$.base64UrlRevDic =
  '-': '+'
  '_': '/'
  ',': '='

$$.base64UrlEncode = (input) ->
  $$.strtr input, $$.base64UrlDic

$$.base64UrlDecode = (input) ->
  $$.strtr input, $$.base64UrlRevDic


###
  Mongo Express-like ORM function
###
$$.findCreateUpdate = (model, data, next) ->
  model.findOne data.id, (err, object)->
    return next err if err
    if !object
      model.create data, next
    else
      for key, val of data
        object[key] = val
      object.save next

$$.req = (req)->
  req.paramJson = (name, defaultValue) ->
    value = @.param name
    return defaultValue if !value
    try
      return JSON.parse(value)
    catch e
      return defaultValue

  req.paramJsonStr = (name, defaultValue) ->
    value = @.param name
    return defaultValue if !value
    try
      return JSON.parse(value)
    catch e
      return value

  return req
module.exports = $$