//
//  NetworkingBootstraper.swift
//  WBooks
//
//  Created by Matías David Schwalb on 31/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Networking
import ReactiveSwift
import AlamofireNetworkActivityIndicator
import AlamofireNetworkActivityLogger

class NetworkingBootstrapper {
    
    static let shared = NetworkingBootstrapper()
    
    fileprivate let _sessionManager = SessionManager()
    
    fileprivate let networkingConfiguration: NetworkingConfiguration = {
        var config = NetworkingConfiguration()
        
        config.useSecureConnection = true
        config.domainURL = "swift-training-backend.herokuapp.com"
        config.port = 443
        config.usePinningCertificate = false
        
        return config
    }()
    
    private init() { }
    
    func bootstrap() {
        enableAlamofireNetworkActivityLogger()
        enableNetworkActivityIndicatorManager()
        bootstrapSessionManager()
        injectCurrentUserFetcher()
    }
    
    func createWBooksRepository() -> WBookRepository {
        return WBookRepository(networkingConfiguration: networkingConfiguration, sessionManager: _sessionManager)
    }
    
}

// MARK: Private Methods
fileprivate extension NetworkingBootstrapper {
    
    func enableAlamofireNetworkActivityLogger() {
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }
    
    func enableNetworkActivityIndicatorManager() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    
    func bootstrapSessionManager() {
        _sessionManager.bootstrap()
    }
    
    func injectCurrentUserFetcher() {
        if !_sessionManager.isLoggedIn {
            let currentUser = AuthUser()
            _sessionManager.login(user: currentUser)
        } else {
            print("User is already logged")
        }
    }
    
}
