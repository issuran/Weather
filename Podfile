# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
  pod 'Kingfisher'
  pod 'Aquino', '1.0.1'
end

target 'Weather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  plugin 'cocoapods-keys', {
    :project => "Weather",
    :keys => [
      "ApiKey"
  ]}

  # Pods for Weather
  shared_pods
end

target 'WeatherUITests' do
  pod 'KIF', :configurations => ['Debug']
  shared_pods
end
