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
    @IBOutlet weak var pricingStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        parkedHours = mock.fakeParkedHours()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PayForParkingViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PayForParkingViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func configViews() {
        self.navigationController?.isNavigationBarHidden = true
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
            
            let successViewController = PaymentSuccessViewController()
            successViewController.change = change
            successViewController.amountpPayed = amount
            
            self.navigationController?.pushViewController(successViewController, animated: true)
            
        } catch {
            print(error)
        }
    }
    
}

extension PayForParkingViewController {
    
    func calculateAmountDeducting(for hours: Double) -> Double{
        if hours >= 9 {
            amountDeducting = 50.0
        }
        
        else if hours >= 7 {
            amountDeducting = 40.0
        }
        
        else if hours >= 5 {
            amountDeducting = 30.0
        }
        
        else if hours >= 3 {
            amountDeducting = 20
        }
        
        else {
            amountDeducting = 10
        }
        
        return amountDeducting
    }
}

extension PayForParkingViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {}
    @objc func keyboardWillHide(notification: NSNotification) {}

}
