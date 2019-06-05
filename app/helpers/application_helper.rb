# frozen_string_literal: true

module ApplicationHelper
  # Format Page Title
  def full_title(page_title)
    title = 'JB Switch History'
    if page_title.empty?
      title
    else
      "#{page_title} | #{title}"
    end
  end

  # Convert flash type between rails and bootstrap
  def flash_message_type(type)
    case type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      'alert-' + type.to_s
    end
  end

end
