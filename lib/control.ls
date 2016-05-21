module.exports = new class Control
  if_: if_ = (x, f)-->
    if x => do f
  if: if_
  unless_: unless_ = (x, f)-->
    unless x => do f
  unless: unless_
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
  throw_: throw_ = (x)-> throw x
  throw: throw_
