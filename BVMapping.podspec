Pod::Spec.new do |s|
  s.name         = "BVMapping"
  s.version      = "0.0.1"
  s.summary      = "An XML/JSON parser for IOS."
  s.homepage     = "https://github.com/vvbogdan/"
  s.license      = 'MIT (LICENCE)'
  s.author       = { "Vitalii Bogdan" => "bogdan.vitalik@gmail.com" }
  s.source       = { :git => "https://github.com/vvbogdan/bvmapping.git", :tag => "0.0.1" }

  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.library   = 'xml2'
  s.requires_arc = true
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  s.dependency 'GDataXML-HTML', '~> 1.1.0'
end
