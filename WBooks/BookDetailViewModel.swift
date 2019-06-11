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

    let dispatchGroup = DispatchGroup()
    var bookID: Int
 
    private let changeLabelSignalPipe = Signal<String, NoError>.pipe()
    var changeLabelSignal: Signal<String, NoError> {
        return changeLabelSignalPipe.output
    }
    deinit {
        changeLabelSignalPipe.input.sendCompleted()
    }
    
    /*
    let changeLabelSignalProducer: SignalProducer<String, NoError> = SignalProducer { (observer, lifetime) in
        observer.send(value: <#T##String#>)
    }
    */
    init(bookID: Int) {
        self.bookID = bookID-1
    }
    
    func rent() -> Int {
        var rentStatus: Bool = true
        if !checkBookStatus() { // ! sign added for debugging. Must be deleted on deployment or until back-end resolves rented on all books
            
            dispatchGroup.notify(queue: .main) {
                rentStatus = self.requestRent()
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
    
    func requestRent() -> Bool {
        var exitValue: Bool = false
        dispatchGroup.enter()
        
        DispatchQueue.global().sync {
            
            let today: String = Date.getCurrentDateYYYY_MM_DD()
            let tomorrow: String = Date.addDaysToCurrentDateYYYY_MM_DD(daysToAdd: 1)
            let userID = 8  // userID assigned by trainer
            let bookID = self.bookID
            let parameters = ["userID": userID,
                              "bookID": bookID,
                              "from": today,
                              "to": tomorrow] as [String: Any]
            
            guard let url = URL(string: "https://swift-training-backend.herokuapp.com/users/8/rents") else {
                exitValue = false
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                exitValue = false
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
                        exitValue = true
                        self.changeStatusOnBookStructure()
                    } catch {
                        print(error)
                        exitValue = false
                    }
                }
                }.resume()
            
        }
        dispatchGroup.leave()
        return exitValue
    }
    func changeStatusOnBookStructure() {
       // DispatchQueue.main.async {

            if BookDB.bookArrayDB[self.bookID].status == "available" {
                BookDB.bookArrayDB[self.bookID].status = "rented"
                changeLabelSignalPipe.input.send(value: "rented")
                
                // self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wRentedYellow
                // Create signal to update the label on View
                
            } else if BookDB.bookArrayDB[self.bookID].status == "rented" {
                BookDB.bookArrayDB[self.bookID].status = "available"
                changeLabelSignalPipe.input.send(value: "available")
                // self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wOliveGreen
                // Create signal to update the label on View
            }
            // self.bookDetailController.bookDetail.statusLabel.text = BookDB.bookArrayDB[self.bookID].status.capitalized
            // Create signal to update the label on View
       // }
    }
}
