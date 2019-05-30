//
//  BookRepository.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Result
import Alamofire

internal class BookRepository {
    public func fetchBooks(onSuccess: @escaping ([Book]) -> Void, onError: @escaping (Error) -> Void) {
        let url = URL(string: "https://swift-training-backend.herokuapp.com/books")!
        
        request(url, method: .get).responseJSON {
            // Handle response
            response in
            // Check if request was successful
            switch response.result {
                // Request was successful
            case .success(let value):
                // Check if data is valid, if not call error function
                guard let JSONbooks = try? JSONSerialization.data(withJSONObject: value, options: []) else {
                    onError(BookError.decodeError)
                    return
                }
                // Check if data is valid, if not call error function
                guard let books = try? JSONDecoder().decode([Book].self, from: JSONbooks) else {
                    onError(BookError.decodeError)
                    return
                }
                // Request was successful and data is valid so we call success function
                onSuccess(books)
                
            case .failure(let error):
                // Request failed. Called on an error function
                onError(error)
            }
        }
    }
}

public struct Book: Codable {
    let id: Int
    let title: String
    let author: String
    let genre: String
    let year: String
    let image: String
    
    enum BookKey: String, CodingKey {
        case id = "id"
        case title = "title"
        case author = "author"
        case genre = "genre"
        case year = "year"
        case image = "image"
    }
    
    public init(from: Decoder) throws {
        let container = (try from.container(keyedBy: BookKey.self))
        id = (try? container.decode(Int.self, forKey: .id)) ?? -1
        title = (try? container.decode(String.self, forKey: .title)) ?? "title_error"
        author = (try? container.decode(String.self, forKey: .author)) ?? "autor_error"
        genre = (try? container.decode(String.self, forKey: .genre)) ?? "genre_error"
        year = (try? container.decode(String.self, forKey: .year)) ?? "year_error"
        image = (try? container.decode(String.self, forKey: .image)) ?? "image_error"
    }
}

enum BookError: Error {
    case decodeError
}
