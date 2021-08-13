import Kibble from Project.Kibble
import FungibleToken from Flow.FungibleToken


// this contract basicallly splits and forwards kibble
pub contract KibbleSplit {


    pub event TokensReceived(amount: UFix64)


    pub fun split(kibbleVault: @Kibble.Vault, receiverRef1: &Kibble.Vault{FungibleToken.Receiver}, receiverRef2: &Kibble.Vault{FungibleToken.Receiver}){
        
        let amount = kibbleVault.balance
        emit TokensReceived(amount: amount)

        
        
        let split1 = amount/2.0
        let split2 = amount - split1



        let vault1 <- kibbleVault.withdraw(amount: split1)
        receiverRef1.deposit(from: <- vault1)
        let vault2 <- kibbleVault.withdraw(amount: split2)
        receiverRef2.deposit(from: <- vault2)

        destroy kibbleVault

    }
    init(){

    }



}