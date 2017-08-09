module Roadmaps
  def get_roadmap(roadmap_id)
    response = self.class.get('/roadmaps/' + roadmap_id.to_s, headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get('/checkpoints/' + checkpoint_id.to_s, headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
  end

  def create_submission(assignment_branch, assignment_commit_link, work_commit_link, checkpoint_id, comment, enrollment_id)
    response = self.class.post('/checkpoint_submissions', body: { assignment_branch: "#{assignment_branch}", assignment_commit_link: "#{assignment_commit_link}", work_commit_link: "#{work_commit_link}", checkpoint_id: checkpoint_id, comment: "#{comment}", enrollment_id: enrollment_id }, headers: { "authorization" => @auth_token })
  end
end
