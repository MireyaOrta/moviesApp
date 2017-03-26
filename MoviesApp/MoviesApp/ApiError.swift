//
//  ApiError.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation

struct ApiError : ErrorPresentable  {
    
    // MARK: - Properties
    var title: String?
    var message: String?
    var code: ApiErrorCode?
    
    // MARK: - Initializers
    init(title: String? = nil, message: String? = nil, code: ApiErrorCode? = nil) {
        self.title = title
        self.message = message
        self.code = code
    }
    
    init?(error: Error, data: Data?) {
        
        if Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue) == error._code {
            title = LocalizableString.offlineError.localizedString
            message = LocalizableString.checkInternet.localizedString
        } else if let errorMessage = data?.apiErrorMessage {
            message = errorMessage
            if let code = data?.apiErrorCode, let apiErrorCode = ApiErrorCode(rawValue: code) {
                self.code = apiErrorCode
            }
        } else {
            return nil
        }
    }
    
    // MARK: - Utils
    static var defaultError: ApiError {
        return ApiError(
            title: LocalizableString.connectionError.localizedString,
            message: LocalizableString.connectionProblem.localizedString,
            code: nil)
    }
}

enum ApiErrorCode: Int {
    // TODO: Set error Codes
    case errorUnknown = 0
    case errorFail = 401
    case errorDown = 404
}
