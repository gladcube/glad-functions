// Generated by LiveScript 1.5.0
(function(){
  var return_, ref$, flip, id, fix, Combinator;
  return_ = require('./applicative').return_;
  ref$ = require('prelude-ls'), flip = ref$.flip, id = ref$.id, fix = ref$.fix;
  module.exports = new (Combinator = (function(){
    Combinator.displayName = 'Combinator';
    var B, C, I, K, W, Y, prototype = Combinator.prototype, constructor = Combinator;
    Combinator.prototype.B = B = curry$(function(x$, y$){
      return compose$(y$, x$);
    });
    Combinator.prototype.C = C = flip;
    Combinator.prototype.I = I = id;
    Combinator.prototype.K = K = return_;
    Combinator.prototype.Q = W = curry$(function(x$, y$){
      return compose$(x$, y$);
    });
    Combinator.prototype.Y = Y = fix;
    function Combinator(){}
    return Combinator;
  }()));
  function compose$() {
    var functions = arguments;
    return function() {
      var i, result;
      result = functions[0].apply(this, arguments);
      for (i = 1; i < functions.length; ++i) {
        result = functions[i](result);
      }
      return result;
    };
  }
  function curry$(f, bound){
    var context,
    _curry = function(args) {
      return f.length > 1 ? function(){
        var params = args ? args.concat() : [];
        context = bound ? context || this : this;
        return params.push.apply(params, arguments) <
            f.length && arguments.length ?
          _curry.call(context, params) : f.apply(context, params);
      } : f;
    };
    return _curry();
  }
}).call(this);
