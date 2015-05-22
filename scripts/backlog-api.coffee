backlogApi = require('backlog-api')

module.exports = (robot) ->

  getChart = ->
    backlog = backlogApi()
    backlog.getProjectSummary({
        projectId: 48202
      },
      (err, summary) ->
        if (err)
          console.log('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&')
          throw err
        else
          console.log(summary)
          robot.send {room: 'bot_test'}, summary.current_milestone.burndown_chart.toString()
          console.log("*******************")

    )

  robot.respond /get/i, (msg) ->
    console.log('22222&&&&&&&&&&&&&&&&&&&&22' + process.env.BACKLOG_PROJECT_ID)
    getChart()

