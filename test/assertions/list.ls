{length: _length} = require \../../src/list.ls
{match_} = require \../../src/str.ls
{args} = require \../../src/func.ls
{equal, deep-equal} = require \assert
{at, join} = require \prelude-ls

module.exports = new class FlowAssertion
  find_map: find_map =
    * (find_map)->
        <[foo bar]>
        |> find_map match_ /oo/
        |> at 0
        |> equal _, \oo
    * (find_map)->
        <[foo bar]>
        |> find_map match_ /hoge/
        |> equal _, undefined
  filter_map: filter_map =
    * (filter_map)->
        <[foo bar]>
        |> filter_map match_ /oo/
        |> (at 0) >> at 0
        |> equal _, \oo
    * (filter_map)->
        <[foo bar]>
        |> filter_map match_ /hoge/
        |> _length
        |> equal _, 0
  length: length = (length)->
    [1 to 3] |> length |> equal _, 3
  pick: pick =
    (pick)->
      [1 to 40] |> pick [4, 23, 13, 5, 1] |> deep-equal _, [ 5, 24, 14, 6, 2 ]
    (pick)->
      some_function = (cb)->
        cb \err, \data, \other_data
      some_function (args >> (pick [2, 1]) >> join " ")
      |> equal _, "other_data data"
  list: list = (list)->
    list 1, 2, 3, 4 |> deep-equal _, [1, 2, 3, 4]
  range: range = (range)->
    range 4, 100 |> deep-equal _, [4 til 100]
  none: none =
    (none)->
      <[foo bar foobar]> |> none (match_ /^foo/) |> equal _, false
    (none)->
      <[foo bar foobar]> |> none (match_ /^lorem/) |> equal _, true
    (none)->
      [] |> none (match_ /^lorem/) |> equal _, true
