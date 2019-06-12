//
//  BookDetailViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class BookDetailViewModel {

    var bookID: Int
 
    private let changeLabelSignalPipe = Signal<String, NoError>.pipe()
    var changeLabelSignal: Signal<String, NoError> {
        return changeLabelSignalPipe.output
    }

    private let rentSignalPipe = Signal<Bool, NoError>.pipe()
    var rentSignal: Signal <Bool, NoError> {
        return rentSignalPipe.output
    }
    
    deinit {
        rentSignalPipe.input.sendCompleted()
        changeLabelSignalPipe.input.sendCompleted()
    }
    
    init(bookID: Int) {
        self.bookID = bookID-1
    }
    
    func rent() -> Int {
        var rentStatus: Bool = true
        if checkBookStatus() {
            self.requestRent()
            rentSignal.observeValues { result in
                rentStatus = result
            }
            
            if rentStatus {
                //rentRequestSuccessful()
                return 0
            } else {
                //rentRequestFailed()
                return 1
            }
        } else {
            //bookIsUnavailable()
            return 2
        }
    }
    
    func checkBookStatus() -> Bool {
        return BookDB.bookArrayDB[bookID].status == "available"
    }
    
    func requestRent() {
        
        let today: String = Date.getCurrentDateYYYY_MM_DD()
        let tomorrow: String = Date.addDaysToCurrentDateYYYY_MM_DD(daysToAdd: 1)
        let userID = 8  // userID assigned by trainer
        let bookID = self.bookID
        let parameters = ["userID": userID,
                          "bookID": bookID,
                          "from": today,
                          "to": tomorrow] as [String: Any]
            
        guard let url = URL(string: "https://swift-training-backend.herokuapp.com/users/8/rents") else {
            rentSignalPipe.input.send(value: false)
            return
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            rentSignalPipe.input.send(value: false)
            return
        }
        request.httpBody = httpBody
            
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print (response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    self.rentSignalPipe.input.send(value: true)
                    self.changeStatusOnBookStructure()
                } catch {
                    print(error)
                    self.rentSignalPipe.input.send(value: false)
                }
            }
        }.resume()
    }
    func changeStatusOnBookStructure() {
        if BookDB.bookArrayDB[self.bookID].status == "available" {
            BookDB.bookArrayDB[self.bookID].status = "rented"
            changeLabelSignalPipe.input.send(value: "rented")
        } else if BookDB.bookArrayDB[self.bookID].status == "rented" {
            BookDB.bookArrayDB[self.bookID].status = "available"
            changeLabelSignalPipe.input.send(value: "available")
        }
    }
}
