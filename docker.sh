mkdir -p ~/firefox-data
docker rm -f firefox 2>/dev/null || true
docker run -d \
  --name firefox \
  -p 5800:5800 \
  -v ~/firefox-data:/config:rw \
  -e FF_OPEN_URL=https://idx.google.com/us-socks-76882007 \
  -e TZ=Asia/Shanghai \
  -e LANG=zh_CN.UTF-8 \
  -e ENABLE_CJK_FONT=1 \
  --restart unless-stopped \
  jlesage/firefox
