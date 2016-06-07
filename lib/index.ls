require! \./applicative.ls
require! \./combinator.ls
require! \./control.ls
require! \./flow.ls
require! \./func.ls
require! \./list.ls
require! \./obj.ls
require! \./option.ls
require! \./str.ls

module.exports = new class GladFunctions
  Applicative: applicative
  Combinator: combinator
  Control: control
  Flow: flow
  Func: func
  List: list
  Obj: obj
  Option: option
  Str: str
|> (<<<< obj)
|> (<<<< str)
|> (<<<< list)
|> (<<<< control)
|> (<<<< flow)
|> (<<<< option)
|> (<<<< applicative)
|> (<<<< combinator)
|> (<<<< func)

