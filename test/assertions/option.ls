{equal, does-not-throw, throws} = require \assert
{find} = require \prelude-ls

module.exports = new class OptionAssertion
  may: may =
    * (may)->
        throws ->
          \foo
          |> may -> throw new Error
    * (may)->
        does-not-throw ->
          null
          |> may -> throw new Error
    * (may)->
        [1 2 4]
        |> find (is 4)
        |> may ( + 5) >> equal _, 9
