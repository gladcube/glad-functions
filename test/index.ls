{catch_} = require \../src/control.ls
{$} = require \../src/func.ls
require! <[fs colors]>
{reject, each, obj-to-pairs, is-type, camelize, capitalize} = require \prelude-ls

do main = ->
  err, files <- fs.readdir "#__dirname/../src"
  files
  |> reject ( is \index.ls)
  |> each (file)->
    (require "#__dirname/../src/#file")
    |> obj-to-pairs
    |> each ([key, func])->
      run "#{module_name file}.#key", (require "#__dirname/assertions/#file").(key), func

run = (name, assertions, func)->
  | not assertions? =>
    console.warn "[Warning] #name does not have assertions.".yellow
  | assertions |> is-type \Array |> (not) =>
    run name, [assertions], func
  | _ =>
    (->
      assertions
      |> each $ _, func
      |> ( .length)
      |> -> console.log "#name ok. (#it/#it)".green
    ) `catch_` ->
      console.error "#name failed. (#{it.message})".red

module_name = ( .match /(\w+)\.ls/) >> ( .1) >> camelize >> capitalize
