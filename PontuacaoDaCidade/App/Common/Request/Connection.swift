//
//  Connection.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 16/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//
import Foundation

public enum HTTPStatusCode: Int{
    case Accepted = 202
    case NoContent = 204
    case BadRequest = 400
    case RequestNotAuthorized = 401
    case NotFound = 404
    case InternalServerError = 500
    case OK = 200
    case timeOut = 600
    
    
    
    public var defaultMessage:String {
        switch self {
        case .BadRequest:
            return "bad-request"
        case .RequestNotAuthorized:
            return "request-not-authorized"
        case .NotFound:
            return "not-found"
        case .InternalServerError:
            return "internal-server-error"
        case .Accepted, .OK, .NoContent:
            return "Operação realizada"
        case .timeOut:
            return "Tempo excedido"
        }
    }
    
}

class Connection: NSObject {
    struct components {
        static var scheme: String {
            return "http"
        }
        
        static var host: String {
            return "wsteste.devedp.com.br"
        }
        
    }
    class func executeResquest(request: WebMethod) -> Request {
        let request = Request(method: request)
        return request
    }
}
