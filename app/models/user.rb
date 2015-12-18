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
    binding.pry
    created
  end

  def confirm
  end

end
