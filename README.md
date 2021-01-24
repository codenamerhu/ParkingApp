# Parking App

### asessment's required function 
#### Payment.swift


```
func processPayment(for amountPaying: Double, for amountDeducting: Double) throws -> String {
        ...
    }
```

processPayment method takes in 2 parameters, ```amountPaying``` which is the amount paid to parking and ```amountDeducting``` which is the amount to be deducted from the the amount(```amountPaying```) payed, it then subtracts the numbers and returns the change/remaining amount in ZAR(rands)

### Error handling
#### PaymentError.swift