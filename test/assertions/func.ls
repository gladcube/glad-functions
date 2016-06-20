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
  $_head: $_head = ($_head)->
    [1, 2, 3]
    |> $_head (* 10)
    |> deep-equal _, [10, 2, 3]
  $_last: $_last = ($_last)->
    [1, 2, 3]
    |> $_last (* 10)
    |> deep-equal _, [1, 2, 30]
  $_arg: $_arg = ($_arg)->
    (-)
    |> $_arg 1, (+ 5), _
    |> apply _, [10, 20]
    |> equal _, -15
  $_head_arg: $_head_arg = ($_head_arg)->
    (-)
    |> $_head_arg (+ 100), _
    |> apply _, [10, 20]
    |> equal _, 90
  $_last_arg: $_last_arg = ($_last_arg)->
    (-)
    |> $_last_arg  (+ 100), _
    |> apply _, [10, 20]
    |> equal _, -110
  $_args: $_args = ($_args)->
    (-)
    |> $_args (+ 5), _
    |> apply _, [10, 20]
    |> equal _, -10
  $$_args: $$_args = ($$_args)->
    (*)
    |> $$_args [(+ 100), (+ 5)], _
    |> apply _, [10, 20]
    |> equal _, 2750
  $_when: $_when = ($_when)->
    [10, 20, 30]
    |> $_when (> 20), (* 30)
    |> deep-equal _, [ 10, 20, 900 ]
  $_pairs: $_pairs = ($_pairs)->
    { ks : 10 , ms : 2 }
    |> $_pairs  map map (+ \5)
    |> deep-equal _, { ks5: '105', ms5: '25' }
  $_key: $_key = ($_key)->
    { ks : 10 , ms : 2}
    |> $_key \ms  (+ 5)
    |> deep-equal _, { ks: 10, ms: 7 }
  need: need = (need)->
    (+)
    |> need 3
    |> apply _, [10]
    |> apply _, [4]
    |> apply _, [9]
    |> equal _, 14
