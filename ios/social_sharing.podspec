#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'social_sharing'
  s.version          = '1.0.0'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A Sharing With Social Project
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'GENIUS_ME' => 'konszhog@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'FacebookShare'
  s.dependency 'FacebookCore'
  s.dependency 'FacebookLogin'
  s.dependency 'TwitterKit'
  s.static_framework = true

  s.ios.deployment_target = '8.0'
end

