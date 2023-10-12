# Sistema de Votación

Este proyecto es un sistema de votación basado en la cadena de bloques Ethereum, que utiliza un contrato inteligente para gestionar las propuestas y votos.

## Características:

- Sólo el propietario puede añadir propuestas.
- Lista blanca de votantes.
- Eventos para auditar acciones importantes.

## Instrucciones de Despliegue:

1. Instala las dependencias: `npm install`.
2. Configura las variables de entorno en un archivo `.env`:
   - ALCHEMY_API_KEY: Tu clave API de Alchemy para la red de Sepolia.
   - SEPOLIA_PRIVATE_KEY: Tu clave privada para la red de Sepolia.
3. Despliega el contrato usando `hardhat`: `npx hardhat run scripts/deploy.js --network sepolia`.

## Test:

Los tests están ubicados en la carpeta `test`. Para ejecutarlos, usa `npx hardhat test`.
