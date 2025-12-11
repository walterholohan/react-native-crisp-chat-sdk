require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-crisp-chat-sdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "15.1" }
  s.source       = { :git => "https://github.com/walterholohan/react-native-crisp-chat-sdk.git", :tag => "#{s.version}" }


  s.source_files = "ios/**/*.{h,m,mm,swift}"

  s.swift_version = '5.0'

  install_modules_dependencies(s)

  # Crisp dependency
  s.dependency "Crisp", "2.12.0"
end
