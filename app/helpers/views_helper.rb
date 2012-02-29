#rating_container(rating) -return container witch contains image for rating. rating - integer value of rating

module ViewsHelper
  #return container witch contains image for rating. rating - integer value of rating
  def rating_container(rating)
    rating_body = ''
    rating.to_i.times do
      rating_body += content_tag(:div,'',:class => 'one_rating')
    end
    content_tag(:div, rating_body.html_safe, :class => 'rating_container').html_safe
  end
end
