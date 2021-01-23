//
//  ViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit

class PayForParkingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            let change = try processPayment(for: 50, for: 50)
            print(change)
        } catch {
            print(error)
        }
    }
    
    func processPayment(for amountPaying:Double, for amountDeducting: Double) throws -> String {
        var changeIs = 0.0
        
        // trhows error if amount paying is less than zero
        if amountPaying < 1.0 {
            throw PaymentError.cannotBeZeroError
        }
        
        // throws error if amount paying is less than ammount deducting
        if amountPaying < amountDeducting {
            throw PaymentError.notEnoughFundsError
        }
        
        changeIs = amountPaying - amountDeducting
        
        return "\(changeIs) ZAR"
    }


}

