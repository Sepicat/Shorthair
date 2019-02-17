Pod::Spec.new do |s|
  s.name         = "Shorthair"
  s.version      = "0.1.0"
  s.summary      = "The issue and pull request UI framework"
  s.description  = <<-DESC
  The issue and pull request UI framework
                   DESC
  s.homepage     = "http://desgard.com"
  s.license      = "GPL-3.0"
  s.author       = { "Harry Twan" => "gua@desgard.com" }
  s.source       = { :git => "https://github.com/Sepicat/Shorthair.git", :tag => "0.1.0" }
  s.source_files  =  "Shorthair/Shorthair/**/*.{swift}"
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.dependency 'SnapKit', '~> 4.2.0'
  s.dependency 'YYText', '~> 1.0.4'
  s.dependency 'YYAsyncLayer', '~> 1.0'
end
