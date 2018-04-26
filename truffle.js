module.exports = {
	networks: {
		development: {
			host: "127.0.0.1",
			port: 8545,
			network_id: "*",
			gas: 4000000
		},

		ropsten: {
			host: "172.104.183.123",
			port: 8545,
			network_id: "*"
		},

		mainnet: {
			host: "178.79.173.30",
			port: 8545,
			network_id: "*"
		},

		solc: {
			optimizer: {
				enabled: true,
				runs: 200
			}
		}
	}
};