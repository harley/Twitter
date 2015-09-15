source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Leave use_frameworks uncommeted for BDBOAuth1Manager to work
# use_frameworks!

def shared_pods
  pod "AFNetworking", '~> 2.5.4'
  pod "BDBOAuth1Manager"
  pod 'DateTools'
end

target 'Twitter' do
  shared_pods
end

target 'TwitterTests' do
  shared_pods
end

