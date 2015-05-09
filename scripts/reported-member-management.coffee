# Description
#   reported member management
#
# Commands:
#   daily
#   reported list
#
# Author:
#   papuaaaaaaa

CronJob = require("cron").CronJob

module.exports = (robot) ->
  REPORTED_MEMBER_KEY = 'reported_member_list'

  robot.hear /daily.*/i, (msg) ->
    sender = msg.message.user.name
    reported_member = (robot.brain.get REPORTED_MEMBER_KEY) or []
    if reported_member.indexOf(sender) == -1
      reported_member.push(sender)
      robot.brain.set REPORTED_MEMBER_KEY, reported_member

  robot.hear /reported list/i, (msg) ->
    reported_member = (robot.brain.get REPORTED_MEMBER_KEY) or []
    if reported_member.length
      msg.send "#{reported_member}"
    else
      msg.send "[]"
