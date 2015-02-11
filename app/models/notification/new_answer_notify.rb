class Notification::NewAnswerNotify < Notification::Base

  belongs_to :answer

  def notify_hash
    {
      title: '您关注的问题有新回答'
    }
  end

  def content_path
    url_helper.question_path()
  end

end
