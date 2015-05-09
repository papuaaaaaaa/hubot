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
  CHANNEL = '#bot_test'

  notification = ->
    members = (robot.brain.get MEMBER_LIST_KEY) or []
    robot.send {room: CHANNEL},
      "そろそろデイリースクラムはじめてください。 #{members}"

  robot.respond /test notification/i, (msg) ->
    notification()

  new CronJob(
    cronTime: "0 0 24 * * *"
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
    robot.send {room: CHANNEL}, "デイリースクラムしましたか？ #{diff(reported_member, members)}"

  robot.respond /test confirm/i, (msg) ->
    confirm()

  new CronJob(
    cronTime: "0 0 12 * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      confirm
      return
  )



  resetReportedMember = ->
    robot.brain.set REPORTED_MEMBER_KEY, []

  robot.respond /test reset reported/i, (msg) ->
    resetReportedMember()

  new CronJob(
    cronTime: "0 0 24 * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      resetReportedMember
      return
  )
