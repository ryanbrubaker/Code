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
   
$ ->
   $(document).ready ->
      context = document.getElementById("morseCanvas").getContext('2d')
      context.moveTo(5, 25)
      context.lineTo(470, 25)
      context.strokeStyle = "#000";
      context.stroke();
