#
# Be sure to run `pod lib lint CountdownView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CountdownView'
  s.version          = '0.1.0'
  s.summary          = 'This is the summary of CountdownView and what it can do. This should be meaningful.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = 'This is a iOS library that can be used to create a view that manages the counting down from a date to another date. This comes with theme support, as well as customisation in terms of the options that are displayed.'
  s.swift_version    = '4.2'
  s.homepage         = 'https://github.com/lukesgridstone/CountdownView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lukesgridstone' => 'lukes@gridstone.com.au' }
  s.source           = { :git => 'https://github.com/lukesgridstone/CountdownView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.source_files = 'CountdownView/Classes/**/*'
end