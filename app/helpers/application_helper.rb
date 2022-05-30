module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t ".base_title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def admin_title page_title
    title = t ".admin_title"
    page_title.empty? ? title : "#{title} | #{page_title}"
  end

  def home_page
    is_admin? ? admin_root_path : root_path
  end
end
