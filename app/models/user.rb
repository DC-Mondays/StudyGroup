class User < ActiveRecord::Base

  validates :email, presence: true

  def self.invite(user, creator)
    return nil if creator.nil?

    if User.find_by_email(user["email"])
      return nil
    else
      user = User.create(user)
    end
    return User.send_invite(creator, user)
  end

  def self.send_invite(creator, created)
    
    invite_body = create_invite_body(created)
    created
  end

  def confirm
  end
  
  private
  
  
  def self.create_confirmation_token
    SecureRandom.hex(16)
  end
  
  def self.create_invite_body(invitee)
    invitee.confirmation_token = create_confirmation_token
    invite_body = "Hello StudyGroup Friend,\n"
    invite_body << "Please cut and paste this link to confirm your invitation to membership:\n"
    invite_body << ENV['THIS_URL']
    invite_body << "/users/confirm/"
    invite_body << invitee.confirmation_token
    invite_body << "\nThank You Very Much, \nStudyGroup Team"
  end
  

end
