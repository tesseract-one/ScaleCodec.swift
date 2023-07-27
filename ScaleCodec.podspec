Pod::Spec.new do |s|
  s.name             = 'ScaleCodec'
  s.version          = '0.3.0'
  s.summary          = 'SCALE codec implementation for Swift language'

  s.description      = <<-DESC
SCALE codec implementation for Swift language. Supports all SCALE standard types.
                       DESC

  s.homepage         = 'https://github.com/tesseract-one/ScaleCodec.swift'

  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Tesseract Systems, Inc.' => 'info@tesseract.one' }
  s.source           = { :git => 'https://github.com/tesseract-one/ScaleCodec.swift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  
  s.swift_version = '5'

  s.module_name = 'ScaleCodec'

  s.source_files = 'Sources/ScaleCodec/**/*.swift', 'Sources/DoubleWidth/*.swift'
  
  s.test_spec 'Tests' do |test_spec|
    test_spec.platforms = {:ios => '9.0', :osx => '10.10', :tvos => '9.0'}
    test_spec.source_files = 'Tests/ScaleCodecTests/**/*.swift', 'Tests/DoubleWidthTests/DoubleWidthTests.swift'
  end
end
