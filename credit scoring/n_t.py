import requests
import json

def get_starknet_transaction_count(address):
    url = "https://starknet-mainnet.g.alchemy.com/starknet/version/rpc/v0.7"  

    payload = {
        "id": 1,
        "jsonrpc": "2.0",
        "method": "starknet_getNonce",
        "params": [address, "latest"]  
    }

    headers = {
        "accept": "application/json",
        "content-type": "application/json"
    }

    response = requests.post(url, json=payload, headers=headers)

    # Check if the request was successful
    if response.status_code == 200:
        data = response.json()
        # Check if the result is available
        if "result" in data:
            # Return the nonce, which indicates the number of transactions
            return int(data["result"])  # Le nonce est un entier
        else:
            return "Error: Unable to retrieve nonce for the address"
    else:
        return f"Error: {response.status_code} - {response.text}"

# Exemple d'utilisation
address = "0x00a00373a00352aa367058555149b573322910d54fcdf3a926e3e56d0dcb4b0c"
transaction_count = get_starknet_transaction_count(address)
print(f"Nonce for address {address}: {transaction_count}")
