#  people =
#    * name: \tarou, blood: \a, age: 23
#    * name: \hanako, blood: \b, age: 25
#    * name: \jirou, blood: \o, age: 24
#  people
#  |> each ( .name is \sakurako) >> then_ console~log # => (Nothing)
#  |> each when_ ( .age > 24), ( .name) >> console~log # => hanako
#  |> map unless_ ( .blood is \b), ( .name)
#  |> map ( or \blood_b)
#  |> join \,
#  |> console~log # => tarou,blood_b,jirou
#


module.exports = new class Control
  when_: when_ = (f, g, x)-->
    if f x => g x
  when: when_
  unless_: unless_ = (f, g, x)-->
    unless f x => g x
  unless: unless_
  then_: then_ = (f, x)-->
    if x => f x
  then: then_
  try_: try_ = (f, g, h)->
    try
      f!
    catch e
      g? e
    finally
      h?!
  try: try_
  catch_: catch_ = (f, g)-->
    try
      f!
    catch e
      g e
  catch: catch_
  finally_: finally_ = (f, g)-->
    try
      f!
    finally
      g!
  finally: finally_

