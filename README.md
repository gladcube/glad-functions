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

### Combinator
#### B
Alias: ```(<<)```

#### C
Alias: ```flip```

#### I
Alias: ```id```

#### K
Alias: ```Applicative.return_```

#### Q
Alias: ```(>>)```

#### Y
Alias: ```fix```

### Async
#### before
(a -> b) -> (c -> d) -> ((c -> d) -> (a -> b))

Extend the function with the other function.
When the "parent" is called. the "child" will be called before the "parent".
Both of the functions should accept the same type and numbers of arguments.(However, the "child" function should accept "next" as the last argument adding the common arguments)

```livescript
  hello_then = (name, cb)->
    cb "Hello_" + name
  hello_then_alpha = before hello_then, (name, cb, next)->
    next \lorem_ + name, cb
  hello_then_alpha \foo, -> it + \_test
  |> console~log # =>(Output) Hello_lorem_foo_test

```

#### after
(a -> b) -> (c -> d) -> ((a -> b) -> (c -> d))

Extend the function with the other function.
When the "parent" is called. the "child" will be called after the "parent".
Both of the functions should accept the same type and numbers of arguments.

```livescript
  hello_then = (name, cb)->
    cb name + "_is_a"
  hello_then_beta = after hello_then, (name, cb)->
    cb name + "_good"
  hello_then_beta \foo, -> it + \_man # => "foo_is_a_good_man
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
(a -> b) -> a -> a
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
Boolean -> (a -> b) -> (a OR b)
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
(a -> Boolean) -> (a -> b) -> (a OR b)
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
(a -> b) -> Boolean -> (a OR b)
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

#### $$
[(a -> b), (a -> c), ...] -> a -> [b, c, ...]
Equivalent to ```flip dist```
```livescript
5 |> $$ [(+ 4), (* 4)] # => [ 9, 20 ]
```

```livescript
[1 to 5]
|> $$ [length >> (`div` 2), reverse]
|> apply replicate # => [ [ 5, 4, 3, 2, 1 ], [ 5, 4, 3, 2, 1 ] ]
```

#### lazy
((a, b, c, ...) -> d) -> e -> d
```livescript
lazy (+), 5, 5 # => [Function]
lazy (+), 5, 5 |> (do) # => 10
```

```livescript
set-timeout (lazy console~log, \Yeah!), 3000_ms # => (Output in 3 seconds) 'Yeah!'
```

#### dist
a -> [(a -> b), (a -> c), ...] -> [b, c, ...]
```livescript
dist 5, [(+ 4), (* 4)] # => [ 9, 20 ]
```

```livescript
[1 to 5]
|> dist _, [length >> (`div` 2), reverse]
|> apply replicate # => [ [ 5, 4, 3, 2, 1 ], [ 5, 4, 3, 2, 1 ] ]
```

#### arg
Number -> (a, b, c, ...) -> (a OR b OR c OR ...)
```livescript
(arg 1) 1, 2, 3 # => 2
```

```livescript
express!.get \./, (arg 1) >> let_ \render, \index # second argument of callback is Response
```

#### args
(a, b, c, ...) -> [a, b, c, ...]
```livescript
args 1, 2, 3 # => [ 1, 2, 3 ]
```

```livescript
express!.get \./, args >> (++ \foo) >> cb # useful when add argument
```

#### withl
(a -> b) -> [b, a]
```livescript
5 |> withl ( + 10) # => [ 15, 5 ]
```

```livescript
[10 to 15]
|> withl elem-index 14
|> apply split-at # => [ [ 10, 11, 12, 13 ], [ 14, 15 ] ]
```

#### withr
(a -> b) -> [a, b]
```livescript
5 |> withr ( + 10) # => [ 5, 15]
```

#### $_at
Number -> (a -> b) -> [a] -> [a OR b]
```livescript
[1, 2, 3]
|> $_at 2, (* 10) # => [ 1, 2, 30 ]
```

#### $_zip
[(a -> b), (c -> d), ...] -> [a, b, ...] -> [c, d, ...]
```livescript
[1, 2, 3]
|> $_zip [(* 10), (- 2), (+ 7)] # => [ 10, 0, 10 ]
```

#### $_head
a -> [b] -> [c]
```livescript
[1, 2, 3]
|> $_head (* 10) # => [10, 2, 3]
```

#### $_last
a -> [b] -> [c]
```livescript
[1, 2, 3]
|> $_last (* 10) # => [1, 2, 30]
```

#### $_arg
Number -> (a -> b) -> (c -> d) -> (e -> f)
```livescript
$_arg 1, (+ 5), (-)
|> apply _, [10, 20] # => -15
```

#### $_head_arg
(a -> b) -> (c -> d) -> (e -> f)
```livescript
$_head_arg (+ 100), (-)
|> apply _, [10, 20] # => 90
```

#### $_last_arg
(a -> b) -> (c -> d) -> (e -> f)
```livescript
$_last_arg  (+ 100), (-)
|> apply _, [10, 20] # => -110
```

#### $_args
(a -> b) -> (c -> d) -> (e -> f)
```livescript
$_args (+ 5), (*)
|> apply _, [10, 20] # => 375
```

#### $$_args
[(a -> b), ...] -> (c -> d) -> (e -> f)
```livescript
$$_args [(+ 100), (+ 5)], (*)
|> apply _, [10, 20]# => 2750
```

#### $_when
a -> Function -> [a] -> [a]
```livescript
[10, 20, 30]
|> $_when (> 20), (* 30) # => [10, 20, 900]
```

#### $_pairs
Function -> Object -> Object
```livescript
{ ks : 10 , ms : 2 }
|> $_pairs  map map (+ \5) # => { ks5: '105', ms5: '25' }

