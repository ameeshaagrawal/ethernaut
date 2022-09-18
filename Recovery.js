// IMPORTANT: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-161.md
// After EIP-161, contract nonce starts from 1 instead of 0.

const ethers = require("ethers.js");

async function main() {
  const rlpEncoded = ethers.utils.RLP.encode([
    "0xf2fd82713a7FC4DD7ffF523D00883ee7aeCdFcBa", // contract address
    ethers.BigNumber.from(1).toHexString(), // contract nonce = 1
  ]);
  const contractAddrlong = ethers.utils.keccak256(rlpEncoded);
  const contractAddr = "0x".concat(contractAddrlong.substring(26));
  console.log(ethers.utils.getAddress(contractAddr));
  // call destroy() on this address to recover funds!!
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
