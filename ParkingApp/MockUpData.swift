//
//  MockUpData.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import Foundation

class MockUpdata {
    
    let parkingMinutesArray = [3, 590, 59, 129, 64, 340, 444, 110, 501, 33, 208, 180, 221, 249, 378]
    var minutesParked = 0
    
    func fakeParkedHours() ->  Double {
        minutesParked = parkingMinutesArray[Int.random(in: 0..<(parkingMinutesArray.count - 1))]
        let parkingTime = Double ( minutesParked / 60 )
        return parkingTime
    }
}
