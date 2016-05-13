## Usage

### Control
#### when(when_), unless(unless_), then(then_)
```livescript
[1 to 5]
|> when_ (all ( < 6)), ( .length) >> console~log # => 5
```
```livescript
[1 to 5]
|> unless_ (any ( is 2)), ( .length) >> console~log # => (Nothing)
```
```livescript
[1 to 5]
|> find ( > 4)
|> (?)
|> then_ -> console.log \Yeah! # => Yeah!
```
```livescript
people =
  * name: \tarou, blood: \a, age: 23
  * name: \hanako, blood: \b, age: 25
  * name: \jirou, blood: \o, age: 24
people
|> each ( .name is \sakurako) >> then_ console~log # => (Nothing)
|> each when_ ( .age > 24), ( .name) >> console~log # => hanako
|> map unless_ ( .blood is \b), ( .name)
|> map ( or \blood_b)
|> join \,
|> console~log # => tarou,blood_b,jirou
```
#### try(try_), catch(catch_), finally(finally_)
```livescript
do_something = ->
  throw new Error "Some Error!"
try_ do_something, ( .message) >> console~log # => Some Error!
do_something `catch_` ( .message |> console~log) # => Some Error!
do_something `finally_` -> console.log "Finally do other things." # => Finally do other things. (Error)
```

### Func
#### $
```livescript
( + 5) `$` 4 |> console~log # => 9
```
```livescript
[3 5 7]
|> map flip (%)
|> map (<<) (is 0)
|> all $ _, 105
|> then_ ->
  \Yeah! # => Yeah!
```

