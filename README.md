## Usage

### Applicative
#### return(return_)
a -> (a -> b)
```livescript
return_ \something |> (do) # => 'something'
```

```livescript
something = \something
something
|> return_ \other_thing # => 'other_shing'
```

### Control
#### if(if_), unless(unless_)
Boolean -> (a -> b) -> b?
```livescript
some_value = 200
if_ (some_value > 100), -> console.log \Yeah! # => (Output) 'Yeah!'
unless_ (some_value > 100), -> console.log \Yeah!  # => (Do Nothing)
```

#### try(try_), catch(catch_), finally(finally_)
```livescript
do_something = ->
  throw new Error "Some Error!"
try_ do_something, ( .message) >> console~log # => (Output) 'Some Error!'
do_something `catch_` ( .message |> console~log) # => (Output) 'Some Error!'
do_something `finally_` -> console.log "Finally do other things." # => (Output) 'Finally do other things.' (Error)
```

#### throw(throw_)
```livescript
throw_ new Error "Some Error!" # => (Error) 'Some Error!'
```

### Flow
#### act
(a -> b) -> a
```livescript
[1 to 5]
|> filter (% 2) >> (is 0)
|> act console~log # => (Output) [ 2, 4 ]
|> filter (> 3)
|> act console~log # => (Output) [ 4 ]
|> map (* 100)
|> console~log # => (Output) [ 400 ]
```

#### if(if_), unless(unless_)
Boolean -> (a -> b) -> b?
```livescript
SOME_CONSTANT = 200
\Yeah!
|> if_ (SOME_CONSTANT > 100), console~log # => (Output) 'Yeah!'
```

```livescript
SOME_CONSTANT = 200
\Yeah!
|> unless_ (SOME_CONSTANT > 100), console~log # => (Do Nothing)
```

#### when(when_), except
(a -> Boolean) -> (a -> b) -> b?
```livescript
[1 to 5]
|> when_ (all ( < 6)), ( .length) >> console~log # => (Output) 5
```

```livescript
[1 to 5]
|> except (any ( is 2)), ( .length) >> console~log # => (Do Nothing)
```

```livescript
people =
  * name: \tarou, blood: \a, age: 23
  * name: \hanako, blood: \b, age: 25
  * name: \jirou, blood: \o, age: 24
people
|> each when_ ( .age > 24), ( .name) >> console~log # => (Output) 'hanako'
|> map except ( .blood is \b), ( .name)
|> map ( or \blood_b) # => [ 'tarou', 'blood_b', 'jirou' ]
```

#### then(then_), else(else_)
(a -> b) -> Boolean -> b?
```livesctipt
[1 to 5]
|> any ( < 5)
|> act then_ -> console.log \Yeah! # => (Output) 'Yeah!'
|> else_ -> console.log \Oh! # => (Do Nothing)
```

```livescript
[1 to 5]
|> all ( < 5)
|> then_ act -> console.log \Yeah! # => (Do Nothing)
|> else_ -> console.log \Oh! # => (Output) 'Oh!'
```

#### case(case_), otherwise(otherwise_)
(a -> Boolean) -> (a -> b) -> (a OR c)  
c is special unique object
```livesctipt
[1 to 3]
|> case_ (all (< 3)), -> console.log \Yeah! # => (Do Nothing)
|> case_ (all (< 4)), -> console.log \Yeah! # => (Output) 'Yeah!'
|> case_ (all (< 5)), -> console.log \Yeah! # => (Do Nothing)
|> otherwise_ -> console.log \Yeah! # => (Do Nothing)
```

#### case$
(a -> Boolean) -> (a -> b) -> a  
Equivalent to ```(act . when)```
```livescript
[1 to 3]
|> case$ (all (< 3)), -> console.log \Yeah! # => (Do Nothing)
|> case$ (all (< 4)), -> console.log \Yeah! # => (Output) 'Yeah!'
|> case$ (all (< 5)), -> console.log \Yeah! # => (Output) 'Yeah!'
```

#### let(let_)
(String, b, c, ...) -> a -> a
```livescript
obj =
  hello: (str)-> console.log "Hello, #str!"
  good_bye: (str)-> console.log "Good bye, #str!"
obj
|> let_ \hello, \tarou
|> let_ \good_bye, \tarou
```

### Func
#### $
(a -> b) -> a -> b
```livescript
( + 5) `$` 4 # => 9
```

```livescript
[3 5 7]
|> map flip (%)
|> map (<<) (is 0)
|> all $ _, 105
|> then_ ->
  console.log \Yeah! # => (Output) 'Yeah!'
```

### Obj
#### let(let_)
(a, String, b, c, ...) -> d
```livescript
let_ console, \log, \Yeah! # => (Output) 'Yeah!'
```

#### get
(String) -> a -> b
```livescript
human = name: \tarou
human |> get \name # => 'tarou'
```

```livescript
human = name: \tarou, age: 25 weight: 60
<[name age]> |> map get _, human # => [ 'tarou', 25 ]
```

#### set
(String) -> a -> b -> a
```livescript
human = {}
human
|> act set \name, \tarou
|> act set \age, 25 # => { name: 'tarou', age: 25 }
```

#### delete(delete_)
(String) -> a -> b
```livescript
(foo: \bar)
|> act delete_ \foo # => {}
```

### Option
#### may
(a -> b) -> a? -> b?  
Equivalent to ```when (?)```  
```livescript
people =
  * name: \tarou
  * name: \hanako
save = (person)-> # Save into database
people
|> find (get \name) >> (is \jirou)
|> may save # => (Do Nothing)
```

## Other
### Module Exports Priority
1. Func
2. Applicative
3. Option
4. Flow
5. Control
6. Obj
