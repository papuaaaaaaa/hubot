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

#１周目 火曜日10時10秒
  new CronJob(
    cronTime: "10 0 10 * * 2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isFirstWeek(robot)
        robot.send {room: CHANNEL}, "今日はモデルのレビュー日です。午前中までにモデリングのレビューをしてあげましょう。"
  )

  new CronJob(
    cronTime: "10 0 10 * * 5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isFirstWeek(robot)
        robot.send {room: CHANNEL}, "今日中にPullRequestを出して帰りましょうね。"
  )

  new CronJob(
    cronTime: "10 0 18 * * 5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isFirstWeek(robot)
        robot.send {room: CHANNEL}, "PullRequestは出しましたか？今週の稼働時間の入力もお忘れなく。"
  )

  new CronJob(
    cronTime: "10 0 10 * * 1"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isSecondWeek(robot)
        robot.send {room: CHANNEL}, "今日はレビュー日です。モデリングとコードに相違はないか、大まかな設計方針は合っているかの観点で午前中に確実にレビューしてあげましょう。"
  )

  new CronJob(
    cronTime: "10 0 10 * * 2"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isSecondWeek(robot)
        robot.send {room: CHANNEL}, "明日はマージ日です。マージ前の最終レビューを、午前中にしてあげましょう。"
  )

  new CronJob(
    cronTime: "10 0 10 * * 3"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isSecondWeek(robot)
        robot.send {room: CHANNEL}, "今日はマージ作業日です。明日はdevelopブランチでスプリントレビューできるようにしておきましょう。"
  )

  new CronJob(
    cronTime: "10 0 18 * * 3"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isSecondWeek(robot)
        robot.send {room: CHANNEL}, "マージは終わりましたか？スプリントレビューは明日です。"
  )

  new CronJob(
    cronTime: "10 0 10 * * 4"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isSecondWeek(robot)
        robot.send {room: CHANNEL}, "今日はスプリントレビューとスプリント計画MTGの開催日です。"
  )

  new CronJob(
    cronTime: "10 0 10 * * 5"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      if isSecondWeek(robot)
        num = robot.brain.get SPRINT_COUNT_KEY
        num = if num == null then 0 else num
        robot.send {room: CHANNEL}, "今日は新しいsprint#{num}の開始日です。sprint#{num - 1}の振り返りはこちらです。#{process.env.SPRINT_MTG_DOCUMENT}"
  )

isFirstWeek = (robot) ->
  num = robot.brain.get WEEK_INDEX_KEY
  num = if num == null then 0 else num
  num == FIRST_WEEK_INDEX

isSecondWeek = (robot) ->
  num = robot.brain.get WEEK_INDEX_KEY
  num = if num == null then 0 else num
  num == SECOND_WEEK_INDEX


