{args, $_last_arg} = require \./func.ls
{C} = require \./combinator.ls
{apply} = require \prelude-ls

module.exports = new class Async
  before: before = (f, g)-->
    args >> (++ f) >> apply g
  after: after = (f, g)-->
    $_last_arg (
      (C (++))
      >> (args >>)
      >> (>> apply g)
    ), f

