Pod::Spec.new do |spec|
  spec.name         = "KlikIDM-DS-UiKit"
  spec.version      = "0.1.0"
  spec.summary      = "UI Components and Animation"
  spec.description  = "UI Components and Animation of Klik Indomaret Apps"
  
  spec.homepage     = "https://github.com/rghinnaa-edts/KlikIDM-DS-UIKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Rizka Ghinna" => "rizka.ghinna@sg-dsa.com" }
  
  spec.platform     = :ios, "12.0"
  spec.swift_version = "6.2"
  
  spec.source       = { :git => "https://github.com/rghinnaa-edts/KlikIDM-DS-UIKit.git", :tag => spec.version.to_s }
  spec.source_files = "KlikIDM-DS-UiKit/**/*.{h,m,swift}"
  spec.resources    = "KlikIDM-DS-UiKit/**/*.xcassets"
  spec.resources    = "KlikIDM-DS-UiKit/Images.xcassets"
  
  spec.framework    = "UIKit"
end
