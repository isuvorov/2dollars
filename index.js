(function() {
  var $$;

  $$ = {};

  /*
    Массовая замена в строке
    key => val
  */

  $$.strtr = function(str, replacePairs) {
    var key, regexp, val;
    for (key in replacePairs) {
      val = replacePairs[key];
      regexp = new RegExp(key, 'g');
      str = str.replace(regexp, val);
    }
    return str;
  };

  $$.base64UrlDic = {
    '\\+': '-',
    '/': '_',
    '=': ','
  };

  $$.base64UrlRevDic = {
    '-': '+',
    '_': '/',
    ',': '='
  };

  $$.base64UrlEncode = function(input) {
    return $$.strtr(input, $$.base64UrlDic);
  };

  $$.base64UrlDecode = function(input) {
    return $$.strtr(input, $$.base64UrlRevDic);
  };

  /*
    Mongo Express-like ORM function
  */

  $$.findCreateUpdate = function(model, data, next) {
    return model.findOne(data.id, function(err, object) {
      var key, val;
      if (err) return next(err);
      if (!object) {
        return model.create(data, next);
      } else {
        for (key in data) {
          val = data[key];
          object[key] = val;
        }
        return object.save(next);
      }
    });
  };

  module.exports = $$;

}).call(this);
