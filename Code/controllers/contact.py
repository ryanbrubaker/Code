
import os
import webapp2

from google.appengine.api import mail
from google.appengine.ext.webapp import template


class ContactHandler(webapp2.RequestHandler):

   def get(self):
      """
      Displays the contact form page
      """
      path = os.path.join(os.path.dirname(__file__), '../pages/contact.html')
      self.response.out.write(template.render(path, {}))
   #
   
   
   def post(self):
      """
      Send user's input to my email address
      """
      mail.send_mail(sender="Code Feedback Form<ryan.brubaker@gmail.com>",
                    to="Ryan Brubaker <ryan.brubaker@gmail.com>",
                    subject="Feedback from Speak Code",
                    body=self.request.get('message'))
      
      self.redirect('/contact_thank_you')
      
#


app = webapp2.WSGIApplication([('/contact', ContactHandler)], debug=True)
