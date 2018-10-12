# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'refNot' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for refNot
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'RxFlow'
  pod 'Realm', '~> 3.10'
  pod 'SnapKit', '~> 4.0'
  pod 'Moya/RxSwift', '~> 11.0', :inhibit_warnings => true
  pod 'SwiftyJSON', '~> 4.2'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  
  target 'refNotTests' do
    inherit! :search_paths
    
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
    
  end

  target 'refNotUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
