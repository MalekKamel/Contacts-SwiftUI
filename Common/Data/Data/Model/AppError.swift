//
// Created by Shaban on 08/07/2021.
//

import Foundation
import Moya

public enum AppError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case internet
    case connection
    case timeout
    case authentication
    case notModified
    case server(String)
    case parsingResponse(message: String)
    case badRequest(message: String)
    case underlying(code: Int, message: String)
    case database(message: String)
    case unknown(message: String)
    case business(error: Error?, message: String)
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "🥴 Invalid URL"
        case let .httpCode(code): return "🤬 Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "🤯 Unexpected response from the server"

        case .internet:
            return "😹 No Connection To Internet"
        case .connection:
            return "🗣 connection"
        case .timeout:
            return "😹 timedout"
        case .authentication:
            return "☠️ authentication"
        case .notModified:
            return " notModified"
        case let .server(message):
            return message
        case .badRequest(let message):
            return message
        case .underlying(_, let message):
            return message
        case .database(let message):
            return message
        case .unknown(let message):
            return message
        case .business(_, let message):
            return message
        case .parsingResponse(let message):
            return message
        }
    }
}

public extension Error {
    var toAppError: AppError {
        let nsError = self as NSError
        return nsError.toAppError
    }
}

public extension NSError {
    var toAppError: AppError {
        let code = URLError.Code(rawValue: code)

        switch code {
        case .notConnectedToInternet, .networkConnectionLost:
            return .internet
        case .timedOut:
            return .timeout
        case .cannotFindHost:
            return .connection
        case .cannotConnectToHost:
            return .server(localizedDescription)
        case .userAuthenticationRequired:
            return .authentication
        case .badServerResponse, .cannotParseResponse, .cannotDecodeRawData, .cannotDecodeContentData:
            return .parsingResponse(message: "\(code): \(localizedDescription)")
        case .badURL, .unsupportedURL:
            return .badRequest(message: "\(code): Endpoint failed to encode the parameters for the URLRequest: \(localizedDescription)")
        default:
            return .underlying(code: code.rawValue, message: "\(code): \(localizedDescription)")
        }
    }
}

public extension MoyaError {
    var toAppError: AppError {
        switch self {
        case .jsonMapping(let response):
            return .parsingResponse(message: "Mapping JSON Error: \(response.description)")
        case .imageMapping(let response):
            return .parsingResponse(message: "Mapping Image Error: \(response.description)")
        case .stringMapping(let response):
            return .parsingResponse(message: "Mapping String Error: \(response.description)")
        case .objectMapping(_, let response):
            return .parsingResponse(message: "Mapping Object Error: \(response.description)")
        case .encodableMapping(let error):
            return .parsingResponse(message: "Encodable couldn’t be encoded into Data: \(error.localizedDescription)")
        case .requestMapping(let url):
            return .badRequest(message: "Endpoint failed to map to a URLRequest: \(url)")
        case .parameterEncoding(let error):
            return .parsingResponse(message: "parameter couldn’t be encoded into Data: \(error.localizedDescription)")
        case .statusCode(let response):
            guard let code = HTTPStatusCode(rawValue: response.statusCode) else {
                return .unknown(message: "\(response.statusCode) Endpoint failed to encode "
                        + "the parameters for the URLRequest: \(response.description)")
            }
            switch code {
            case .connectionClosedWithoutResponse:
                return .internet
            case .requestTimeout, .networkConnectTimeoutError:
                return .timeout
            case .unauthorized:
                return .authentication
            case .internalServerError, .notImplemented, .badGateway, .serviceUnavailable, .gatewayTimeout,
                 .httpVersionNotSupported, .variantAlsoNegotiates, .insufficientStorage, .loopDetected,
                 .notExtended, .networkAuthenticationRequired:
                return .server(localizedDescription)
            case .notModified:
                return .notModified
            default:
                return .httpCode(response.statusCode)
            }

        case let .underlying(error, _):
            guard let alError = error.asAFError else {
                return (error as NSError).toAppError
            }
            return alError.toAppError
        }
    }
}