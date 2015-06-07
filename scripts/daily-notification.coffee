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

#sprint-management.coffeeから設定値をコピーしているので危険
WEEK_INDEX_KEY = 'week_index'
SPRINT_COUNT_KEY = 'sprint_count'
WEEK_NUMBER_IN_SPRINT = 2

CHANNEL = 'scrum'
FIRST_WEEK_INDEX = 0
SECOND_WEEK_INDEX = 1

module.exports = (robot) ->
  new CronJob(
    cronTime: "10 0 10 * * 5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      pullRequestDeadLineNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 18 * * 5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      requestDeadLineConfirm(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 1"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      firstReviewDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      secondReviewDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 3"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      thirdReviewDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 4"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      mergeDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 18 * * 4"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      mergeDayConfirm(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      sprintReviewNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 1"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      startOfSprint(robot)
  )

  robot.respond /test 1st notice/i, (msg) ->
    pullRequestDeadLineNotice(robot)

  robot.respond /test 2st notice/i, (msg) ->
    requestDeadLineConfirm(robot)

  robot.respond /test 3st notice/i, (msg) ->
    firstReviewDayNotice(robot)

  robot.respond /test 4st notice/i, (msg) ->
    secondReviewDayNotice(robot)

  robot.respond /test 5st notice/i, (msg) ->
    thirdReviewDayNotice(robot)

  robot.respond /test 6st notice/i, (msg) ->
    mergeDayNotice(robot)

  robot.respond /test 7st notice/i, (msg) ->
    mergeDayConfirm(robot)

  robot.respond /test 8st notice/i, (msg) ->
    sprintReviewNotice(robot)

  robot.respond /test 9st notice/i, (msg) ->
    startOfSprint(robot)

pullRequestDeadLineNotice = (robot) ->
  if isFirstWeek(robot)
    robot.send {room: CHANNEL}, "今日中にPullRequestを出して帰りましょうね。"

requestDeadLineConfirm = (robot) ->
  if isFirstWeek(robot)
    robot.send {room: CHANNEL}, "PullRequestは出しましたか？今週の稼働時間の入力もお忘れなく。"

firstReviewDayNotice = (robot) ->
  if isSecondWeek(robot)
    robot.send {room: CHANNEL}, "今日はレビュー日間です。お互いコードレビューしてあげましょう。"

secondReviewDayNotice = (robot) ->
  if isSecondWeek(robot)
    robot.send {room: CHANNEL}, "今日もレビュー日間です。みんなでよいコードを書きましょう。"

thirdReviewDayNotice = (robot) ->
  if isSecondWeek(robot)
    robot.send {room: CHANNEL}, "今日はレビュー日間の最終日です。あとから指摘するのもいいんですけど、できればいまのうちにしてほしいですよね。"

mergeDayNotice = (robot) ->
  if isSecondWeek(robot)
    robot.send {room: CHANNEL}, "今日はマージ作業日です。明日はdevelopブランチでスプリントレビューできるようにしておきましょう。"

mergeDayConfirm = (robot) ->
  if isSecondWeek(robot)
    robot.send {room: CHANNEL}, "マージは終わりましたか？スプリントレビューは明日です。"

sprintReviewNotice = (robot) ->
  if isSecondWeek(robot)
    robot.send {room: CHANNEL}, "今日はスプリントレビューとスプリント計画MTGの開催日です。"

startOfSprint = (robot) ->
  if isFirstWeek(robot)
    num = robot.brain.get SPRINT_COUNT_KEY
    num = if num == null then 0 else num
    robot.send {room: CHANNEL}, "今日は新しいsprint#{num}の開始日です。sprint#{num - 1}の振り返りはこちらです。https://docs.google.com/document/d/1P2UsFDWczFtpcwQrcillakOLpftB9rn3VP20UVcpk6s/edit"

isFirstWeek = (robot) ->
  num = robot.brain.get WEEK_INDEX_KEY
  num = if num == null then 0 else num
  num == FIRST_WEEK_INDEX

isSecondWeek = (robot) ->
  num = robot.brain.get WEEK_INDEX_KEY
  num = if num == null then 0 else num
  num == SECOND_WEEK_INDEX


