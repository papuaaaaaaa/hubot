# Description
#   cron jobs
#
# Commands:
#   hubot test notification
#   hubot test confirm
#   hubot test reset reported
#
# Author:
#   papuaaaaaaa

CronJob = require("cron").CronJob

module.exports = (robot) ->
  new CronJob(
    cronTime: "0 0 10 * * 1-5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      notification(robot)
      return
  )

module.exports = (robot) ->
  new CronJob(
    cronTime: "0 0 12 * * 1-5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      confirm(robot)
      return
  )

module.exports = (robot) ->
  new CronJob(
    cronTime: "0 0 24 * * 1-5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      resetReportedMember(robot)
      return
  )



module.exports = (robot) ->
  robot.respond /test notification/i, (msg) ->
  notification()

module.exports = (robot) ->
  robot.respond /test confirm/i, (msg) ->
    confirm(robot)

module.exports = (robot) ->
  robot.respond /test reset reported/i, (msg) ->
    resetReportedMember(robot)



MEMBER_LIST_KEY = 'member_list'
REPORTED_MEMBER_KEY = 'reported_member_list'

CHANNEL = 'scrum'

notification = (robot) ->
  lacks = unReportedMemberHelper(robot)
  robot.send {room: CHANNEL},
    "なんと今日はみなさんすでにデイリースクラム終わってます。" if lacks.length == 0
  robot.send {room: CHANNEL},
    "みなさんそろそろデイリースクラムのお時間ですよ。dailyと文中にいれてくださいね。\n <#{lacks.join('> <')}>" unless lacks.length == 0

confirm = (robot)->
  lacks = unReportedMemberHelper(robot)
  robot.send {room: CHANNEL},
    "みなさん良いランチタイムを。" if lacks.length == 0
  robot.send {room: CHANNEL},
    "一緒にデイリースクラムしましょうよお。\n <#{lacks.join('> <')}>" unless lacks.length == 0

resetReportedMember = (robot) ->
  robot.brain.set REPORTED_MEMBER_KEY, []

unReportedMemberHelper = (robot) ->
  diff = (list1, list2) ->
    (value for value in list1 when list2.indexOf(value) is -1)
  lacks = diff(
    (robot.brain.get MEMBER_LIST_KEY) or [],
    (robot.brain.get REPORTED_MEMBER_KEY) or [])
  lacks





