echo -e "${YELLOW}正在启动 cloudflared 容器...${RESET}"
docker run -itd --name=cloudflared \
--network host \
cloudflare/cloudflared:latest \
tunnel --no-autoupdate --edge-ip-version auto --protocol http2 run --token eyJhIjoiNjQ1MTEzYmM3MWQ0MDgwMzA2ZmFmMWJhMmYyZmM4MGEiLCJ0IjoiNDhkZGUzOGQtNTZiYi00MjEyLWIxY2EtMGIyZGMzYzVhNWM4IiwicyI6IlpUZ3dZak5sWkRNdE1qQXlOUzAwWXpSaExXRTFZalV0TkRkaVl6ZGxZekF3TlRaaCJ9


chmod +x ./warp-plus 
cp ./warp-plus ./warp-plus1
cp ./warp-plus ./warp-plus2
cp ./warp-plus ./warp-plus3
cp ./warp-plus ./warp-plus4
cp ./warp-plus ./warp-plus5

nohup ./cloudflared tunnel --no-autoupdate --edge-ip-version auto --protocol http2 run --token eyJhIjoiNjQ1MTEzYmM3MWQ0MDgwMzA2ZmFmMWJhMmYyZmM4MGEiLCJ0IjoiNTU3NGY4ZTEtYmQzMS00MmY2LWIxYTYtZWFkOTE2ODNmMjhjIiwicyI6Ik9USmtOMk0yT1RBdE16TTNOUzAwTm1VeExUZzFZall0T0RobU1HVXdZMkU0T0dJeSJ9  >/dev/null 2>&1 & echo "$!" > ./cfpid.log
nohup ./sing-box run  >/dev/null 2>&1 & echo "$!" > ./sbpid.log
./warp-plus1 --bind 127.0.0.1:54322 --cfon --country JP
./warp-plus2 --bind 127.0.0.1:54323 --cfon --country AU
./warp-plus3 --bind 127.0.0.1:54324 --cfon --country GB
./warp-plus4 --bind 127.0.0.1:54325 --cfon --country US
./warp-plus5 --bind 127.0.0.1:54326 --cfon --country SG

nohup ./sing-box run  >/dev/null 2>&1 & echo "$!" > ./sbpid.log
nohup ./warp-plus --bind 127.0.0.1:54322 --cfon --country JP
nohup ./warp-plus --bind 127.0.0.1:54323 --cfon --country AU
nohup ./warp-plus --bind 127.0.0.1:54324 --cfon --country GB
nohup ./warp-plus --bind 127.0.0.1:54325 --cfon --country US
nohup ./warp-plus --bind 127.0.0.1:54326 --cfon --country SG


