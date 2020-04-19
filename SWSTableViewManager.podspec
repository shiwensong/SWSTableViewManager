#
#  Be sure to run `pod spec lint SWSTableViewManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "SWSTableViewManager"
  spec.version      = "0.1.9"
  spec.summary      = "tableView的管理类."
  spec.homepage     = "https://github.com/shiwensong/SWSTableViewManager"
  spec.license      = "MIT"
  spec.author             = { "shiwensong" => "18996601419@189.cn" }
  spec.platform     = :ios
  spec.source       = { :git => "https://github.com/shiwensong/SWSTableViewManager.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes/SWSTableViewManager/**/*.{h,m}"
  spec.public_header_files = "Classes/SWSTableViewManager/SWSTableViewManager.h"
end
