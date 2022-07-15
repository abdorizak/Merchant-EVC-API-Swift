# Merchant-EVC-API-Swift
in this repository, I'll teach you how to send requests to the merchant EVC API. using the Swift language.
Also i'll use `Async await` Swift to send requests and _ completion `@escaping` to receive the response and handle it.

here the code of example:
```swift
if #available(iOS 15, *) { // check if the iOS version is >= 15 it'll use the new API to send requests to the merchant EVC API using Async Swift
        do {
            self.response = try await call.makePayment(number: number, amount: amount)
            print("Response: \(String(describing: response))") // this just prints the response
        } catch {
            throw MerchantErrors.unableTopComplete
        }
    } else {
    // will run completion Function instead of Async
        call.makePayment(number: number, amount: amount) { result in
            switch result {
            case .success(let res):
                self.response = res
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
}
```
```warning
Note: this repository is not a real merchant EVC API. it's just a playground to test the API. if you want to test you must have the following things:
    • a valid `merchantUID`.
    • a valid merchant EVC `APIkey`.
    • a valid merchant API `Userid`.
```

### **Credit**
**_Abdorizak Abdalla_** [twitter](https://twitter.com/abdorizak3)
