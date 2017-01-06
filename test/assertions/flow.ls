{case: _case} = require \../../src/flow.ls
{equal, not-equal, throws, does-not-throw} = require \assert

module.exports = new class FlowAssertion
  act: act =
    * (act)->
        100
        |> act ( * 5) >> -> it `equal` 500
        |> -> it `equal` 100
  if_: if_ =
    * (if_)->
        \foo
        |> if_ true, ( + \bar)
        |> equal _, \foobar
    * (if_)->
        \foo
        |> if_ false, ( + \bar)
        |> equal _, \foo
    * (if_)->
        does-not-throw ->
          \foo |> if_ false, -> throw new Error
  if: if_
  unless_: unless_ =
    * (unless_)->
        \foo
        |> unless_ false, ( + \bar)
        |> equal _, \foobar
    * (unless_)->
        \foo
        |> unless_ true, ( + \bar)
        |> equal _, \foo
    * (unless_)->
        does-not-throw ->
          \foo |> unless_ true, -> throw new Error
  unless: unless_
  when_: when_ =
    * (when_)->
        200
        |> when_ ( > 100), ( * 2)
        |> equal _, 400
    * (when_)->
        200
        |> when_ ( < 100), ( * 2)
        |> equal _, 200
    * (when_)->
        does-not-throw ->
          200
          |> when_ ( < 100), -> throw new Error
  when: when_
  except: except =
    * (except)->
        200
        |> except ( > 100), ( * 2)
        |> equal _, 200
    * (except)->
        200
        |> except ( < 100), ( * 2)
        |> equal _, 400
    * (except)->
        does-not-throw ->
          200
          |> except ( > 100), -> throw new Error
  then_: then_ =
    * (then_)->
        true
        |> then_ -> \foo
        |> equal _, \foo
    * (then_)->
        false
        |> then_ -> \foo
        |> equal _, false
    * (then_)->
        does-not-throw ->
          false
          |> then_ -> throw new Error
  then: then_
  else_: else_ =
    * (else_)->
        true
        |> else_ -> \foo
        |> equal _, true
    * (else_)->
        false
        |> else_ -> \foo
        |> equal _, \foo
    * (else_)->
        does-not-throw ->
          true
          |> else_ -> throw new Error
  else: else_
  case_: case_ =
    * (case_)->
        throws ->
          250
          |> case_ ( > 200), -> throw new Error
    * (case_)->
        does-not-throw ->
          250
          |> case_ ( > 300), -> throw new Error
          |> case_ ( > 200), ->
          |> case_ ( > 100), -> throw new Error
  case: case_
  otherwise_: otherwise_ =
    * (otherwise_)->
        throws ->
          250
          |> _case ( > 300), ->
          |> otherwise_ -> throw new Error
    * (otherwise_)->
        does-not-throw ->
          250
          |> _case ( > 200), ->
          |> otherwise_ -> throw new Error
  otherwise: otherwise_
  case$: case$ =
    * (case$)->
        throws ->
          250
          |> case$ ( > 200), ->
          |> case$ ( > 100), -> throw new Error
    * (case$)->
        does-not-throw ->
          250
          |> case$ ( > 300), -> throw new Error
