{act} = require \../../src/flow.ls
{get: _get, let: _let} = require \../../src/obj.ls
{equal, deep-equal} = require \assert

module.exports = new class ObjAssertion
  let_: let_ = (let_)->
    (let_ (plus_5: ( + 5)), \plus_5, 10) `equal` 15
  let: let_
  get: get = (get)->
    (get \foo, (foo: \bar)) `equal` \bar
  set: set = (set)->
    {}
    |> act set \name, \tarou
    |> _get \name
    |> equal _, \tarou
  delete_: delete_ =
    * (delete_)->
        (foo: \bar)
        |> act delete_ \foo
        |> deep-equal _, {}
  delete: delete_
  set_$: set_$ = (set_$)->
    { foo: 4, bar: 5 }
    |> act set_$ \bar, (+ 8)
    |> deep-equal _, { foo: 4, bar: 13 }
  merge: merge = (merge)->
    { foo: 4, bar: 5 }
    |> merge { foo: 8, lorem: 13 }
    |> deep-equal _, { foo: 8, bar: 5, lorem: 13 }
  call: call = (call)->
    (call \plus_w, 3, 8, (plus_w: ( + ) >> ( * 2 ))) `equal` 22
  new_: new_ = (new_)->
    (class A
      (num) ->
        @x = num
      property: 1
      method: (y) ->
        @x + @property + y)
    |> new_ _, 100
    |> _let _, \method, 32
    |> equal _, 133
  new: new_
