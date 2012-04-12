
import os
import webapp2

from google.appengine.ext.webapp import template


class ContactThankYouHandler(webapp2.RequestHandler):

   def get(self):
      """
      Displays the page that thanks users for their feedback
      """
      path = os.path.join(os.path.dirname(__file__), '../pages/contact_thank_you.html')
      self.response.out.write(template.render(path, {}))
   #
#


app = webapp2.WSGIApplication([('/contact_thank_you', ContactThankYouHandler)], debug=True)
