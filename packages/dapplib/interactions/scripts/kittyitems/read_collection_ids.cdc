// TODO:
// Add imports here, then do steps 1 and 2.
import KittyItems from Project.KittyItems
import NonFungibleToken from Flow.NonFungibleToken


// This script returns an array of all the NFT IDs in an account's Kitty Items Collection.

pub fun main(address: Address): [UInt64] {

    // 1) Get a public reference to the address' public Kitty Items Collection
    let account = getAccount(address).getCapability(KittyItems.CollectionPublicPath).borrow<&{NonFungibleToken.CollectionPublic}>()?? panic(" Could not get the ref to the account's kitty item collection")

    // 2) Return the Collection's IDs 
    return account.getIDs()
    //
    // Hint: there is already a function to do that

}