# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'All-In' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for All-In


pod 'Kingfisher'

  target 'All-InTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'All-InUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'MyPOD' 
                config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'Yes'
            end
        end
    end
end