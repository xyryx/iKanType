use_frameworks!
platform :ios, '10.2'

target 'iKanType' do
pod 'JSONModel'
pod 'ObjectMapper', '~> 2.1.0'
pod 'nlp', :path => '../nlp'
end

target 'Keyboard' do
pod 'JSONModel'
pod 'ObjectMapper', '~> 2.1.0'
pod 'nlp', :path => '../nlp'
end

target 'Kannada' do
pod 'JSONModel'
pod 'ObjectMapper', '~> 2.1.0'
pod 'nlp', :path => '../nlp'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

