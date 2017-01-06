require! \./applicative
require! \./async
require! \./combinator
require! \./control
require! \./flow
require! \./func
require! \./list
require! \./obj
require! \./option
require! \./str

module.exports = new class GladFunctions
  Applicative: applicative
  Async: async
  Combinator: combinator
  Control: control
  Flow: flow
  Func: func
  List: list
  Obj:
    # Avoid confliction against prelude-ls
    obj.merge (
      (require \prelude-ls)
      |> obj.get \Obj
    ), obj
  Option: option
  Str: str
|> (<<<< obj)
|> (<<<< str)
|> (<<<< list)
|> (<<<< control)
|> (<<<< async)
|> (<<<< flow)
|> (<<<< option)
|> (<<<< applicative)
|> (<<<< combinator)
|> (<<<< func)

