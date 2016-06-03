require("livescript")
import$(global, require("prelude-ls"))
module.exports = require("./lib/index.ls")

function import$(obj, src){
  for(var key in src) obj[key] = src[key];
  return obj;
}


