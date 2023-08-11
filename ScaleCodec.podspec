Pod::Spec.new do |s|
  s.name             = 'ScaleCodec'
  s.version          = '999.99.9'
  s.summary          = 'SCALE codec implementation for Swift language'

  s.description      = <<-DESC
  SCALE codec implementation for Swift language. Supports all SCALE standard types.
                       DESC

  s.homepage         = 'https://github.com/tesseract-one/ScaleCodec.swift'

  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Tesseract Systems, Inc.' => 'info@tesseract.one' }
  s.source           = { :git => 'https://github.com/tesseract-one/ScaleCodec.swift.git', :tag => s.version.to_s }

  s.swift_version    = '5.4'
  s.module_name      = 'ScaleCodec'
  
  base_platforms     = { :ios => '11.0', :osx => '10.13', :tvos => '11.0' }
  s.platforms        = base_platforms.merge({ :watchos => '6.0' })

  s.source_files     = 'Sources/ScaleCodec/**/*.swift'
  
  s.dependency 'Tuples', '~> 0.1.0'
  
  s.test_spec 'Tests' do |ts|
    ts.platforms = base_platforms
    ts.source_files = 'Tests/ScaleCodecTests/**/*.swift'
  end
end
