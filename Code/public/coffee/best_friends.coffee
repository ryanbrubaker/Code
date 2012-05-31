
kDotToken = 0
kDashToken = 1
kWordStopToken = 2

class CommunicationLine extends Backbone.Model
   initialize: ->
      @inputQueue = []
      @communicationLine = ['', '', '', '', '', '', '', '', '', '']
      setInterval(@moveDataOneStep, 100)

   addToken: (token) =>
      @inputQueue.push token

   moveDataOneStep: =>
      @trigger 'tokenReachedReceiver', @communicationLine.pop()
      nextToken = @inputQueue.shift()
      @communicationLine.unshift(if undefined == nextToken then '' else nextToken)
      @trigger 'hasNewData', @communicationLine


class StraightKeyInput extends Backbone.View

   initialize: ->
      @dashTimer = null
      @dashFlag = false
      @wordStopTimer = null
      @wordStopFlag = false

   events:
      'mousedown #straight-key': 'startTimers',
      'mouseup #straight-key': 'sendUserInput'
      
   startTimers: =>
      @dashTimer = setTimeout(@dashTimerExpired, 250)
      @wordStopTimer = setTimeout(@wordStopTimerExpired, 1000)
      
   dashTimerExpired: =>
      @dashFlag = true
      
   wordStopTimerExpired: =>
      @wordStopFlag = true
   
   sendUserInput: =>
      if @wordStopFlag
         @model.addToken kWordStopToken
      else if @dashFlag
         @model.addToken kDashToken
      else
         @model.addToken kDotToken

      clearTimeout(@dashTimer)
      clearTimeout(@wordStopTimer)
      @dashFlag = false
      @wordStopFlag = false


class CommunicationLineView extends Backbone.View
   initialize: ->
      @model.bind 'hasNewData', @render
      
   render: (tokens) =>
      context = document.getElementById("communicationLineCanvas").getContext('2d')
      context.clearRect(0, 0, context.canvas.width, 29);
      tokenNum = 0
      for token in tokens
         do (token) ->
            if kDotToken == token
               context.beginPath()
               context.moveTo((50 * tokenNum) + 15, 15)
               context.arc((50 * tokenNum) + 15, 15, 10, 0, Math.PI*2, false)
               context.closePath()
               context.fill()
               context.stroke()
            else if kDashToken == token
               context.fillRect((50 * tokenNum) + 15, 15, 25, 10)
            else if kWordStopToken == token
               context.fillRect((50 * tokenNum) + 30, 5, 10, 20)
            tokenNum += 1
               
drawSignalLine = (context) ->
   context.moveTo(0, 30)
   context.lineTo(500, 30)
   context.strokeStyle = "#000";
   context.closePath()
   context.stroke();
      
init = ->
   model = new CommunicationLine
   straightKey = new StraightKeyInput 'el': $('#straight-key-div'), 'model': model
   communicationLineView = new CommunicationLineView 'el': $('#communication-line-div'), 'model': model
   
   context = document.getElementById("communicationLineCanvas").getContext('2d')
   context.clearRect(0, 0, context.canvas.width, context.canvas.height);
   drawSignalLine context

$(document).ready init


