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
    cronTime: "10 0 10 * * 5/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      pullRequestDeadLineNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 18 * * 5/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      requestDeadLineConfirm(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 1/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      firstReviewDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 2/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      secondReviewDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 3/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      thirdReviewDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 4/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      mergeDayNotice(robot)
  )

  new CronJob(
    cronTime: "10 0 18 * * 4/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      mergeDayConfirm(robot)
  )

  new CronJob(
    cronTime: "10 0 10 * * 5/2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      sprintReviewNotice(robot)
  )

  robot.respond /test 1st notice/i, (msg) ->
    mergeDayNotice(robot)

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

CHANNEL = 'bot_test'


pullRequestDeadLineNotice = (robot) ->
  robot.send {room: CHANNEL}, "今日中にPullRequestを出して帰りましょうね。"

requestDeadLineConfirm = (robot) ->
  robot.send {room: CHANNEL}, "PullRequestは出しましたか？今週の稼働時間の入力もお忘れなく。自分たちのために正確な見積もりを出しましょう。"

firstReviewDayNotice = (robot) ->
  robot.send {room: CHANNEL}, "今日はレビュー日間です。お互いコードレビューしてあげましょう。"

secondReviewDayNotice = (robot) ->
  robot.send {room: CHANNEL}, "今日もレビュー日間です。みんなでよいコードを書きましょう。"

thirdReviewDayNotice = (robot) ->
  robot.send {room: CHANNEL}, "今日はレビュー日間の最終日です。あとから指摘されるくらいなら、できれば早めがいいですよね。"

mergeDayNotice = (robot) ->
  robot.send {room: CHANNEL}, "今日はマージ作業日です。明日はdevelopブランチでスプリントレビューできるようにしておきましょう。"

mergeDayConfirm = (robot) ->
  robot.send {room: CHANNEL}, "スプリントレビューは明日です。マージは終わりましたか？今週もお疲れさまでした。"

sprintReviewNotice = (robot) ->
  robot.send {room: CHANNEL}, "今日は新しいスプリントの開始日です。"





