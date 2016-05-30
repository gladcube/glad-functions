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
