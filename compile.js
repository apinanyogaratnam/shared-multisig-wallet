const path = require('path');
const fs = require('fs-extra');
const solc = require('solc');

const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);

const sharedWalletPath = path.resolve(__dirname, 'contracts', 'SharedWallet.sol');
const source = fs.readFileSync(sharedWalletPath, 'utf8');

const input = {
  language: 'Solidity',
  sources: {
    'SharedWallet.sol': {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      '*': {
        '*': ['*'],
      },
    },
  },
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));
fs.ensureDirSync(buildPath);

fs.outputJsonSync(
    path.resolve(buildPath, 'SharedWallet.json'),
    output.contracts['SharedWallet.sol']['SharedWallet']
);
