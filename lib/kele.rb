require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    ### Retrieve and storing auth token when passing valid credentials and raising error otherwise

    response = self.class.post('/sessions', body: { email: "#{email}", password: "#{password}" } )
    @auth_token = response["auth_token"]
    raise "ERROR: Wrong email or password." if @auth_token.nil?
  end

  def get_me
    ### Retrieve the current user from the Bloc API and converting into a ruby hash

    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    document = JSON[response]
    document = JSON.parse(document)
    document = JSON.parse(document)
  end
end
