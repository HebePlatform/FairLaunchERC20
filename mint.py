from web3 import Web3,Account

# rpc
rpc = 'https://etc.rivet.link'
# to Contract address
to_address = Web3.to_checksum_address('')
private_key = ''
lim = 1000  # limt

w3 = Web3(Web3.HTTPProvider(rpc))
from_address = Account.from_key(private_key).address
print('state：', w3.is_connected())
# is state
if w3.is_connected():
    # get nonce
    nonce = w3.eth.get_transaction_count(from_address)
    # set gwei
    gas_price_gwei = 2.5  # Gwei
    gas_price = w3.to_wei(gas_price_gwei, 'Gwei')
    # get gas_price
    # gas_price = w3.eth.gas_price
    # gas_price_gwei = w3.from_wei(gas_price, 'Gwei')
    data = '0x48c54b9d'
    print("nonce:", nonce, "gas:", gas_price_gwei, 'from:', from_address)

    # batch send
    for i in range(lim):
        transaction = {
            'from': from_address,  # from：
            'to': to_address,  # to：
            'value': w3.to_wei(0, 'ether'),  # value：
            'nonce': nonce,  # nonce：
            'gas': 200000,  # gas：
            'gasPrice': gas_price,  #
            'data': data,  #
            'chainId': w3.eth.chain_id  # chain_id
        }
        # 2.signed
        signed = w3.eth.account.sign_transaction(transaction, private_key)
        try:
            # 3.send_raw_transaction
            tx_hash = w3.eth.send_raw_transaction(signed.rawTransaction)
            print("Hash:", tx_hash.hex(), 'noce:', nonce)
        except Exception as e:
            print('hash err', e, 'hash data：', data)
        nonce += 1
