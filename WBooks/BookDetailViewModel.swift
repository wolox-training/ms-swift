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
import Networking
import Argo

final class BookDetailViewModel {

    public var book: Book
    private let bookRepository: WBookRepositoryType
    
    private let mutableComments = MutableProperty<[Comment]>([])
    public let comments: Property<[Comment]>
    
    /*
    private let mutableRentProperty = MutableProperty<Bool>(false)
    public let rentProperty: Property<Bool>
    */
    
  //  private let mutableRentResult = MutableProperty<Void?>(nil)
    public var rentResult: SignalProducer<Void, RepositoryError> = SignalProducer<Void, RepositoryError> { (_, _) in
        return
    }
    
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
    
    init(book: Book, bookRepository: WBookRepositoryType = NetworkingBootstrapper.shared.createWBooksRepository()) {
        self.book = book
        self.bookRepository = bookRepository
        self.comments = Property(mutableComments)
       // self.rentResult = Property(mutableRentResult)
        mutableComments <~ bookRepository.fetchComments(book: book)
            .flatMapError { _ in SignalProducer<[Comment], NoError>.empty }
        /*
        mutableRentResult <~ bookRepository.postRent(book: book)
            .flatMapError { _ in SignalProducer<Void, NoError>.empty }
         */
    }
    
    func rent() -> Int {
        var rentStatus: Bool = false
        if checkBookStatus() {
            rentResult = bookRepository.postRent(book: book)
            rentResult.producer.startWithResult { _ in
                rentStatus = true
                } /*(Signal<Void, RepositoryError>.Observer(
                value: { _ in
                    rentStatus = true
                    return
            },
                failed: { _ in
                    rentStatus = false
                    return
            },
                completed: {
                    rentStatus = true
                    return
            },
                interrupted: {
                    rentStatus = false
                    return
            }))
            */
            print(rentStatus)
            
            
            /*
            rentSignal.observeValues { result in
                rentStatus = result
            }
            */
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
        return book.status == "available"
    }
    
    func requestRent() {
        // Print not needed, just here for debugging
     //   print(bookRepository.postRent(book: book))

   //     rentResult.start()
        /*
        let today: String = Date.getCurrentDateYYYY_MM_DD()
        let tomorrow: String = Date.addDaysToCurrentDateYYYY_MM_DD(daysToAdd: 1)
        let userID = 8  // userID assigned by trainer
        let bookID = book.id
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
        */
    }
    func changeStatusOnBookStructure() {
        if book.status == "available" {
            book.status = "rented"
            changeLabelSignalPipe.input.send(value: "rented")
        } else if book.status == "rented" {
            book.status = "available"
            changeLabelSignalPipe.input.send(value: "available")
        }
    }
}
