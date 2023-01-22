# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.tun-ari.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #add articles_path, :priority => 0.7, :changefreq => 'daily'

  add root_path
  add privacy_path, :priority => 0.2
  add terms_path, :priority => 0.2
  add login_path, :priority => 0.2
  add new_user_path, :priority => 0.2
  #
  # Add all articles:
  #
  Post.find_each do |post|
    add post_path(post), :priority => 0.8
  end
end
