module DiscussionsHelper

  def discussion_path_for(discussion)
    lesson = discussion.item.lesson
    discussion_path(lesson.course, lesson, discussion.item, discussion)
  end

end
