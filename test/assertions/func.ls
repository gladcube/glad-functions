{length} = require \../../lib/list.ls
{deep-equal, equal} = require \assert

module.exports = new class FuncAssertion
  $: $ = ($)->
    (( + 5) `$` 5) `equal` 10
  $$: $$ = ($$)->
    5 |> $$ [(+ 4), (* 4)] |> deep-equal _, [9, 20]
  lazy: lazy = (lazy)->
    lazy (+), 5, 5 |> (do) |> equal _, 10
  dist: dist = (dist)->
    dist 5, [(+ 4), (* 4)] |> deep-equal _, [9, 20]
  arg: arg = (arg)->
    (arg 1) 1, 2, 3 |> equal _, 2
  args: args = (args)->
    args 1, 2, 3, 4 |> deep-equal _, [1, 2, 3, 4]
  withl: withl = (withl)->
    5
    |> withl (+ 10)
    |> deep-equal _, [15, 5]
  withr: withr = (withr)->
    5
    |> withr (+ 10)
    |> deep-equal _, [5, 15]
  $_at: $_at = ($_at)->
    [1, 2, 3]
    |> $_at 2, (* 10)
    |> deep-equal _, [1, 2, 30]
  $_zip: $_zip = ($_zip)->
    [1, 2, 3]
    |> $_zip [(* 10), (- 2), (+ 7)]
    |> deep-equal _, [10, 0, 10]

