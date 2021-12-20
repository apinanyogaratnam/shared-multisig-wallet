import web3 from './web3';
import SharedWallet from './build/SharedWallet.json';

const instance = new web3.eth.Contract(
    SharedWallet.abi,
    ''
);

export default instance;
