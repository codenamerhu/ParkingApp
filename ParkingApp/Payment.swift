//
//  Payment.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import Foundation

protocol PaymentProtocol {
    func processPayment(for amountPaying:Double, for amountDeducting: Double) throws -> String
}

class Payment: PaymentProtocol {
    func processPayment(for amountPaying: Double, for amountDeducting: Double) throws -> String {
        <#code#>
    }
    
    
}
