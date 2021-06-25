//
// Created by Shaban on 23/06/2021.
//

import Foundation


public class MoyaHandlers {
    /// set handlers for status code errors
    public static var statusCodeHandlers: Array<MoyaStatusCodeHandler> = []

    /// set handlers for underlying errors
    public static var underlyingErrorHandlers: Array<MoyaUnderlyingErrorHandler> = []

    /// set handlers for errors
    public static var errorHandlers: Array<MoyaErrorHandler> = []
}