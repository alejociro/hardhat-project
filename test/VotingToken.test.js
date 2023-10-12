const { expect } = require('chai');

describe('VotingToken', function () {
  let VotingToken;
  let votingToken;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    VotingToken = await ethers.getContractFactory('VotingToken');
    [owner, addr1, addr2, _] = await ethers.getSigners();
    votingToken = await VotingToken.deploy();
  });

  it('Should add a proposal correctly', async function () {
    await votingToken.addProposal('Proposal 1');
    const proposal = await votingToken.getProposalDetails(0);
    expect(proposal.name).to.equal('Proposal 1');
    expect(proposal.voteCount).to.equal(0);
  });

  it('Should whitelist an address', async function () {
    await votingToken.addToWhitelist(addr1.address);
    expect(await votingToken.votersWhitelist(addr1.address)).to.equal(true);
  });

  it('Should allow a whitelisted address to vote', async function () {
    await votingToken.addProposal('Proposal 1');
    await votingToken.addToWhitelist(addr1.address);
    await votingToken.connect(addr1).vote(0);
    const proposal = await votingToken.getProposalDetails(0);
    expect(proposal.voteCount).to.equal(1);
  });

  it('Should not allow a non-whitelisted address to vote', async function () {
    await votingToken.addProposal('Proposal 1');
    await expect(votingToken.connect(addr2).vote(0)).to.be.revertedWith(
      'No estas en la lista blanca para votar'
    );
  });

  it('Should not allow voting more than once', async function () {
    await votingToken.addProposal('Proposal 1');
    await votingToken.addToWhitelist(addr1.address);
    await votingToken.connect(addr1).vote(0);
    await expect(votingToken.connect(addr1).vote(0)).to.be.revertedWith(
      'Ya votaste'
    );
  });
});
