## Usage

### Control
#### when(when_), unless(unless_)
```livescript
[1 to 5]
|> when_ (all ( < 6)), ( .length) >> console~log # => 5
```

```livescript
[1 to 5]
|> unless_ (any ( is 2)), ( .length) >> console~log # => (Nothing)
```

```livescript
people =
  * name: \tarou, blood: \a, age: 23
  * name: \hanako, blood: \b, age: 25
  * name: \jirou, blood: \o, age: 24
people
|> each when_ ( .age > 24), ( .name) >> console~log # => hanako
|> map unless_ ( .blood is \b), ( .name)
|> map ( or \blood_b)
|> join \,
|> console~log # => tarou,blood_b,jirou
```


#### then(then_), else(else_)
```livesctipt
[1 to 5]
|> any ( < 5)
|> then_ act -> console.log \Yeah! # => Yeah!
|> else_ -> console.log \Oh! # => (Nothing)
```

```livescript
[1 to 5]
|> all ( < 5)
|> then_ act -> console.log \Yeah! # => (Nothing)
|> else_ -> console.log \Oh! # => Oh!
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
  console.log \Yeah! # => Yeah!
```


### Flow
#### act
```livescript
[1 to 5]
|> filter (% 2) >> (is 0)
|> act console~log # => [2, 4]
|> filter (> 3)
|> act console~log # => [4]
|> map (* 100)
|> console~log # => [400]
```
