{equal} = require \assert

module.exports = new class ApplicativeAssertion
  return_: return_ =  (return_)->
    (return_ \foo |> (do)) `equal` \foo
  return: return_