{ ks : 10, ms : 2, mm : 5, kg : 7 }
|> $_pairs filter head >> (in <[ks kg]>) # => { ks: 10, kg: 7 }
```

#### $_key
String -> (a -> b) -> c -> d
```livescript
{ ks : 10 , ms : 2}
|> $_key \ms  (+ 5) # => { ks: 10, ms: 7 }
```

#### need
Number -> Function -> Function
```livescript
(+)
|> need 2
|> apply _, [10]
|> apply _, [4] # => 14
```

### List
#### find_map
(a -> b) -> [a] -> b
```livescript
<[foo bar]>
|> find_map match_ /a(r)/
|> at 1 # => 'r'
```

#### filter_map
(a -> b) -> [a] -> [b]
```livescript
<[foo bar]>
|> filter_map match_ /a(r)/
|> (at 0) >> (at 1) # => 'r'
```

#### length
[a] -> Number
```livescript
[1 to 3] |> length # => 3
```

#### pick
[Number] -> [a] -> [a]
``` livesctipt
[1 to 40] |> pick [4, 23, 13, 5, 1]  # => [ 5, 24, 14, 6, 2 ]
```

[Number] -> [a] -> [a]
``` livescript
some_function = (cb)->
  cb \err, \data, \other_data
some_function (args >> (pick [2, 1]) >> join " ") # => "other_data data"
```

#### list
(a, b, c, ...) -> [a, b, c, ...]
``` livescript
list 1, 2, 3, 4 # => [1, 2, 3, 4]
```

#### range
a -> b -> [a]
```livescript
range 4, 100 # => [4, 5, ... 99]
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

#### set_$
String -> (a -> b) -> c -> d
```livescript
{ foo: 4, bar: 5}
|> act set_$ \bar, (+ 8) # => { foo: 4, bar: 13 }
```

#### new_
a -> b ... -> c
```livescript
(class A
  (num) ->
    @x = num
  property: 1
  method: (y) ->
    @x + @property + y)
|> new_ _, 100
|> _let _, \method, 32 # => 133

```

#### call
String -> a ... -> b -> c
```livescript
call \plus_w, 3, 8 ,(plus_w: ( + ) >> ( * 2 )) # => 22
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

### Str
#### match(match_)
(String OR RegExp) -> String -> [String]?
```livescript
\foo |> match_ /oo/ |> at 0 # => 'oo'
```

## Other
### Module Exports Priority
1. Func
2. Combinator
3. Applicative
4. Option
5. Flow
6. Control
7. List
8. Str
9. Obj
