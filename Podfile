platform :ios, '8.0'
use_frameworks!

target 'm8s' do

  pod 'FBSDKCoreKit', '~> 4.10'
  pod 'FBSDKLoginKit', '~> 4.10'
  pod 'FBSDKShareKit', '~> 4.10'
  pod 'SlideMenuControllerSwift', '~> 2.1.1'
  pod 'Koloda', '~> 3.0.0'
  pod "FMMosaicLayout"
  pod "Firebase"
  pod "Firebase/Auth"
  pod "Firebase/Database"
  pod "Firebase/Storage"
  pod 'FontAwesome.swift'

end

post_install do |installer|
  `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end