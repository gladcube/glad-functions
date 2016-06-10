module.exports = new class Obj
  let_: let_ = (x, k, ...a)->
    x.(k).apply x, a
  let: let_
  get: get = (k, x)-->
    x.(k)
  set: set = (k, v, x)-->
    x.(k) = v
  set_$: set_$ = (f, k, o)-->
    set k, (f get k, o), o
  delete_: delete_ = (k, x)-->
    delete x.(k)
  delete: delete_
  new_: new_ = (c, ...as)->
    new (c.bind.apply c, [c] ++ as)
  new: new_
  merge: merge = (o, s)-->
    [s, o]
    |> map obj-to-pairs
    |> concat
    |> pairs-to-obj

