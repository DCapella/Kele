module Messages
  def get_messages(page_number = 1)
    response = self.class.get('/message_threads?page=' + page_number.to_s, headers: { "authorization" => @auth_token })
    body     = JSON.parse(response.body)
  end

  def create_message(sender_email, recipient_id, token, subject, stripped_text)
    response = self.class.post('/messages', body: { sender: "#{sender_email}", recipient_id: "#{recipient_id}", token: "#{token}", subject: "#{subject}", stripped_text: "#{stripped_text}" }, headers: { "authorization" => @auth_token })
  end
end
