#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "GSIndeterminateProgressBar"
  s.version          = "0.1.0"
  s.summary          = "GSIndeterminateProgressView is a subclass of UIView that looks like UIProgressView but acts like UIActivityIndicatorView."
  s.description      = <<-DESC
                       GSIndeterminateProgressView is a subclass of UIView that looks like UIProgressView but acts like UIActivityIndicatorView.
                       DESC
  s.homepage         = "https://github.com/endSly/GSIndeterminateProgressBar"
  s.screenshots      = "https://github.com/endSly/GSIndeterminateProgressBar/raw/master/capture.gi"
  s.license          = 'MIT'
  s.author           = { "Endika Gutiérrez" => "me@endika.net" }
  s.source           = { :git => "https://github.com/endSly/GSIndeterminateProgressBar.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/endSly'

  # s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'

  s.public_header_files = 'Classes/**/*.h'
end
