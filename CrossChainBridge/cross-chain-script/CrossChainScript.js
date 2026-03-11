import { ethers } from "ethers";

//Initialize the providers of the two chains
const providerHolesky = new ethers.JsonRpcProvider("Holesky_Provider_URL");
const providerSepolia = new ethers.JsonRpcProvider("Sepolia_Provider_URL");

//Initialize the signers of the two chains
// privateKey fills in the private key of the administrator's wallet
const privateKey = "Your_Key";
const walletHolesky = new ethers.Wallet(privateKey, providerHolesky);
const walletSepolia = new ethers.Wallet(privateKey, providerSepolia);

//Contract address and ABI
const contractAddressHolesky = "Holesky_Contract_Address";
const contractAddressSepolia = "Sepolia_Contract_Address";

const abi = [
    "event Bridge(address indexed user, uint256 amount)",
    "function bridge(uint256 amount) public",
    "function mint(address to, uint amount) external",
];

//Initialize contract instance
const contractHolesky = new ethers.Contract(contractAddressHolesky, abi, walletHolesky);
const contractSepolia = new ethers.Contract(contractAddressSepolia, abi, walletSepolia);

const main = async () => {
     try{
         console.log(`Start listening to cross-chain events`)

         // Listen to the Bridge event of chain Sepolia, and then perform the mint operation on Holesky to complete the cross-chain
         contractSepolia.on("Bridge", async (user, amount) => {
             console.log(`Bridge event on Chain Sepolia: User ${user} burned ${amount} tokens`);

             // Performing mint operation
             let tx = await contractHolesky.mint(user, amount);
             await tx.wait();

             console.log(`Minted ${amount} tokens to ${user} on Chain Holesky`);
         });

          // Listen to the Bridge event of chain Holesky, and then perform the mint operation on Sepolia to complete the cross-chain
         contractHolesky.on("Bridge", async (user, amount) => {
             console.log(`Bridge event on Chain Holesky: User ${user} burned ${amount} tokens`);

             // Performing mint operation
            let tx = await contractSepolia.mint(user, amount);
            await tx.wait();

            console.log(`Minted ${amount} tokens to ${user} on Chain Sepolia`);
        });

    }catch(e){
        console.log(e);
    
    } 
}

main();
