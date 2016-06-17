{get} = require \./obj.ls
{may} = require \./option.ls

module.exports = new class List
  find_map: find_map = (f, xs)-->
    find f, xs |> may f
  filter_map: filter_map = (f, xs)-->
    filter f, xs |> map f
  length: length = get \length
  pick: pick = (ns, xs)-->
    map (xs |>), (map at, ns)
  list: list = -> & |> map id
  range: range = (x, y)-->
    [x til y]
