{act} = require \../../lib/flow.ls
{get: _get} = require \../../lib/obj.ls
{equal} = require \assert

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
