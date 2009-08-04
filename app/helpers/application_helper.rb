module ApplicationHelper

  # Sets the page title and outputs title if container is passed in.
  # eg. <%= title('Hello World', :h2) %> will return the following:
  # <h2>Hello World</h2> as well as setting the page title.
  def title(str, container = nil)
    @page_title = str
    content_tag(container, str) if container
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice success warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]),
                              :id => "flash-#{msg}", :class => msg) unless flash[msg.to_sym].blank?
    end
    messages
  end

  # Generate CSS class name for row striping.
  def stripe_cycle
    cycle('odd', 'even')
  end

  # Generate rows for table in "show" views.
  def show_row(object, method_name)
    content_tag(:tr,
        content_tag(:th, object.class.human_attribute_name(method_name.to_s)) +
        content_tag(:td, h(object.send(method_name))),
      :class => stripe_cycle
    )
  end
end
