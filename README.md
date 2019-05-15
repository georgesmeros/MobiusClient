# MobiusClient
Swift API Client for Mobius Network

## Client tutorial
https://medium.com/@georgesmeros/mobius-api-get-balance-using-swift-d3d694fc8d1f

## Installation

> *Drag and drop framework into the project (Cocoapods coming soon)**

# Usage

```swift
import MobiusClient


// Setup
let mobiusClient = MobiusAPIClient.init(apiKey: YOUR_API_KEY)


// Getting Balance
mobiusClient.getBalance { (balance, error, code) in
    if let error = error {
        //Response with error message
        print(error)
     } else if let balance = balance, let credits = balance.credits {
        //Success
        print("Balance:", credits)
     }
}


mobiusClient.getBalance(app_uid: app_uid,email: email) { (balance, error, code) in
}


// Using Credits
mobiusClient.useCredit(app_uid: app_uid, email: email, numCredits: credits) { (balance, error) in
    if let error = error {
       //Response with error message
       print(error)
    } else if let balance = balance, let credits = balance.credits {
       //Balance after use
       print("Balance:", credits)
    }
}


// Data Marketplace
mobiusClient.buyDataFeed(data_feed_uid: "dataFeedUID", address: "address") { (dataFeed, error, code) in
    if let error = error {
       //Response with error message
       print(error)
    } else if let dataFeed = dataFeed {
       //Data Feed retrived
    }
}
        
mobiusClient.getDataFeed(data_feed_uid: "dataFeedUID") { (dataFeed, error, code) in
     if let error = error {
         //Response with error message
         print(error)
     } else if let dataFeed = dataFeed {
         //Data Feed retrived
     }
}
 
 
mobiusClient.createDataPoint(data_feed_uid: "dataFeedUID", values: ["temperature":"90"]) { (dataFeed, error, code) in
     if let error = error {
         //Response with error message
         print(error)
     } else if let dataFeed = dataFeed {
         //Data Feed retrived
     }
}
    
    
// Tokens
mobiusClient.registerToken(token_type: .stellar, name: "name", symbol: "MOBI", issuer: "issuer") { (token, error, code) in
     if let error = error {
          //Response with error message
          print(error)
     } else if let token = token {
         //Token retrived
     }
}
    
    
mobiusClient.createAddress(token_uid: "token_uid") { (uid, address, error, code) in
     if let error = error {
         //Response with error message
         print(error)
      } else if let uid = uid, let address = address {
         //UID , Address retrived
      }
}
     
     
mobiusClient.registerAddress(token_uid: "token_uid", address: "address") { (uid, error, code) in
      if let error = error {
          //Response with error message
          print(error)
      } else if let uid = uid {
          //UID retrived
      }
}
    
    
mobiusClient.getAddressBalance(token_uid: "token_uid", address: "address") { (address, error, code) in
      if let error = error {
           //Response with error message
           print(error)
      } else if let address = address {
           //MobiusAddress retrived
      }
}
    

// Transfers
mobiusClient.createTransfer(token_address_uid: "token_address_uid", address_to: "address_to", num_tokens: 0) { (tokenAddressTransferUID, error, code) in
      if let error = error {
          //Response with error message
          print(error)
      } else if let tokenAddressTransferUID = tokenAddressTransferUID {
          //tokenAddressTransferUID retrived
      }
}
   
   
mobiusClient.getTransferInfo(token_address_transfer_uid: "token_address_transfer_uid") { (mobiusTransferInfo, error, code) in
      if let error = error {
           //Response with error message
           print(error)
      } else if let mobiusTransferInfo = mobiusTransferInfo {
           //mobiusTransferInfo retrived
      }
} 
