platform :ios, '13.0'

use_frameworks!

workspace 'App'

def core_pods
  pod 'SwiftLint', :configurations => ['Debug']
  pod 'SwiftGen', '6.1.0', :configurations => ['Debug']

  pod 'ModelsMapper'

  pod 'Moya/Combine', '~> 15.0.0-alpha.1'
end

def data_pods
  core_pods
end

def presentation_pods
  core_pods
  pod 'SwiftMessages'
  pod 'SDWebImageSwiftUI'
end

target 'Core' do
  project 'Common/Core/Core.project'
  core_pods
end

target 'Data' do
  project 'Common/Data/Data.project'
  data_pods
end

target 'Presentation' do
  project 'Common/Presentation/Presentation.project'
  presentation_pods
end

target 'App' do
  project 'App.project'
  core_pods
  presentation_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
  end
end
