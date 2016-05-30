{let_} = require \./obj.ls

module.exports = new class Str
  match_: match_ = flip (let_ _, \match, _)
  match: match_
