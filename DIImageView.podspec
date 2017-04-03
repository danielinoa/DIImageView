#
# Be sure to run `pod lib lint DIImageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DIImageView'
  s.version          = '1.0.1'
  s.summary          = 'A Snapchat-inspired caption integrated within a regular UIImageView'

  s.homepage         = 'https://github.com/danielinoa/DIImageView'
  s.screenshots     = 'https://github.com/danielinoa/DIImageView/blob/master/Screenshots/ss1.png', 'https://github.com/danielinoa/DIImageView/blob/master/Screenshots/ss2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'danielinoa' => 'danielinoa@gmail.com' }
  s.source           = { :git => 'https://github.com/danielinoa/DIImageView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielinoa_'

  s.ios.deployment_target = '8.3'

  s.source_files = 'DIImageView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DIImageView' => ['DIImageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
