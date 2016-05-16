module.exports = new class Obj
  let_: let_ = (x, k, ...a)->
    x.(k).apply x, a
  let: let_
  get: get = (k, x)-->
    x.(k)
  set: set = (k, v, x)-->
    x.(k) = v
