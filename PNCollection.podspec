Pod::Spec.new do |s|
  s.name         = "PNCollection"
  s.version      = "1.0.0"
  s.summary      = "A lib support for handle with infinite collection view, marquee, cardsliders"
  s.description  = <<-DESC
  A lib support for handle with infinite collection view, marquee, cardsliders
  DESC
  s.homepage     = "https://github.com/jokerphuongnam/PNCollection"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Juanpe Catalán" => "juanpecm@gmail.com" }
  s.social_media_url   = "https://twitter.com/JuanpeCatalan"
  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"
  s.swift_version = "5.0"
  s.source       = { :git => "https://github.com/jokerphuongnam/PNCollection.git", :tag => s.version.to_s }
  s.source_files  = "PNCollection/Sources/Sources/**/*.{swift,h}"
end
