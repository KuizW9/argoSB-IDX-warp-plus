echo -e "${YELLOW}正在启动 cloudflared 容器...${RESET}"
docker run -itd --name=cloudflared \
--network host \
cloudflare/cloudflared:latest \
tunnel --no-autoupdate --edge-ip-version auto --protocol http2 run --token eyJhIjoiNjQ1MTEzYmM3MWQ0MDgwMzA2ZmFmMWJhMmYyZmM4MGEiLCJ0IjoiNDhkZGUzOGQtNTZiYi00MjEyLWIxY2EtMGIyZGMzYzVhNWM4IiwicyI6IlpUZ3dZak5sWkRNdE1qQXlOUzAwWXpSaExXRTFZalV0TkRkaVl6ZGxZekF3TlRaaCJ9


chmod +x ./warp-plus 
nohup ./warp-plus --bind 127.0.0.1:1080 --cfon --country JP >/dev/null 2>&1 & echo "$!" > ./sbpid1.log
nohup ./warp-plus --bind 127.0.0.1:1081 --cfon --country AU >/dev/null 2>&1 & echo "$!" > ./sbpid2.log
nohup ./warp-plus --bind 127.0.0.1:1082 --cfon --country UK >/dev/null 2>&1 & echo "$!" > ./sbpid3.log
nohup ./warp-plus --bind 127.0.0.1:1083 --cfon --country US >/dev/null 2>&1 & echo "$!" > ./sbpid4.log
nohup ./warp-plus --bind 127.0.0.1:1084 --cfon --country SG >/dev/null 2>&1 & echo "$!" > ./sbpid5.log

