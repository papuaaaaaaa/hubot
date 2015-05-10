# Description
#   management development member
#
# Commands:
#   member add
#   member remove
#   member list
#   hubot member reset
#
# Author:
#   papuaaaaaaa

module.exports = (robot) ->
  MEMBER_LIST_KEY = 'member_list'

  robot.hear /member add (.+)/i, (msg) ->
    members = (robot.brain.get MEMBER_LIST_KEY) or []
    for member in msg.match[1].split(' ')
      if members.indexOf('@' + member) == -1
        members.push('@' + member)
        robot.brain.set MEMBER_LIST_KEY, members
        msg.send "#{member} added"


  robot.hear /member remove (.+)/i, (msg) ->
    members = (robot.brain.get MEMBER_LIST_KEY) or []
    for member in msg.match[1].split(' ')
      members.some (v, i) ->
        if v == '@' + member
          members.splice(i, 1)
          robot.brain.set MEMBER_LIST_KEY, members
          msg.send "#{member} removed"

  robot.hear /member list/i, (msg) ->
    members = (robot.brain.get MEMBER_LIST_KEY) or []
    if members.length
      msg.send "\"#{members}\""
    else
      msg.send "[]"

  robot.respond /member reset/i, (msg) ->
    robot.brain.set MEMBER_LIST_KEY, []
    msg.send "member reset"

