

Pod::Spec.new do |s|

  s.name         = "JWTableView"
  s.version      = "0.1.8"
  s.summary      = "JWTableView--一款自用的表格控件，封装了一些基本功能"

  #主页
  s.homepage     = "https://github.com/junwangInChina/JWTableView"
  #证书申明
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  #作者
  s.author       = { "wangjun" => "github_work@163.com" }
  #支持版本
  s.platform     = :ios, "7.1"
  #版本地址
  s.source       = { :git => "https://github.com/junwangInChina/JWTableView.git", :tag => s.version }

  #库文件路径（相对于.podspec文件的路径）
  s.source_files  = "JWTableView/JWTableView/JWTableView/**/*.{h,m}"
  #是否支持arc
  s.requires_arc = true
  #外用库
  s.dependency 'Masonry'

end
