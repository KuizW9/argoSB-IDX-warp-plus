import json
import uuid
import base64

def generate_config():
    config = {
        "log": {
            "disabled": False,
            "level": "info",
            "timestamp": True
        },
        "route": {
            "auto_detect_interface": True,
            "rules": []
        },
        "inbounds": [
            {
                "type": "vmess",
                "tag": "vmess-sb",
                "listen": "::",
                "listen_port": 54321,
                "users": [],
                "transport": {
                    "type": "ws",
                    "path": "/Telegram:@rudaoweishen",
                    "max_early_data": 2048,
                    "early_data_header_name": "Sec-WebSocket-Protocol"
                },
                "tls": {
                    "enabled": False,
                    "server_name": "www.bing.com",
                    "certificate_path": "/etc/s-box-ag/cert.pem",
                    "key_path": "/etc/s-box-ag/private.key"
                }
            }
        ],
        "outbounds": [
            {
                "type": "direct",
                "tag": "direct"
            }
        ]
    }

    vmess_links = []

    # Add vmess-direct user
    direct_user_uuid = str(uuid.uuid4())
    direct_user = {
        "name": "vmess-direct",
        "uuid": direct_user_uuid,
        "alterId": 0
    }
    config["inbounds"][0]["users"].append(direct_user)

    # Create vmess link for vmess-direct
    direct_vmess_link = {
        "v": "2",
        "ps": "vmess-direct",
        "add": "104.16.0.0",
        "port": 443,
        "id": direct_user_uuid,
        "aid": 0,
        "net": "ws",
        "type": "none",
        "host": "us-socks.alvgw.xyz",
        "path": "/Telegram:@rudaoweishen",
        "tls": "tls",
        "sni": "us-socks.alvgw.xyz",
        "apl": "",
        "fp": ""
    }
    direct_vmess_json = json.dumps(direct_vmess_link)
    direct_encoded_link = base64.b64encode(direct_vmess_json.encode()).decode()
    vmess_links.append(f'vmess://{direct_encoded_link}')

    # Generate inbounds users
    for i in range(1, 2):
        user_uuid = str(uuid.uuid4())
        user = {
            "name": f"sock-us-{i}",
            "uuid": user_uuid,
            "alterId": 0
        }
        config["inbounds"][0]["users"].append(user)

        # Create vmess link for each user
        vmess_link = {
            "v": "2",
            "ps": f"sock-us-{i}",
            "add": "104.16.0.0",
            "port": 443,
            "id": user_uuid,
            "aid": 0,
            "net": "ws",
            "type": "none",
            "host": "us-socks.alvgw.xyz",
            "path": "/Telegram:@rudaoweishen",
            "tls": "tls",
            "sni": "us-socks.alvgw.xyz",
            "apl": "",
            "fp": ""
        }
        vmess_json = json.dumps(vmess_link)
        encoded_link = base64.b64encode(vmess_json.encode()).decode()
        vmess_links.append(f'vmess://{encoded_link}')

    # Generate outbounds for socks
    for i in range(1, 2):
        outbound = {
            "type": "socks",
            "tag": f"socks-us-{i}",
            "server": f"107.163.248.{i}",
            "server_port": 10000,
            "version": "5",
            "username": "12349",
            "password": "12349"
        }
        config["outbounds"].append(outbound)

    # Generate route rules
    for i in range(1, 2):
        rule = {
            "auth_user": f"socks-us-{i}",
            "action": "route",
            "outbound": f"socks-us-{i}"
        }
        config["route"]["rules"].append(rule)

    # Add the direct route rule
    config["route"]["rules"].insert(0, {
        "auth_user": "vmess-direct",
        "action": "route",
        "outbound": "direct"
    })

    return config, vmess_links

if __name__ == "__main__":
    json_config, vmess_links = generate_config()
    
    # Write to a JSON file
    with open('config.json', 'w') as json_file:
        json.dump(json_config, json_file, indent=2)

    # Write vmess links to a separate file
    with open('vmess.json', 'w') as vmess_file:
        vmess_file.write('\n'.join(vmess_links))  # Write each link on a new line

    print("Configuration saved to config.json and vmess links saved to vmess.json")
