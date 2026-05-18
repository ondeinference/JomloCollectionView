Pod::Spec.new do |s|
  s.name             = 'JomloCollectionView'
  s.version          = '1.0.0'
  s.swift_version    = '6.0'
  s.summary          = 'A declarative, section-driven UICollectionView compositional layout engine.'

  s.description      = <<~DESC
    JomloCollectionView is a protocol-oriented UICollectionView compositional layout engine
    for iOS and tvOS. Build complex, streaming-service-style collection views with minimal
    boilerplate. Features include built-in layout presets (hero, shelf, grid, list), diffable
    data source integration, self-configuring cells, declarative animations, and full Swift 6
    strict concurrency support.
  DESC

  s.homepage         = 'https://github.com/setoelkahfi/JomloCollectionView'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Seto Elkahfi' => 'setoelkahfi@gmail.com' }
  s.source           = { git: 'https://github.com/setoelkahfi/JomloCollectionView.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/setoelkahfi'

  s.ios.deployment_target = '17.0'
  s.tvos.deployment_target = '17.0'

  s.source_files = 'Sources/JomloCollectionView/**/*.swift'

  s.frameworks = 'UIKit'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '6.0',
    'SWIFT_STRICT_CONCURRENCY' => 'complete'
  }
end
