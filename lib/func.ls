{when_} = require \./flow.ls
{length} = require \./list.ls
{C} = require \./combinator.ls

module.exports = new class Func
  $: $ = (f, x)-->
    f x
  $$: $$ = (fs, x)-->
    map (x |>), fs
  $_at: $_at = (n, f, xs)-->
    xs
    |> split-at n
    |> $_zip [id, dist _, [((take 1) >> map f), tail]]
    |> $_zip [id, concat]
    |> concat
  $_zip: $_zip = zip-with $
  $_head: $_head = $_at 0
  $_last: $_last = (f, xs)-->
    $_at ((length xs) - 1), f, xs
  $_arg: $_arg = (n, f, g)-->
    args >> ($_at n, f) >> apply g
  $_head_arg: $_head_arg = (f, g)-->
    args >> ($_head f) >> apply g
  $_last_arg: $_last_arg = (f, g)-->
    args >> ($_last f) >> apply g
  $_args: $_args = (f, g)-->
    args >> (map f) >> apply g
  $$_args: $$_args = (fs, g)-->
    args >> ($_zip fs) >> apply g
  $_when: $_when = (f, g, xs)-->
    map (when_ f, g), xs
  $_pairs: $_pairs = (f, o)-->
    o
    |> obj-to-pairs
    |> f
    |> pairs-to-obj
  $_key: $_key = (k, f, o)-->
    $_pairs (
      $_when (at 0) >> (is k), ($_at 1, f)
    ), o
  lazy: lazy = (x, ...y)->
    -> apply x, y
  dist: dist = C $$
  arg: arg = (n)-> -> &.(n)
  args: args = -> & |> map id
  withl: withl = (f, x)-->
    dist x, [f, id]
  withr: withr = (f, x)-->
    dist x, [id, f]
  need: need = (n, f)-->
    g = (as)->
      ->
        as
        |> C (++), (& |> map id)
        |> (as)->
          | (length as) >= n => apply f, as
          | _ => g as
    return g []
