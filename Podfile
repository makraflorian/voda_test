# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '12.0'

target 'VodaTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VodaTest
  pod 'Moya', '~> 15.0'

end

target 'VodaTestTests' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for VodaTest
  pod 'Moya', '~> 15.0'
  
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
  end
 end
end
