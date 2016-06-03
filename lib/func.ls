module.exports = new class Func
  $: $ = (f, x)-->
    f x
  lazy: lazy = (x, ...y)->
    -> apply x, y
  dist: dist = (x, fs)-->
    map (x |>), fs
  arg: arg = (n)-> -> &.(n)
  args: args = -> & |> map id
  withl: withl = (f, x)-->
    dist x, [f, id]
  withr: withr = (f, x)-->
    dist x, [id, f]
  $_at: $_at = (n, f, xs)-->
    xs
    |> split-at n
    |> $_zip [id, dist _, [((take 1) >> map f), tail]]
    |> $_zip [id, concat]
    |> concat
  $_zip: $_zip = zip-with $

