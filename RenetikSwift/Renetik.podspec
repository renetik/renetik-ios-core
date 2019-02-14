#
# Be sure to run `pod lib lint RenetikSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Renetik'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RenetikSwift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rene-dohan/renetik-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rene-dohan' => 'dohan.rene@gmail.com' }
  s.source           = { :git => 'https://github.com/rene-dohan/renetik-ios.git', :tag => s.version.to_s }
  s.social_media_url = 'https://facebook.com/renetiksoftware'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Library/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Renetik' => ['Library/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
	# s.dependency 'RenetikObjc', '0.7.0'
	
	s.default_subspecs = 'All'
	
	s.subspec 'Core' do |ss|
		ss.dependency 'RenetikObjc/Core', '~> 0.7.0'
		ss.source_files = 'Library/Classes/Core/**/*'
	end

	s.subspec 'SBJson' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/SBJson', '~> 0.7.0'
	end

	s.subspec 'CocoaLumberjack' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/CocoaLumberjack', '~> 0.7.0'
		ss.source_files = 'Library/Classes/CocoaLumberjack/**/*'
	end

	s.subspec 'TableController' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/TableController', '~> 0.7.0'
	end
   
	s.subspec 'CollectionController' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/CollectionController', '~> 0.7.0'
	end
   
	s.subspec 'RefreshControl' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/RefreshControl', '~> 0.7.0'
	end
   
	s.subspec 'Pager' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/Pager', '~> 0.7.0'
	end

	s.subspec 'AFNetworking' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/AFNetworking', '~> 0.7.0'
		ss.source_files = 'Library/Classes/AFNetworking/**/*'
		ss.dependency 'AFNetworking', '~> 3.0'
	end
   
	s.subspec 'Reachability' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/Reachability', '~> 0.7.0'
	end
   
	s.subspec 'SDWebImage' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/SDWebImage', '~> 0.7.0'
	end
   
	s.subspec 'CSMessage' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/CSMessage', '~> 0.7.0'
	end
   
	s.subspec 'XLPagerTabStrip' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'RenetikObjc/XLPagerTabStrip', '~> 0.7.0'
	end
	
	s.subspec 'DTCoreText' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'DTCoreText'
		ss.dependency 'IDMPhotoBrowser'
		ss.dependency 'ARChromeActivity'
		ss.dependency 'TUSafariActivity'
		ss.source_files = 'Library/Classes/DTCoreText/**/*'
	end

	s.subspec 'All' do |ss|
		ss.dependency 'Renetik/Core'
		ss.dependency 'Renetik/SBJson'
		ss.dependency 'Renetik/CocoaLumberjack'
		ss.dependency 'Renetik/TableController'
		ss.dependency 'Renetik/CollectionController'
		ss.dependency 'Renetik/RefreshControl'
		ss.dependency 'Renetik/Pager'
		ss.dependency 'Renetik/AFNetworking'
		ss.dependency 'Renetik/Reachability'
		ss.dependency 'Renetik/SDWebImage'
		ss.dependency 'Renetik/CSMessage'
		ss.dependency 'Renetik/XLPagerTabStrip'
		ss.dependency 'Renetik/DTCoreText'
	end
	
	s.test_spec 'Tests' do |ts|
		ts.source_files = 'Library/Tests/**/*.{h,m,swift}'
		ts.frameworks = 'XCTest'
		ts.dependency 'Quick'
		ts.dependency 'Nimble'
	end
end
