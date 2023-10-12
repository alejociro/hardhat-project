pragma solidity ^0.8.19;

contract VotingToken {
    // Estructura para representar una propuesta
    struct Proposal {
        string name;       // Nombre de la propuesta
        uint voteCount;    // Cantidad de votos que ha recibido
    }

    address public owner;                      // Dirección del propietario del contrato
    Proposal[] public proposals;               // Array dinámico de propuestas
    mapping(address => bool) public votersWhitelist; // Lista blanca de votantes
    mapping(address => bool) public hasVoted;       // Registro de quienes ya han votado

    // Eventos para auditar acciones importantes en el contrato
    event ProposalAdded(string name, uint proposalIndex);
    event Voted(address voter, uint proposalIndex);
    event Whitelisted(address addr);
    event RemovedFromWhitelist(address addr);

    // Modificador para restringir el acceso solo al propietario del contrato
    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el propietario puede realizar esta accion");
        _;
    }

    // Constructor: Establece al creador del contrato como propietario
    constructor() {
        owner = msg.sender;
    }

    // Función para añadir una propuesta. Solo puede ser llamada por el propietario
    function addProposal(string memory _name) public onlyOwner {
        Proposal memory newProposal = Proposal({
            name: _name,
            voteCount: 0
        });
        proposals.push(newProposal);
        emit ProposalAdded(_name, proposals.length - 1);
    }

    // Función para añadir una dirección a la lista blanca. Solo puede ser llamada por el propietario
    function addToWhitelist(address _address) public onlyOwner {
        votersWhitelist[_address] = true;
        emit Whitelisted(_address);
    }

    // Función para remover una dirección de la lista blanca. Solo puede ser llamada por el propietario
    function removeFromWhitelist(address _address) public onlyOwner {
        votersWhitelist[_address] = false;
        emit RemovedFromWhitelist(_address);
    }

    // Función para obtener el número total de propuestas
    function getProposalsCount() public view returns (uint) {
        return proposals.length;
    }

    // Función para obtener los detalles de una propuesta específica por índice
    function getProposalDetails(uint _index) public view returns (string memory name, uint voteCount) {
        require(_index < proposals.length, "Indice no valido");
        Proposal memory proposal = proposals[_index];
        return (proposal.name, proposal.voteCount);
    }

    // Función para votar por una propuesta. Verifica que el votante esté en la lista blanca y no haya votado antes
    function vote(uint _proposalIndex) public {
        require(votersWhitelist[msg.sender], "No estas en la lista blanca para votar");
        require(!hasVoted[msg.sender], "Ya votaste");
        require(_proposalIndex < proposals.length, "Propuesta no valida");

        proposals[_proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, _proposalIndex);
    }
}
