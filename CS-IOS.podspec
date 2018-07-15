#
# Be sure to run `pod lib lint CS-IOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CS-IOS'
  s.version          = '0.6.0'
  s.summary          = 'Library for rapid development of apps with readable code'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
...
                       DESC

  s.homepage         = 'https://github.com/rene-dohan/CS-IOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rene-dohan' => 'dohan.rene@gmail.com' }
  s.source           = { :git => 'https://github.com/rene-dohan/CS-IOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/renetik'

  s.ios.deployment_target = '9.0'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'CS-IOS/Classes/Core/**/*'
    ss.frameworks = 'UIKit'
    ss.dependency 'BlocksKit', '~> 2.2'
    ss.dependency 'MBProgressHUD', '~> 1.1'
  end

  s.subspec 'SBJson' do |ss|
      ss.source_files = 'CS-IOS/Classes/SBJson/**/*'
      ss.dependency 'CS-IOS/Core'
      ss.dependency 'SBJson', '~> 3.1.1'
  end
  
   s.subspec 'CocoaLumberjack' do |ss|
     ss.source_files = 'CS-IOS/Classes/CocoaLumberjack/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'CocoaLumberjack', '~> 3.4'
   end

   s.subspec 'TableController' do |ss|
     ss.source_files = 'CS-IOS/Classes/TableController/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'CS-IOS/RefreshControl'
     ss.dependency 'DZNEmptyDataSet','~> 1.8'
     ss.dependency 'ChameleonFramework', '~> 2.1'
   end

   s.subspec 'CollectionController' do |ss|
     ss.source_files = 'CS-IOS/Classes/CollectionController/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'CS-IOS/RefreshControl'
     ss.dependency 'DZNEmptyDataSet','~> 1.8'
   end

   s.subspec 'RefreshControl' do |ss|
     ss.source_files = 'CS-IOS/Classes/RefreshControl/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'ChameleonFramework', '~> 2.1'
     ss.dependency 'MJRefresh', '~> 3.1'
   end

   s.subspec 'Pager' do |ss|
     ss.source_files = 'CS-IOS/Classes/Pager/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'MZAppearance', '~> 1.1'
     ss.dependency 'ChameleonFramework', '~> 2.1'
   end

   s.subspec 'AFNetworking' do |ss|
     ss.source_files = 'CS-IOS/Classes/AFNetworking/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'AFNetworking', '~> 3.0'
   end

   s.subspec 'Reachability' do |ss|
     ss.source_files = 'CS-IOS/Classes/Reachability/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'Reachability', '~> 3.0'
   end

   s.subspec 'SDWebImage' do |ss|
     ss.source_files = 'CS-IOS/Classes/SDWebImage/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'SDWebImage', '~> 4.0'
   end

   s.subspec 'RMessage' do |ss|
     ss.source_files = 'CS-IOS/Classes/RMessage/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'RMessage', '~> 2.2'
   end

   s.subspec 'XLPagerTabStrip' do |ss|
     ss.source_files = 'CS-IOS/Classes/XLPagerTabStrip/**/*'
     ss.dependency 'CS-IOS/Core'
     ss.dependency 'XLPagerTabStrip', '~> 3.0'
   end

  #s.source_files = 'CS-IOS/Classes/**/*'
  #s.module_map = 'module.modulemap'
  
  # s.resource_bundles = {
  #   'CS-IOS' => ['CS-IOS/Assets/*.png']
  # }

end
