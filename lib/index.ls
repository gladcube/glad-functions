require! \./control.ls
require! \./func.ls
require! \./flow.ls

module.exports = new class GladFunctions
  Control: control
  Func: func
  Flow: flow
|> (<<<< control)
|> (<<<< func)
|> (<<<< flow)

