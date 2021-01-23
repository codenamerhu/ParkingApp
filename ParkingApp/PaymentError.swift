//
//  PaymentError.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import Foundation

enum PaymentError: Error {
    case notEnoughFundsError
    case cannotBeZeroError
}
