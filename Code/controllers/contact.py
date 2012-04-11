
import os
import webapp2

from google.appengine.ext.webapp import template


class ContactHandler(webapp2.RequestHandler):

   def get(self):
      """
      Displays the contact form page
      """
      path = os.path.join(os.path.dirname(__file__), '../pages/contact.html')
      self.response.out.write(template.render(path, {}))
   #
#


app = webapp2.WSGIApplication([('/contact', ContactHandler)], debug=True)
