{may} = require \./option.ls

module.exports = new class List
  find_map: find_map = (f, xs)-->
    find f, xs |> may f
  filter_map: filter_map = (f, xs)-->
    filter f, xs |> map f
