require! \./control.ls
require! \./func.ls

module.exports = new class GladFunctions
  Control: control
  Func: func
|> (<<<< control)
|> (<<<< func)

