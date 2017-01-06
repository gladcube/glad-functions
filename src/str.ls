{let_} = require \./obj
{flip} = require \prelude-ls

module.exports = new class Str
  match_: match_ = flip (let_ _, \match, _)
  match: match_
