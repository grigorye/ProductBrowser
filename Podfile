workspace 'ProductBrowser.xcworkspace'

platform :ios, '10.0'
use_frameworks!

def shared_non_test_pods
  pod 'Result', '~> 3.0'
  pod 'Swinject', '~> 2.4.0'
  pod 'SwinjectStoryboard', '~> 2.0.0-beta.1'
  pod 'Then', '~> 2.3.0'
  pod 'SwiftLint', '~> 0.25.1'
  pod 'RxSwift', '~> 4.1.2'
  pod 'RxDataSources'
  pod 'RxCocoa'
  pod 'RxCoreData'
  pod 'Moya'
  pod 'SDWebImage', '~> 4.3.3'
  pod 'Hero', '~> 1.2.0'
end

def all_test_pods
  pod 'Quick', '~> 1.3.0'
  pod 'Nimble', '~> 7.1.1'
  pod 'Then', '~> 2.3.0'
end

target 'ProductBrowserApp' do
  project 'Modules/ProductBrowserApp/ProductBrowserApp.xcodeproj'

  shared_non_test_pods

  # Pods for ProductBrowserApp

  target 'ProductBrowserAppTests' do
    inherit! :search_paths
    all_test_pods
  end

  target 'ProductBrowserAppUITests' do
    inherit! :search_paths
  end
end

target 'ProductBrowserAppKit' do
  project 'Modules/ProductBrowserAppKit/ProductBrowserAppKit.xcodeproj'
  
  shared_non_test_pods

  target 'ProductBrowserAppKitTests' do
    inherit! :search_paths
    
    all_test_pods
  end
end
