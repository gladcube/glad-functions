{match_} = require \../../lib/str.ls
{equal} = require \assert

module.exports = new class FlowAssertion
  match_: match_ =
    * (match_)->
        \foo
        |> match_ /fo/
        |> at 0
        |> equal _, \fo
    * (match_)->
        \foo
        |> match_ /bar/
        |> equal _, undefined
  match: match_
