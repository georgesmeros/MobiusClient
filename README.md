# MobiusClient
Swift API Client for Mobius Network

## Installation

> *Drag and drop framework into the project (Cocoapods coming soon)**

# Usage

```swift
import MobiusClient

// Setup
let mobiusClient = MobiusAPIClient.init(apiKey: YOUR_API_KEY)

// Balance
mobiusClient.getBalance { (balance, error) in
    if let error = error {
        //Response with error message
        print(error)
     } else if let balance = balance, let credits = balance.credits {
        //Success
        print("Balance:", credits)
     }
}

mobiusClient.getBalance(app_uid, email) { (balance, error) in
}

// Use
client.useCredit(app_uid: app_uid, email: email, numCredits: credits) { (balance, error) in
    if let error = error {
       //Response with error message
       print(error)
    } else if let balance = balance, let credits = balance.credits {
       //Balance after use
       print("Balance:", credits)
    }
}

// In progress - Data Marketplace, Tokens 
