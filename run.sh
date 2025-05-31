echo -e "${YELLOW}正在启动 cloudflared 容器...${RESET}"
docker run -itd --name=cloudflared \
--network host \
cloudflare/cloudflared:latest \
tunnel --no-autoupdate --edge-ip-version auto --protocol http2 run --token eyJhIjoiNjQ1MTEzYmM3MWQ0MDgwMzA2ZmFmMWJhMmYyZmM4MGEiLCJ0IjoiNDhkZGUzOGQtNTZiYi00MjEyLWIxY2EtMGIyZGMzYzVhNWM4IiwicyI6IlpUZ3dZak5sWkRNdE1qQXlOUzAwWXpSaExXRTFZalV0TkRkaVl6ZGxZekF3TlRaaCJ9


chmod +x ./warp-plus 
nohup ./warp-plus --bind 127.0.0.1:1080 --cfon --country JP
nohup ./warp-plus --bind 127.0.0.1:1081 --cfon --country AU
nohup ./warp-plus --bind 127.0.0.1:1082 --cfon --country UK
nohup ./warp-plus --bind 127.0.0.1:1083 --cfon --country US
nohup ./warp-plus --bind 127.0.0.1:1084 --cfon --country SG

