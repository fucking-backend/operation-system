## 命令

```bash
# 下载一个网站
curl http://www.google.com
# 下载网站，存储到html文件中
curl www.likegeeks.com --output likegeeks.html

# 跟踪重定向。如果在尝试 cURL 网站时得到空输出，则可能意味着该网站告诉 cURL 重定向到不同的 URL
curl -L www.likegeeks.com

# 断点续传
# -C 开关用于恢复我们的文件传输，短划线 (-)告诉 cURL 恢复文件传输，但首先查看已下载的部分
curl -C - example.com/some-file.zip --output MyFile.zip

# 过期时间
curl -m 60 example.com
# 连接过期时间
curl --connect-timeout 60 example.com

# 指定账户名和密码
curl -u username:password ftp://example.com


# 使用代理
curl -x 192.168.1.1:8080 http://example.com

# 分片下载
curl --range 0-99999999 http://releases.ubuntu.com/18.04/ubuntu-18.04.3-desktop-amd64.iso ubuntu-part1
curl --range 100000000-199999999 http://releases.ubuntu.com/18.04/ubuntu-18.04.3-desktop-amd64.iso ubuntu-part2


# 指定正书
curl --cert path/to/cert.crt:password ftp://example.com

# 静默（取消 cURL 的进度表和错误消息）
curl -s  www.baidu.com -o baidu.html
curl -s http://example.com --output index.html


# 获取头信息
curl -I -L example.com


# 添加多个请求头
curl -H 'Connection: keep-alive' -H 'Accept-Charset: utf-8 ' http://example.com


# post请求
curl -d 'name=geek&location=usa' http://example.com

# 上传文件
curl -d @filename http://example.com

# ftp上传文件
curl -T myfile.txt ftp://example.com/some/directory/


# 发送邮件
curl smtp://mail.example.com --mail-from me@example.com --mail-rcpt john@domain.com --upload-file email.txt
# 读取邮件
curl -u username:password imap://mail.example.com -X 'UID FETCH 1234'
```

### curl和wget区别

wget 是下载网站的最佳工具，能够递归遍历目录和链接以下载整个网站。


