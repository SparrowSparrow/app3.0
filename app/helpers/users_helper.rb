module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    # user.email = email.downcase
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    # gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
