{return_} = require \./applicative.ls

module.exports = new class Flow
  act: act = (f, x)-->
    f x |> return_ x
  if_: if_ = (x, f, y)-->
    if x => f y
  if: if_
  unless_: unless_ = (x, f, y)-->
    unless x => f y
  unless: unless_
  when_: when_ = (f, g, x)-->
    if f x => g x
  when: when_
  except: except = (f, g, x)-->
    unless f x => g x
  then_: then_ = (f, x)-->
    if x => f x
  then: then_
  else_: else_ = (f, x)-->
    unless x => f x
  else: else_
  [case_, otherwise_] = do ->
    $ = {}
    [
      (f, g, x)-->
        | x is $ => $
        | f x => g x |> return_ $
        | _ => x
    , (f, x)-->
        | x isnt $ => f x
    ]
  case_: case_
  case: case_
  otherwise_: otherwise_
  otherwise: otherwise_
  case$: case$ = act . when_
  let_: let_ = (k, ...a)->
    (x)->
      x.(k).apply x, a |> return_ x
  let: let_
