import web3 from './web3';
import SharedWallet from './build/SharedWallet.json';

const instance = new web3.eth.Contract(
    SharedWallet.abi,
    '0x1ddcC5bC9ea017D692Eb3B9268D0c71318012d58'
);

export default instance;
