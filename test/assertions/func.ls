{length} = require \../../src/list.ls
{act} = require \../../src/flow.ls
{deep-equal, equal, throws} = require \assert
{map, apply, filter, head} = require \prelude-ls

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
    $_arg 1, (+ 5), (-)
    |> apply _, [10, 20]
    |> equal _, -15
  $_head_arg: $_head_arg = ($_head_arg)->
    $_head_arg (+ 100), (-)
    |> apply _, [10, 20]
    |> equal _, 90
  $_last_arg: $_last_arg = ($_last_arg)->
    $_last_arg  (+ 100), (-)
    |> apply _, [10, 20]
    |> equal _, -110
  $_args: $_args = ($_args)->
    $_args (+ 5), (*)
    |> apply _, [10, 20]
    |> equal _, 375
  $$_args: $$_args = ($$_args)->
    $$_args [(+ 100), (+ 5)], (*)
    |> apply _, [10, 20]
    |> equal _, 2750
  $_when: $_when = ($_when)->
    [10, 20, 30]
    |> $_when (> 20), (* 30)
    |> deep-equal _, [ 10, 20, 900 ]
  $_pairs: $_pairs =
    ($_pairs)->
      { ks : 10 , ms : 2 }
      |> $_pairs  map map (+ \5)
      |> deep-equal _, { ks5: '105', ms5: '25' }
    ($_pairs)->
      { ks : 10, ms : 2, mm : 5, kg : 7 }
      |> $_pairs filter head >> (in <[ks kg]>)
      |> deep-equal _, { ks: 10, kg: 7 }
  $_key: $_key =
    ($_key)->
      { ks : 10, ms : 2 }
      |> $_key \ms  (+ 5)
      |> deep-equal _, { ks: 10, ms: 7 }
  $_find: $_find =
    ($_find)->
      <[foo bar foobar bar foo lorem ]>
      |> $_find (is \bar), ( + \barbar)
      |> deep-equal _, [ 'foo', 'barbarbar', 'foobar', 'bar', 'foo', 'lorem' ]
  $_filter: $_filter = ($_filter)->
    [10, 20, 30]
    |> $_filter (> 10), (* 30)
    |> deep-equal _, [ 10, 600, 900 ]
  $_any: $_any = ($_any)->
    [{age: 28, job: \engineer}, {age: 35, job: \designer}]
    |> filter $_any [(.age > 30), (.job is \engineer)]
    |> deep-equal _, [{age: 28, job: \engineer}, {age: 35, job: \designer}]
  $_all: $_all = ($_all)->
    [{age: 28, job: \engineer}, {age: 35, job: \designer}]
    |> filter $_all [(.age < 30), (.job is \engineer)]
    |> deep-equal _, [{age: 28, job: \engineer}]
  need: need =
    (need)->
      a = (x, y)--> x + y + 5
      b = (x) --> x * 100
      c = a >> b
      throws ->
        c 5 |> (4|>)
    (need)->
      a = (x, y)--> x + y + 5
      b = (x) --> x * 100
      d = need 2, a >> b
      d 5 |> (4|>) |> equal _, 1400
    (need)->
      a = (x, y, z)--> x * 100 + y + 5 + z
      b = (x) --> x + 6
      e = need 3, a >> b
      e 5 ,4 ,7 |> equal _, 522
    (need)->
      (+)
      |> need 3 |> (10|>) |> (4|>) |> (10|>)
      |> equal _, 14
