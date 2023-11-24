const Web3 = require('web3')
const rpc = ''
const web3 = new Web3.Web3(rpc);
const to_address = '';
const private_key = '';
const lim = 1;


async function load() {
    let from_address = web3.eth.accounts.privateKeyToAccount(private_key).address
    let gas_price_gwei = 2.5 // Gwei
    let gas_price = web3.utils.toWei(gas_price_gwei, 'Gwei');
    let data = '0x48c54b9d';
    let nonce = await web3.eth.getTransactionCount(from_address);
    nonce = web3.utils.toNumber(nonce)
    for (let i = 0; i < lim; i++) {
        let transaction = {
            'from': from_address,
            'to': to_address,
            'value': web3.utils.toHex(0),
            'nonce': web3.utils.toHex(nonce),
            'gas': 200000,
            'gasPrice': gas_price,
            'data': data,
            'chainId': web3.utils.toHex(61)
        }
        console.log(transaction);
        let hex = await web3.eth.accounts.signTransaction(transaction, private_key);
        console.log(hex);

        try {
            let res = await web3.eth.sendSignedTransaction(hex.rawTransaction)
            console.log(res.transactionHash);
            nonce = nonce + 1;
        } catch (e) {
            console.log(e);
        }
    }
}

load()

