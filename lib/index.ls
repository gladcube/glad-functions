require! \./applicative.ls
require! \./control.ls
require! \./flow.ls
require! \./func.ls
require! \./obj.ls
require! \./option.ls

module.exports = new class GladFunctions
  Applicative: applicative
  Control: control
  Flow: flow
  Func: func
  Obj: obj
  Option: option
|> (<<<< obj)
|> (<<<< control)
|> (<<<< flow)
|> (<<<< option)
|> (<<<< applicative)
|> (<<<< func)

