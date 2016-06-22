{equal} = require \assert

module.exports = new class AsyncAssertion
  before: before =
    (before)->
      hello_then = (name, cb)->
        cb "Hello_" + name
      hello_then_alpha = before hello_then, (name, cb, next)->
        next \lorem_ + name, cb
      hello_then_alpha \foo, -> it + \_test
      |> equal(_, "Hello_lorem_foo_test")
  after: after =
    (after)->
      hello_then = (name, cb)->
        cb "Hello_" + name
      hello_then_beta = after hello_then, (name, cb)->
        cb \lorem_ + name
      hello_then_beta \foo, -> it + \_test
      |> equal(_, "lorem_Hello_foo_test")
