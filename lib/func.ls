module.exports = new class Func
  $: $ = (f, x)-->
    f x
  lazy: lazy = (x, ...y)->
    -> apply x, y

