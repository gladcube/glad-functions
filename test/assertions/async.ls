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
        cb name + "_is_a"
      hello_then_beta = after hello_then, (name, cb)->
        cb name + "_good"
      hello_then_beta \foo, -> it + \_man
      |> equal(_, "foo_is_a_good_man")
