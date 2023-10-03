//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract MyToken {
    string public nombre;
    string public simbolo;
    uint8 public constant decimales = 6;
    mapping(address => uint256) public balances;

    constructor(
        string memory _nombre,
        string memory _simbolo,
        address _receptor
    ) {
        nombre = _nombre;
        simbolo = _simbolo;
        balances[_receptor] = 9999999999999;
        // escoger a qué address se le dará el balance inicial
    }

    function transferir(uint256 cantidad, address receptor) public {
        require(balances[msg.sender] >= cantidad, "Saldo insuficiente");
        balances[msg.sender] -= cantidad;
        balances[receptor] += cantidad;
    }
}
