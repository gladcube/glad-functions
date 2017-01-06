require! <[fs livescript]>
require! \prelude-ls : {filter, each, map, replicate, pairs-to-obj, obj-to-pairs, Obj}

fs.readdir-sync "#__dirname/../src"
|> filter (is /\.ls$/)
|> map (- /\.ls$/) >> (replicate 2)
|> pairs-to-obj
|> Obj.map ("#__dirname/../src/" +) >> (+ ".ls") >> fs.read-file-sync >> (.to-string!) >> livescript.compile
|> obj-to-pairs
|> each ([name, js])->
  console.info "src/#name.ls -> lib/#name.js"
  fs.write-file-sync "#__dirname/../lib/#name.js", js

