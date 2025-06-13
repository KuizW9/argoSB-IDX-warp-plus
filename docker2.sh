echo -e "${YELLOW}正在启动 VNC-FireFox2 容器...${RESET}"
docker kill firefox2
docker run -itd \
  --name=firefox2 \
  --security-opt seccomp=unconfined \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e CUSTOM_USER=kuiz \
  -e PASSWORD=kuizkuiz \
  -p 3000:3000 \
  -p 3001:3001 \
  -v ~/firefox2:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  lscr.io/linuxserver/firefox:latest
