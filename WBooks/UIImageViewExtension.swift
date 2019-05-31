//
//  UIImageViewExtension.swift
//  WBooks
//
//  Created by Matías David Schwalb on 31/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import WolmoCore
import Result

public extension UIImageView {
    func load(url: URL) {
        
        let signalProducer = ImageFetcher().fetchImage(url).producer.flatMapError {
            _ in SignalProducer<UIImage, NoError>.empty
        }
        
        signalProducer.startWithValues { [unowned self] loadedImage in
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }
    }
}
