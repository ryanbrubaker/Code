
import os
import webapp2

from google.appengine.ext.webapp import template


class BestFriendsHandler(webapp2.RequestHandler):

   def get(self):
      """
      Displays the main page of the application
      """
      path = os.path.join(os.path.dirname(__file__), '../pages/best_friends.html')
      self.response.out.write(template.render(path, {}))
   #
#


app = webapp2.WSGIApplication([('/best_friends', BestFriendsHandler)], debug=True)
