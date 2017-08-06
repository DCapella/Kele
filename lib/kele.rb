require 'httparty'
require 'json'
require './lib/kele_accessories/roadmap'
require './lib/kele_accessories/message'

include Roadmaps
include Messages


class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post('/sessions', body: { email: "#{email}", password: "#{password}" } )
    @auth_token = response["auth_token"]
    raise "ERROR: Wrong email or password." if @auth_token.nil?
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get('/mentors/' + mentor_id.to_s + '/student_availability', headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
    mentor_availability = []
    body.each do |time_slot|
      mentor_availability << time_slot if time_slot['booked'].nil?
    end
  end
end
