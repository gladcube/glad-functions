{equal, not-equal, does-not-throw, throws} = require \assert

module.exports = new class ControlAssertion
  if_: if_ =
    * (if_)->
        (if_ true, -> \foo) `equal` \foo
    * (if_)->
        (if_ false, -> \bar) `not-equal` \bar
  if: if_
  unless_: unless_ =
    * (unless_)->
        (unless_ false, -> \foo) `equal` \foo
    * (unless_)->
        (unless_ true, -> \bar) `not-equal` \bar
  unless: unless_
  try_: try_ =
    * (try_)->
        does-not-throw ->
          try_ -> throw new Error
    * (try_)->
        try_ (-> throw new Error \foo), ->
          it.message `equal` \foo
    * (try_)->
        throws ->
          try_ (-> throw new Error), (->), ->
            throw new Error
  try: try_
  catch_: catch_ =
    * (catch_)->
        does-not-throw ->
          (-> throw new Error) `catch_` ->
    * (catch_)->
        does-not-throw ->
          (->) `catch_` -> throw new Error
    * (catch_)->
        throws ->
          (-> throw new Error) `catch_` -> throw new Error
    * (catch_)->
        (-> throw new Error \foo) `catch_` ->
          it.message `equal` \foo
  catch: catch_
  finally_: finally_ =
    * (finally_)->
        throws ->
          (-> throw new Error) `finally_` ->
    * (finally_)->
        throws ->
          (->) `finally_` -> throw new Error
  finally: finally_
  throw_: throw_ =
    * (throw_)->
        throws ->
          throw_ new Error
  throw: throw_

