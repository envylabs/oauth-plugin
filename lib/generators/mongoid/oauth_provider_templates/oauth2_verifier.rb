class Oauth2Verifier < OauthToken
  validates_presence_of :user

  def exchange!(params={})
    Oauth2Token.create!(:user => user, :client_application => client_application).tap do
      invalidate!
    end
  end

  def code
    token
  end

  def redirect_url
    callback_url
  end

  protected

  def generate_keys
    self.token = OAuth::Helper.generate_key(20)[0,20]
    self.valid_to = 10.minutes.from_now
    self.authorized_at = Time.now
  end
end
