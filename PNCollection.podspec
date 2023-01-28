Pod::Spec.new do |s|
  s.name         = "PNCollection"
  s.version      = "1.0.0"
  s.summary      = "A lib support for handle with infinite collection view, marquee, cardsliders"
  s.description  = <<-DESC
  A lib support for handle with infinite collection view, marquee, cardsliders use for special UI
  DESC
  s.homepage     = "https://github.com/jokerphuongnam/PNCollection"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Juanpe Catalán" => "phuongnamp99@gmail.com" }
  s.ios.deployment_target = "9.0"
  s.swift_version = "5.0"
  s.source       = { :git => "https://github.com/jokerphuongnam/PNCollection.git", :tag => s.version.to_s }
  s.source_files  = "Sources/PNCollection/**/*.{swift}"
end