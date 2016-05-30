{equal} = require \assert

module.exports = new class FuncAssertion
  $: $ = ($)->
    (( + 5) `$` 5) `equal` 10
  lazy: lazy = (lazy)->
    lazy (+), 5, 5 |> (do) |> equal _, 10

