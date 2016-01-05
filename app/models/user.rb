class User < ActiveRecord::Base

  validates :email, presence: true

  def self.authenticate(email_address, raw_password)
    my_user = User.find_by(:email => email_address)

    return nil unless my_user

    if check_password(my_user.password, raw_password)
      my_user
    else
      nil
    end
  end

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

    InviteMailer.welcome_email(created.email, invite_body).deliver_now!
    created
  end

  def nothing
    puts "I don't do anything"
  end

  def self.confirm(token)
    my_user = User.find_by(:confirmation_token => token)

    if my_user != nil

       my_user.update_attribute(:confirmed, true)
       my_user.update_attribute(:confirmation_token, nil)

      return my_user
     else
      return nil
     end
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
    invite_body << "/confirm/"
    invite_body << invitee.confirmation_token
    invite_body << "\nThank You Very Much, \nStudyGroup Team"
  end

  def self.create_password(raw_password)
    BCrypt::Password.create(raw_password)

  end

  def self.check_password(hashed_password, raw_password)
    BCrypt::Password.new(hashed_password).is_password?(raw_password)
  end



end
