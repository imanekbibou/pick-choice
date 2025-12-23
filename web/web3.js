window.pickChoix = {
  async connect() {
    if (!window.ethereum) {
      throw new Error("MetaMask non installé");
    }

  
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });

    return accounts[0];
  },

  async saveCoffee(contractAddress, abi, name, extra) {
    await this.connect();

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);

    // appelle la fonction Solidity: saveCoffee(string,string)
    const tx = await contract.saveCoffee(name, extra);
    return await tx.wait();
  },

  async saveBakery(contractAddress, abi, name, extra) {
    await this.connect();

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);

    // appelle la fonction Solidity: saveBakery(string,string)
    const tx = await contract.saveBakery(name, extra);
    return await tx.wait();
  },
};
