require! \./applicative.ls
require! \./control.ls
require! \./flow.ls
require! \./func.ls
require! \./obj.ls

module.exports = new class GladFunctions
  Applicative: applicative
  Control: control
  Flow: flow
  Func: func
  Obj: obj
|> (<<<< obj)
|> (<<<< control)
|> (<<<< flow)
|> (<<<< applicative)
|> (<<<< func)

