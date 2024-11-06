platform :ios, '12.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target 'Podcast' do
  use_frameworks!
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'FeedKit'

  target 'PodcastUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
