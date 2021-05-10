module ProjectsHelper
  def display_icon(group, project)
    return unless project.groups.any?

    image_tag group.icon, alt: 'group-icon', class: 'group-img'
  end

  def total_project(projects)
    total = projects.inject(0) { |acum, project| acum + project.duration }
    if total > 1000

      content_tag(:span, "#{total}hr You are clocked-in the mandatory time", class: 'text-danger build-project')
    else
      "#{total}hr"
    end
  end
end
