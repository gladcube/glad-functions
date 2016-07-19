{return_} = require \./applicative.ls
{flip, id, fix} = require \prelude-ls

module.exports = new class Combinator
  B: B = (<<)
  C: C = flip
  I: I = id
  K: K = return_
  Q: W = (>>)
  Y: Y = fix
