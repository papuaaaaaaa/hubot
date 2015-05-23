backlogApi = require('backlog-api')

module.exports = (robot) ->

  getChart = ->
    backlog = backlogApi()
    backlog.getProjectSummary({
        projectId: 48202
      },
      (err, summary) ->
        if (err)
          robot.send {room: 'bot_test'}, "error"
          throw err
        else
          robot.send {room: 'bot_test'}, "success"
          robot.send {room: 'bot_test'}, summary.current_milestone.burndown_chart

    )

  robot.respond /get/i, (msg) ->
    robot.send {room: 'bot_test'}, "get"
    getChart()

