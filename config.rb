###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change

require 'slim'
Slim::Engine.disable_option_validator!

activate :i18n, :mount_at_root => false

set :asciidoc_attributes, %w(source-highlighter='coderay' safe='unsafe')

page "/", :layout => false
page "/locale-select", :layout => false

I18n.available_locales.each do |locale|
  page "/#{locale}/", :layout => 'base'
  page "/#{locale}/blog/*", :layout => 'blog'
  page "/#{locale}/blog/", :layout => false
  page "/#{locale}/blog/archive", :layout => false

  redirect "#{locale}/forum/index.html", :to => "http://rigsofrods.com/forum"
  redirect "#{locale}/repository/index.html", :to => "http://rigsofrods.com/repository"
  redirect "#{locale}/races/index.html", :to => "http://rigsofrods.com/races"
end

#configure :development do
#  activate :livereload
#end

activate :blog do |blog|
  blog.prefix    = "{lang}/blog"
  blog.sources   = "{year}-{month}-{day}-{title}/index.html"
  blog.permalink = "{year}-{month}-{day}-{title}.html"
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  deploy.remote   = 'git@github.com:rigsofrods/rigsofrods.github.io.git' # remote name or git url, default: origin
  deploy.branch   = 'master' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
