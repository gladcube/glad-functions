{return_} = require \./applicative

module.exports = new class Flow
  act: act = (f, x)-->
    f x |> return_ x
  if_: if_ = (x, f, y)-->
    if x => f y
    else y
  if: if_
  unless_: unless_ = (x, f, y)-->
    unless x => f y
    else y
  unless: unless_
  when_: when_ = (f, g, x)-->
    if f x => g x
    else x
  when: when_
  except: except = (f, g, x)-->
    unless f x => g x
    else x
  then_: then_ = (f, x)-->
    if x => f x
    else x
  then: then_
  else_: else_ = (f, x)-->
    unless x => f x
    else x
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
