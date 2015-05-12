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
  MEMBER_LIST_KEY = 'member_list'
  REPORTED_MEMBER_KEY = 'reported_member_list'
  CHANNEL = 'scrum'

  notification = ->
    reported_member = (robot.brain.get REPORTED_MEMBER_KEY) or []
    members = (robot.brain.get MEMBER_LIST_KEY) or []
    diff = (list1, list2)-> (value for value in list1 when list2.indexOf(value) is -1)
    unreported_member = diff(members, reported_member)
    if unreported_member.length > 0
      robot.send {room: CHANNEL},
        "みなさんそろそろデイリースクラムのお時間ですよ。dailyと文中にいれてくださいね。\n <#{unreported_member.join('> <')}>"
    else
      robot.send {room: CHANNEL}, "なんと今日はみなさんすでにデイリースクラム終わってます。"

  robot.respond /test notification/i, (msg) ->
    notification()

  new CronJob(
    cronTime: "0 0 10 * * 1-5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      notification()
      return
  )


  confirm = ->
    reported_member = (robot.brain.get REPORTED_MEMBER_KEY) or []
    members = (robot.brain.get MEMBER_LIST_KEY) or []
    diff = (list1, list2)-> (value for value in list1 when list2.indexOf(value) is -1)
    unreported_member = diff(members, reported_member)
    if unreported_member.length > 0
      robot.send {room: CHANNEL},
        "一緒にデイリースクラムしましょうよお。\n <#{unreported_member.join('> <')}>"
    else
      robot.send {room: CHANNEL}, "みなさん良いランチタイムを。"

  robot.respond /test confirm/i, (msg) ->
    confirm()

  new CronJob(
    cronTime: "0 0 12 * * 1-5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      confirm()
      return
  )


  resetReportedMember = ->
    robot.brain.set REPORTED_MEMBER_KEY, []

  robot.respond /test reset reported/i, (msg) ->
    resetReportedMember()

  new CronJob(
    cronTime: "0 0 24 * * 1-5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      resetReportedMember()
      return
  )
