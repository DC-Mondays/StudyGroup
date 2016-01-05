class InviteMailer < ApplicationMailer

  def hello
    puts "Hello world!"
  end

  def welcome_email(email, email_body)
  

     mail(to: email,
     body: email_body,
    content_type: "text/html",
    subject: "Already rendered!")
    
  end
end
