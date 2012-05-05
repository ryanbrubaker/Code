morseTimer = null
dashFlag = false
      
$ ->
   $('#morse-sender').mousedown ->
      morseTimer = setTimeout(dotOrDash, 250)
      
$ ->
   $('#morse-sender').mouseup ->
      $('#morse-receiver').text($('#morse-receiver').text() + if dashFlag then 'dash' else 'dot')
      clearTimeout(morseTimer)
      dashFlag = false
   
dotOrDash = -> 
   dashFlag = true
   
sendSignal = (x) ->
   moveSignalStep(x)
   
moveSignalStep = (step) ->
   context = document.getElementById("morseCanvas").getContext('2d')
   context.clearRect(0, 0, context.canvas.width, context.canvas.height);
   drawSignalLine()
   context.fillRect(46 * step, 10, 10, 10)
   
   if (step <= 10)
      setTimeout((-> sendSignal step + 1), 250)
      

drawSignalLine = ->
   context = document.getElementById("morseCanvas").getContext('2d')
   context.moveTo(5, 25)
   context.lineTo(470, 25)
   context.strokeStyle = "#000";
   context.stroke();

$ ->
   $(document).ready ->
      sendSignal(1)
      
