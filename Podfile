# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'

target 'GameDex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GameDex
  pod 'SwiftLint'
  pod 'SwiftGen', '~> 6.0'
  pod 'EmptyDataSet-Swift', '~> 5.0.0'
  pod 'NVActivityIndicatorView'
  pod 'DTTextField'
  pod 'IQKeyboardManagerSwift', '~> 6.5.0'
  pod "SwiftyMocky"
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'SwiftyTextView'
  pod 'Cosmos', '~> 23.0'
  pod 'SwiftEntryKit', '2.0.0'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseCrashlytics'
  pod 'ReachabilitySwift'
  

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
