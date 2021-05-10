module GroupsHelper
  def display_eye(project)
    render 'eye' if current_user == project.author
  end

  def display_modify(group)
    render 'modify' if current_user == group.user
  end
end
