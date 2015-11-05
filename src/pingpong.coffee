# Description
#   Keep track of you ping pong games
#
# Configuration:
#   HUBOT_FIREBASE_URL  (ie: "https://<app-name>.firebaseio.com/")
#
# Commands:
#   hubot ping pong <score> <winner> <loser> - Save a ping pong game and update stats
#   ping pong stats - Gets all of the ping pong stats
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   desaias

# Table = require 'cli-table'
Firebase = require 'firebase'
moment = require 'moment'
_ = require 'lodash'

toTitleCase = (str) ->
  str.replace /\w\S*/g, (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

firebase = new Firebase(process.env.HUBOT_PINGPONG_FIREBASE_URL);

module.exports = (robot) ->
  robot.respond /ping pong\s([0-9]{1,2}-[0-9]{1,2})\s(.+)\s(.+)/i, (msg) ->
    games = firebase.child('games')
    games.push
      date: moment().format('YYYY-MM-DD hh:mm:ss')
      score: msg.match[1]
      winner: msg.match[2]
      loser: msg.match[3]

    players = firebase.child('players/')

    winner = players.child(toTitleCase(msg.match[2]))
    winner.once 'value', ((snapshot) ->
      if snapshot.exists()
        obj = snapshot.val()
        winner.update
          wins: obj.wins + 1
      else
        winner.set
          wins: 1
          losses: 0
    )

    loser = players.child(toTitleCase(msg.match[3]))
    loser.once 'value', ((snapshot) ->
      if snapshot.exists()
        obj = snapshot.val()
        loser.update
          losses: obj.losses + 1
      else
        loser.set
          wins: 0
          losses: 1
    )

    msg.send "Way to go #{toTitleCase(msg.match[2])}!\n#{toTitleCase(msg.match[3])}... you suck!"


  robot.hear /ping pong stats/i, (msg)->
    message = ''
    firebase.child('players').on 'value', (snapshot) ->
      _.map snapshot.val(), (value, key) ->
        message += "#{toTitleCase(key)}: #{value.wins} - #{value.losses}\n"
    msg.send message
