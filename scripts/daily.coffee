CronJob = require("cron").CronJob

dailyScrumAlarm = ->
  console.log "デイリースクラムがまだでござる。"

dailyScrum = new CronJob(
  cronTime: "* */10 * * * *"
  onTick: ->
    dailyScrumAlarm()
    return
  start: false
)

module.exports = (robot) ->

  robot.respond /sprint start/i, (msg) ->
    msg.send "Sprint Start!!!"
    dailyScrum.start()

  robot.respond /sprint finish/i, (msg) ->
    msg.send "Sprint Finish!!!"
    dailyScrum.stop()
