
import os
import webapp2

from google.appengine.ext.webapp import template


class MainHandler(webapp2.RequestHandler):

   def get(self):
      """
      Displays the main page of the application
      """
      path = os.path.join(os.path.dirname(__file__), '../pages/home.html')
      self.response.out.write(template.render(path, {}))
   #
#


app = webapp2.WSGIApplication([('/', MainHandler)], debug=True)
