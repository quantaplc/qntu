const fs = require('fs');
const csv = require('fast-csv');
const async = require('async');
var BigNumber = require('bignumber.js');

const StandardToken = artifacts.require('./StandardToken.sol');

/**
 * Execute
 */
module.exports = function (callback) {
    // ---------------------------------
    // Declare default configs
    // ---------------------------------
    const defaultArgv = {
        string: ['inputFile', 'contractAddr'],
        default: {
            inputFile: '',
            contractAddr: ''
        }
    }

    // ---------------------------------
    // Get configs from command line
    // ---------------------------------
    var argv = require('minimist')(process.argv.slice(6), defaultArgv);

    // Check parameters in command line
    checkParams(argv);

    // Get instance of StandardToken contract
    const contract = StandardToken.at(argv.contractAddr);

    var addrs = [];

    csv.fromStream(fs.createReadStream(argv.inputFile, { encoding: 'utf8' }), { headers: true }).on("data", function (data) {
        addrs.push(data);

    }).on("end", function () {
        getBalance(contract, addrs);
    });
}

/**
 * Check parameters in command line
 * @param _argv The command line parameters
 */
function checkParams(_argv) {
    if (!_argv.inputFile || _argv.inputFile === '') {
        console.error('\x1b[31m', 'Error: --inputFile is required', '\x1b[31m');
        process.exit(1);
    }

    if (!_argv.contractAddr || _argv.contractAddr === '') {
        console.error('\x1b[31m', 'Error: --contractAddr is required', '\x1b[31m');
        process.exit(1);
    }
}

/**
 * Get balance of user list
 * @param _contract The token contract instance
 * @param _addrs The user address list
 */
function getBalance(_contract, _addrs) {
    async.forEachSeries(_addrs, function (item, callback) {
        _contract.balanceOf.call(item.address).then((result) => {
            x = new BigNumber(result);

            console.log(item.address, x.dividedBy(Math.pow(10, 18)).toNumber());
            callback(null);

        }).catch((e) => {
            console.log(e);
            callback(null);
        });

    }, function (err, result) {

    });
}