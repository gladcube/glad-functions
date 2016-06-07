{deep-equal, equal} = require \assert

module.exports = new class CombinatorAssertion
  B: B = (B)->
    0 |> ((+ 4) `B` (* 5)) |> equal _, 4
  C: C = (C)->
    (C (-)) 4 5 |> equal _, 1
  I: I = (I)->
    I \foo |> equal _, \foo
  K: K = (K)->
    \foo |> K \bar |> equal _, \bar
  Q: Q = (Q)->
    0 |> ((+ 4) `Q` (* 5)) |> equal _, 20
  Y: Y = (Y)->
    10
    |> Y ((foo)-> (x)->
        | x <= 0 => \foo
        | _ => foo (x - 1)
    )
    |> equal _, \foo

