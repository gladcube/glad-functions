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
  else_: else_ = (f, x)-->
    unless x => f x
  else: else_
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

