# Be sure to restart your server when you modify this file.
vendor = Rails.root.join('vendor')
Dir.entries(vendor).select do |entry|
  if File.directory? File.join(vendor, entry) and !(entry =='.' || entry == '..')
    Rails.application.config.assets.paths << File.join(vendor, entry)
  end
end

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# Rails.application.config.assets.precompile += %w( bsie/**/* )
Rails.application.config.assets.precompile += %w(
  bootstrap_and_overrides.css
  dashboard.css
  twitter/bootstrap.js
  jquery.js
  jquery_ujs.js
  dashboard.js
)
Rails.application.config.assets.precompile += %w(
  bsie/bootstrap/css/bootstrap.css
  bsie/bootstrap/css/bootstrap-ie6.css
  bsie/bootstrap/css/ie.css
  bsie/js/jquery-1.7.2.min.js
  bsie/bootstrap/js/bootstrap.js
)
Rails.application.config.assets.precompile += %w(
  ie.css
  owl.carousel.min.css
  owl.theme.default.min.css
  magnific-popup.css
  nivo-slider.css
  default/default.css
  css/settings.css
  css/component.css
  respond.js
  excanvas.js
  modernizr.js
  common.js
  jquery-cookie.js
  jquery.appear.js
  jquery.easing.js
  jquery.easy-pie-chart.js
  jquery.gmap.js
  jquery.isotope.js
  jquery.magnific-popup.js
  jquery.stellar.js
  jquery.validation.js
  owl.carousel.js
  jflickrfeed.js
  vide.js
  js/jquery.flipshow.js
  jquery.nivo.slider.js
  theme.js
  theme.init.js
  views/view.home.js
  views/view.contact.js
)
