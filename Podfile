# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

target 'memeinator3000' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  # use_modular_headers! 
  # CHANGE THIS TO use_frameworks! WHEN USING REAL iOS DEV ACCOUNT
  use_frameworks!

  # Pods for memeinator3000
  pod 'IQKeyboardManagerSwift'
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Google-Mobile-Ads-SDK'
  pod 'Fabric'
  pod 'Hero'  

  target 'memeinator3000Tests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'm3Keys' do
  use_frameworks!

  pod 'KeyboardKit'
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
      end
   end
end
