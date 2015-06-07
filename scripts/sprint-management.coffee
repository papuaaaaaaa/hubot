# Description
#   management development member
#
# Commands:
#   sprint count init [number]
#   week index init [number]
#   get sprint count
#   get week index
#
# Author:
#   papuaaaaaaa

#daily-notification.coffeeに設定値をコピーしているので危険
WEEK_INDEX_KEY = 'week_count'
SPRINT_COUNT_KEY = 'sprint_count'
WEEK_NUMBER_IN_SPRINT = 2

CronJob = require("cron").CronJob

module.exports = (robot) ->

  robot.hear /sprint count init (.+)/i, (msg) ->
    number = parseInt(msg.match[1], 10)
    unless number == NaN
      robot.brain.set SPRINT_COUNT_KEY, msg.match[1]
      msg.send "sprint count initialized to #{number}."

  robot.hear /week index init (.+)/i, (msg) ->
    number = parseInt(msg.match[1], 10)
    unless number == NaN
      robot.brain.set WEEK_INDEX_KEY, msg.match[1]
      msg.send "sprint count initialized to #{number}."

  robot.hear /get sprint count/i, (msg) ->
    num = robot.brain.get SPRINT_COUNT_KEY
    num = if num == null then 0 else num
    msg.send "sprint count is #{num}."

  robot.hear /get week index/i, (msg) ->
    num = robot.brain.get WEEK_INDEX_KEY
    num = if num == null then 0 else num
    msg.send "week count is #{num}."

  new CronJob(
    cronTime: "0 0 24 * * 7"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      incrementWeek(robot)
      checkIncrementSprint(robot)
  )

incrementWeek = (robot) ->
  num = robot.brain.get WEEK_INDEX_KEY
  num = if num == null then 0 else num
  robot.brain.set WEEK_INDEX_KEY, num + 1

checkIncrementSprint = (robot) ->
  week = robot.brain.get WEEK_INDEX_KEY
  week = if week == null then 0 else week
  if week % WEEK_NUMBER_IN_SPRINT == 0
    sprint = robot.brain.get SPRINT_COUNT_KEY
    sprint = if sprint == null then 0 else sprint
    robot.brain.set SPRINT_COUNT_KEY, sprint + 1
    robot.brain.set WEEK_INDEX_KEY, 0


