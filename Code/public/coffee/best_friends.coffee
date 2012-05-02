morseTimer = null
dashFlag = false
      
$ ->
   $('#morse-sender').mousedown ->
      morseTimer = setTimeout(dotOrDash(), 500)
      
$ ->
   $('#morse-sender').mouseup ->
      $('#morse-receiver').text($('#morse-receiver').text() + if dashFlag then 'dash' else 'dot')
      clearTimeout(morseTimer)
      dashFlag = false
      
      
dotOrDash = -> 
   dashFlag = true
