import FungibleToken from Flow.FungibleToken
import Kibble from Project.Kibble
import KibbleSplit from Project.KibbleSplit

transaction(amount: UFix64, recepient1: Address, recepient2: Address) {

    // A reference to the signer's stored vault
    let vaultRef: &Kibble.Vault
    let receiverRef1: &Kibble.Vault{FungibleToken.Receiver}
    let receiverRef2: &Kibble.Vault{FungibleToken.Receiver}

    prepare(signer: AuthAccount) {
        
        // Get a reference to the signer's stored vault
        self.vaultRef = signer.borrow<&Kibble.Vault>(from: Kibble.VaultStoragePath)
			?? panic("Could not borrow reference to the owner's Vault!")

        self.receiverRef1 = getAccount(recepient1).getCapability(Kibble.ReceiverPublicPath)
                        .borrow<&Kibble.Vault{FungibleToken.Receiver}>()
			?? panic("Could not borrow reference to the owner's Vault!")

        self.receiverRef2 = getAccount(recepient2).getCapability(Kibble.ReceiverPublicPath)
                        .borrow<&Kibble.Vault{FungibleToken.Receiver}>()
            ?? panic("Could not borrow reference to the owner's Vault!")
    }

    execute {
        let vault<- self.vaultRef.withdraw(amount: amount) as! @Kibble.Vault

        KibbleSplit.split(kibbleVault: <- vault, receiverRef1: self.receiverRef1, receiverRef2: self.receiverRef2)
    }
}