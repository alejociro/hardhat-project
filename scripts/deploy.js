async function main() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with the account:', deployer.address);

  // Desplegar el contrato VotingToken
  const votingToken = await ethers.deployContract('VotingToken', []);
  console.log('VotingToken address:', await votingToken.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
