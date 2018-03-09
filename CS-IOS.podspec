#
# Be sure to run `pod lib lint CS-IOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CS-IOS'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CS-IOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rene-dohan/CS-IOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rene-dohan' => 'dohan.rene@gmail.com' }
  s.source           = { :git => 'https://github.com/rene-dohan/CS-IOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CS-IOS/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CS-IOS' => ['CS-IOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'BlocksKit', '~> 2.2.5'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
  s.dependency 'CocoaLumberjack', '~> 3.4.1'
  s.dependency 'MMDrawerController', '~> 0.6.0'
  s.dependency 'SBJson', '~> 3.1.1'
  s.dependency 'ChameleonFramework'
  s.dependency 'MJRefresh', '~> 3.1.15.3'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'MZAppearance'
end
