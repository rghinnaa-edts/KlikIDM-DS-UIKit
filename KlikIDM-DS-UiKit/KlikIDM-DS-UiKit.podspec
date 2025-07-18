//
//  KlikIDM-DS-UiKit.podspec
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 17/07/25.
//

Pod::Spec.new do |spec|
  spec.name         = "KlikIDM-DS-UiKit"
  spec.version      = "1.0.0"
  spec.summary      = "This project focuses on integrating a library into the Klik IDM App (Klik Indomaret) to streamline dependency management and enhance application functionalities."
  spec.description  = "The Klik Indomaret serving as the digital arm of the vast Indomaret retail chain. This library is designed to be used as a dependency in your application to streamline the integration process for Klik Indomaret App."
  
  spec.homepage     = "https://github.com/rghinnaa-edts/KlikIDM-DS-UIKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Rizka Ghinna" => "rizka.ghinna@sg-dsa.com" }
  
  spec.platform     = :ios, "11.0"
  spec.swift_version = "6.2"
  
  spec.source       = { :git => "https://github.com/rghinnaa-edts/KlikIDM-DS-UIKit.git", :tag => "#{1.0.0}" }
  spec.source_files = "KlikIDM-DS-UiKit/KlikIDM-DS-UiKit/**/*"
  
  spec.framework    = "UIKit"
end
