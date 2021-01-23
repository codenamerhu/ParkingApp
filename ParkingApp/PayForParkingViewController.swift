//
//  ViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit

class PayForParkingViewController: UIViewController {
    
    let payment = Payment()
    let mock = MockUpdata()
    var parkedHours = 0.00
    var amountDeducting = 0.00
    
    @IBOutlet weak var amountPayingTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        parkedHours = mock.fakeParkedHours()
        print("\(parkedHours) hours")
        
        
    }
    
    func configViews() {
        amountPayingTextField.keyboardType = .numberPad
    }
    
    @IBAction func initiatePayment(_ sender: UIButton ) {
        
        do {
            guard let amount = amountPayingTextField.text else {
                throw PaymentError.emptyFieldError
            }
            
            if amount == "" {
                throw PaymentError.emptyFieldError
            }
            
            if Double(amount) == nil {
                throw PaymentError.invalidValue
            }
            
            let change = try payment.processPayment(for: Double(amount)!, for: calculateAmountDeducting(for: parkedHours))
            
            print(change)
        } catch {
            print(error)
        }
    }
    
}

extension PayForParkingViewController {
    
    func calculateAmountDeducting(for hours: Double) -> Double{
        if hours < 3 {
            amountDeducting = 10.0
        } else if hours >= 3 || hours < 5 {
            amountDeducting = 20.0
        } else if hours >= 5 || hours < 7 {
            amountDeducting = 30.0
        } else if hours >= 7 || hours < 9 {
            amountDeducting = 40
        } else {
            amountDeducting = 50
        }
        
        return amountDeducting
    }
}
