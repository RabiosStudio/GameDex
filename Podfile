# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'
inhibit_all_warnings!

target 'GameDex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GameDex
  pod 'SwiftLint', :inhibit_warnings => true
  pod 'SwiftGen', '~> 6.0', :inhibit_warnings => true
  pod 'EmptyDataSet-Swift', '~> 5.0.0', :inhibit_warnings => true
  pod 'NVActivityIndicatorView', :inhibit_warnings => true
  pod 'DTTextField', :inhibit_warnings => true
  pod 'IQKeyboardManagerSwift', '~> 6.5.0', :inhibit_warnings => true
  pod "SwiftyMocky", :inhibit_warnings => true
  pod 'Alamofire', :inhibit_warnings => true
  pod 'SDWebImage', :inhibit_warnings => true
  pod 'SwiftyTextView', :inhibit_warnings => true
  pod 'Cosmos', '~> 23.0', :inhibit_warnings => true
  pod 'SwiftEntryKit', :git => 'https://github.com/RabiosStudio/SwiftEntryKit.git', :branch => 'master', :inhibit_warnings => true
  pod 'FirebaseAuth', :inhibit_warnings => true
  pod 'FirebaseFirestore', :inhibit_warnings => true
  pod 'FirebaseCrashlytics', :inhibit_warnings => true
  pod 'ReachabilitySwift', :inhibit_warnings => true
  pod 'BetterSegmentedControl', :inhibit_warnings => true
  

  target 'GameDexTests' do
    inherit! :search_paths
    # Pods for testing
  end
 
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
                  config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
               end
          end
   end
end
