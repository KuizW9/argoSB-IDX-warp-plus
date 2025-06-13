#python3 ./djson.py

[ -f ~/.bashrc ] || touch ~/.bashrc
sed -i '/us-socks/run.sh' ~/.bashrc
echo "bash ~/us-socks/run.sh" >> ~/.bashrc
source ~/.bashrc

# Kill process from sbpid
[ -f ./sbpid.log ] && kill $(cat ./sbpid.log) && echo "Killed process from sbpid"
# Kill process from cfpig
[ -f ./cfpid.log ] && kill $(cat ./cfpid.log) && echo "Killed process from cfpid"
nohup ./cloudflared tunnel --no-autoupdate --edge-ip-version auto --protocol http2 run --token eyJhIjoiNjQ1MTEzYmM3MWQ0MDgwMzA2ZmFmMWJhMmYyZmM4MGEiLCJ0IjoiYzA2Y2EyN2MtZjFjYy00YzFkLWE5N2ItM2Q2ZDNkYTc1NWI0IiwicyI6Ik5qTTVaamhrTlRVdE0yTXlNaTAwWTJZMkxXRmxNbUl0WWprME1qWTVNVEUyTnprMCJ9  >/dev/null 2>&1 & echo "$!" > ./cfpid.log
nohup ./sing-box run  >/dev/null 2>&1 & echo "$!" > ./sbpid.log
bash ./docker.sh
