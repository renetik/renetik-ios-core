#
# Be sure to run 'pod lib lint RenetikObjc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = 'RenetikObjc'
  s.version = '0.9'
  s.summary = 'Library for rapid development of iOS apps with readable code and pleasure.'

  s.description = <<-DESC
		Library for rapid development of iOS apps with readable code and pleasure,
		created out of passion to code my way and to improve readability of my codebase.
  DESC

  s.homepage = 'https://github.com/rene-dohan/renetik-ios'
  s.license = {:type => 'MIT', :file => 'LICENSE'}
  s.author = {'rene-dohan' => 'dohan.rene@gmail.com'}
  s.source = {:git => 'https://github.com/rene-dohan/renetik-ios.git',
              :tag => s.version.to_s}
  s.social_media_url = 'https://renetik-software.github.io'
  s.ios.deployment_target = '11.0'
  s.default_subspecs = 'All'
  s.prefix_header_file = 'Library/Classes/RenetikObjc.pch'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Library/Classes/Core/**/*'
    ss.frameworks = 'UIKit'
    ss.dependency 'MBProgressHUD', '~> 1.1' # Could be moved to subspec
    ss.dependency 'AFNetworking', '~> 3.0' # CSResponse should be moved to subspec
    ss.dependency 'BlocksKit', '~> 2.2' # Could be moved to subspec maybe
  end

  s.subspec 'CocoaLumberjack' do |ss|
    ss.source_files = 'Library/Classes/CocoaLumberjack/**/*'
    ss.dependency 'RenetikObjc/Core'
    ss.dependency 'CocoaLumberjack/Swift', '~> 3.6'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'RenetikObjc/Core'
    ss.dependency 'RenetikObjc/CocoaLumberjack'
  end
end
