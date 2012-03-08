#rating_container(rating) -return container witch contains image for rating. rating - integer value of rating
#menu_link(title, path, active_hash = {}) - return link for top menu
#form_input_wrapper(builder, name, type, options = {}) - Generate wrapper for forms input
module ViewsHelper
  #return container witch contains image for rating. rating - integer value of rating
  def rating_container(rating)
    rating_body = ''
    rating.to_i.times do
      rating_body += content_tag(:div,'',:class => 'one_rating')
    end

    content_tag(:div, rating_body.html_safe, :class => 'rating_container').html_safe
  end

  #return link for top menu
  #title - name of link
  #path - url for link
  #active_hash - when link id active
  def menu_link(title, path, active_hash = {})
     link_content = content_tag(:a,
                 title,
                 :href => path,
                 :class=>"#{'aktiv' if action_in_controller_hash?(active_hash)} "
     )
     link_content = "#{link_content}<br/>"

     link_content.html_safe
  end

  def page_title(text)
    content_tag(:h4, text).html_safe
  end

  #Generate wrapper for forms input
  #bulder - object class FormBuilder
  #name - field name
  #type - filed type(text_field, text_area e.t.c)
  #options[:label_name] - define label for input
  #options[:label_class] - set addition class to labels(for example 'required')
  def form_input_wrapper(builder, name, type, options = {})
    input = ''
    input += content_tag(:div, content_tag(:p,
                               options[:label_name].present? ? options[:label_name] : name.to_s.humanize,
                               :class => "label left #{options[:label_class].to_s}") + builder.send(type, name.to_sym),
                        :class => 'form_row'
                        )
    input +=  content_tag(:div, '', :class => 'clr')

    input.html_safe
  end
end
