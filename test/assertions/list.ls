{length: _length} = require \../../lib/list.ls
{match_} = require \../../lib/str.ls
{equal} = require \assert

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
