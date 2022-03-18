// web3.js solution
let data2 = web3.utils.hexToBytes(
  await web3.eth.getStorageAt(contract.address, 5, console.log));

// Take first 16 bytes and convert to hex and call the method
let key = web3.utils.bytesToHex(data2.slice(0, 16));
await contract.unlock(key);
