#
# Be sure to run `pod lib lint Renetik-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Renetik'
  s.version          = '0.7.0'
  s.summary          = 'Library for rapid development of iOS apps with readable code and pleasure'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Library for rapid development of iOS apps with readable code and pleasure,
created out of passion to code my way and to improve readability of my codebase.
                       DESC

  s.homepage         = 'https://github.com/rene-dohan/renetik-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rene-dohan' => 'dohan.rene@gmail.com' }
  s.source           = { :git => 'https://github.com/rene-dohan/renetik-ios.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/RenetikSoftware'

  s.ios.deployment_target = '10.0'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Library/Classes/Core/**/*'
    ss.frameworks = 'UIKit'
    ss.dependency 'BlocksKit', '~> 2.2'
    ss.dependency 'MBProgressHUD', '~> 1.1'
  end

  s.subspec 'SBJson' do |ss|
      ss.source_files = 'Library/Classes/SBJson/**/*'
      ss.dependency 'Renetik/Core'
      ss.dependency 'SBJson', '~> 3.1.1'
  end
  
   s.subspec 'CocoaLumberjack' do |ss|
     ss.source_files = 'Library/Classes/CocoaLumberjack/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'CocoaLumberjack', '~> 3.4'
   end

   s.subspec 'TableController' do |ss|
     ss.source_files = 'Library/Classes/TableController/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'Renetik/RefreshControl'
     ss.dependency 'DZNEmptyDataSet','~> 1.8'
     ss.dependency 'ChameleonFramework', '~> 2.1'
     ss.resources = 'Library/Classes/TableController/TableController.bundle'
   end

   s.subspec 'CollectionController' do |ss|
     ss.source_files = 'Library/Classes/CollectionController/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'Renetik/RefreshControl'
     ss.dependency 'DZNEmptyDataSet','~> 1.8'
   end

   s.subspec 'RefreshControl' do |ss|
     ss.source_files = 'Library/Classes/RefreshControl/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'ChameleonFramework', '~> 2.1'
     ss.dependency 'MJRefresh', '~> 3.1'
   end

   s.subspec 'Pager' do |ss|
     ss.source_files = 'Library/Classes/Pager/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'MZAppearance', '~> 1.1'
     ss.dependency 'ChameleonFramework', '~> 2.1'
   end

   s.subspec 'AFNetworking' do |ss|
     ss.source_files = 'Library/Classes/AFNetworking/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'AFNetworking', '~> 3.0'
   end

   s.subspec 'Reachability' do |ss|
     ss.source_files = 'Library/Classes/Reachability/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'Reachability', '~> 3.0'
   end

   s.subspec 'SDWebImage' do |ss|
     ss.source_files = 'Library/Classes/SDWebImage/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'SDWebImage', '~> 5.0.0-beta'
   end

   s.subspec 'CSMessage' do |ss|
     ss.source_files = 'Library/Classes/CSMessage/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'RMessage', '~> 2.2'
   end

   s.subspec 'XLPagerTabStrip' do |ss|
     ss.source_files = 'Library/Classes/XLPagerTabStrip/**/*'
     ss.dependency 'Renetik/Core'
     ss.dependency 'XLPagerTabStrip', '~> 3.0'
   end

  #s.source_files = 'Library/Classes/**/*'
  #s.module_map = 'module.modulemap'
  
  # s.resource_bundles = {
  #   'Renetik' => ['Library/Assets/*.png']
  # }

  s.test_spec 'Tests' do |ts|
    ts.source_files = 'Library/Tests/**/*.{h,m,swift}'
    ts.frameworks = 'XCTest'
    ts.dependency 'Quick'
    ts.dependency 'Nimble'
  end

end
