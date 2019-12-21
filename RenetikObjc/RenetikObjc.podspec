#
# Be sure to run `pod lib lint RenetikObjc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RenetikObjc'
  s.version          = '0.8.0'
  s.summary          = 'Library for rapid development of iOS apps with readable code and pleasure'

	s.description      = <<-DESC
		Library for rapid development of iOS apps with readable code and pleasure,
		created out of passion to code my way and to improve readability of my codebase.
                       DESC

  s.homepage         = 'https://github.com/rene-dohan/renetik-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rene-dohan' => 'dohan.rene@gmail.com' }
  s.source           = { :git => 'https://github.com/rene-dohan/renetik-ios.git',
												 :tag => s.version.to_s }
  s.social_media_url = 'https://renetik-software.github.io'
  s.ios.deployment_target = '10.0'
  s.default_subspecs = 'All'
	s.prefix_header_file = 'Library/Classes/RenetikObjc.pch'
	
  s.subspec 'Core' do |ss|
    ss.source_files = 'Library/Classes/Core/**/*'
    ss.frameworks = 'UIKit'
    ss.dependency 'BlocksKit', '~> 2.2'
    ss.dependency 'MBProgressHUD', '~> 1.1'
    ss.dependency 'AFNetworking', '~> 3.0'
  end

#   s.subspec 'SBJson' do |ss|
#       ss.source_files = 'Library/Classes/SBJson/**/*'
#       ss.dependency 'RenetikObjc/Core'
#       ss.dependency 'SBJson', '~> 3.1'
#   end
  
   s.subspec 'CocoaLumberjack' do |ss|
     ss.source_files = 'Library/Classes/CocoaLumberjack/**/*'
     ss.dependency 'RenetikObjc/Core'
     ss.dependency 'CocoaLumberjack/Swift', '~> 3.4'
   end

#    s.subspec 'TableController' do |ss|
#      ss.source_files = 'Library/Classes/TableController/*'
#      ss.resources = 'Library/Classes/TableController/TableController.bundle'
#      ss.dependency 'RenetikObjc/Core'
#      ss.dependency 'RenetikObjc/RefreshControl'
#      ss.dependency 'DZNEmptyDataSet','~> 1.8'
#      ss.dependency 'ChameleonFramework', '~> 2.1'
#    end

#    s.subspec 'CollectionController' do |ss|
#      ss.source_files = 'Library/Classes/CollectionController/**/*'
#      ss.dependency 'RenetikObjc/Core'
#      ss.dependency 'RenetikObjc/RefreshControl'
#      ss.dependency 'DZNEmptyDataSet','~> 1.8'
#    end

   s.subspec 'RefreshControl' do |ss|
     ss.source_files = 'Library/Classes/RefreshControl/**/*'
     ss.dependency 'RenetikObjc/Core'
     ss.dependency 'ChameleonFramework', '~> 2.1'
     ss.dependency 'MJRefresh', '~> 3.1'
   end

#    s.subspec 'Pager' do |ss|
#      ss.source_files = 'Library/Classes/Pager/**/*'
#      ss.dependency 'RenetikObjc/Core'
#      ss.dependency 'MZAppearance', '~> 1.1'
#      ss.dependency 'ChameleonFramework', '~> 2.1'
#    end

#    s.subspec 'AFNetworking' do |ss|
#      ss.source_files = 'Library/Classes/AFNetworking/**/*'
#      ss.dependency 'RenetikObjc/Core'
#      ss.dependency 'AFNetworking', '~> 3.0'
#    end

#    s.subspec 'Reachability' do |ss|
#      ss.source_files = 'Library/Classes/Reachability/**/*'
#      ss.dependency 'RenetikObjc/Core'
#      ss.dependency 'Reachability', '~> 3.0'
#    end

   s.subspec 'SDWebImage' do |ss|
     ss.source_files = 'Library/Classes/SDWebImage/**/*'
     ss.dependency 'RenetikObjc/Core'
     ss.dependency 'SDWebImage', '~> 5.3'
   end

#    s.subspec 'XLPagerTabStrip' do |ss|
#      ss.source_files = 'Library/Classes/XLPagerTabStrip/**/*'
#      ss.dependency 'RenetikObjc/Core'
#      ss.dependency 'XLPagerTabStrip', '~> 3.0'
#    end

   s.subspec 'All' do |ss|
		ss.dependency 'RenetikObjc/Core'
# 		ss.dependency 'RenetikObjc/SBJson'
		ss.dependency 'RenetikObjc/CocoaLumberjack'
# 		ss.dependency 'RenetikObjc/TableController'
# 		ss.dependency 'RenetikObjc/CollectionController'
		ss.dependency 'RenetikObjc/RefreshControl'
# 		ss.dependency 'RenetikObjc/Pager'
# 		ss.dependency 'RenetikObjc/AFNetworking'
# 		ss.dependency 'RenetikObjc/Reachability'
		ss.dependency 'RenetikObjc/SDWebImage'
# 		ss.dependency 'RenetikObjc/XLPagerTabStrip'
	end
	 
#	 s.test_spec 'Tests' do |test|
##		 test.requires_app_host = true
#		 test.source_files = 'Library/Tests/*.{h,m,swift}'
##		 test.dependency 'RenetikObjc/All'
#		 test.dependency 'Quick', '~> 2.1.0'
#		 test.dependency 'Nimble', '~> 8.0.2'
#	 end
end
