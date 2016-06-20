{equal} = require \assert

module.exports = new class AsyncAssertion
  before: before =
    (before)->
        _module =(
          hello_then:(name)->
            "Hello #name!"
        )
        |> before \hello_then, (name, next)->
          next \lorem + name
        name <- _module.hello_then \foo
        equal(name, "Hello loremfoo!")
    (after)->
      (-)
      |> after (*), _
      |> apply _, [4,5]
      |> console~log
