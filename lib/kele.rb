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
    body = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    ### Retrieve a list of mentor's availability

    response = self.class.get('/mentors/' + mentor_id.to_s + '/student_availability', headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
    mentor_availability = []
    body.each { |time_slot| mentor_availability << time_slot if time_slot['booked'] == nil }
  end
end
