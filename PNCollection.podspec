Pod::Spec.new do |s|
  s.name         = "PNCollection"
  s.version      = "1.0.3"
  s.summary      = "A lib support for handle with infinite collection view, marquee, cardsliders"
  s.description  = <<-DESC
  A lib support for handle with infinite collection view, marquee, cardsliders use for special UI
  DESC
  s.homepage     = "https://github.com/jokerphuongnam/PNCollection"
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
  s.author             = { "Pham P Nam" => "phuongnamp99@gmail.com" }
  s.ios.deployment_target = "9.0"
  s.swift_version = "5.0"
  s.source       = { :git => "https://github.com/jokerphuongnam/PNCollection.git", :tag => s.version.to_s }
  s.source_files  = "Sources/PNCollection/**/*.{swift}"
end
