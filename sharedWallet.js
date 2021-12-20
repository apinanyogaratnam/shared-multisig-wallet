import web3 from './web3';
import SharedWallet from './build/SharedWallet.json';

const instance = new web3.eth.Contract(
    SharedWallet.abi,
    '0xE09a096F16Ef4B7E9ba267bd5867fF9179a036e8'
);

export default instance;
