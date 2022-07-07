Pod::Spec.new do |s|
  s.swift_version    = '5.0'
  s.name             = 'QWarySurveySDK'
  s.version          = '1.0.0'
  s.summary          = 'QwarySurvey SDK'

  s.description      = <<-DESC
  QwarySurvey SDK
                       DESC

  s.homepage         = 'https://gitlab.com/Shehryar3/qwarysurvey/'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author           = { 'Fahid Attique' => 'fahad@techmatetech.com' }
  s.source           = { :git => 'https://gitlab.com/Shehryar3/qwarysurvey.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.source_files = 'QWarySurvey/SDK/**/*.{swift}'

end
