//
//  Request.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 16/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//
import Foundation

public typealias RequestBody = [String: Any]
public typealias ResponseBody = [String: Any]

public enum RequestMethod:String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}

public enum WebMethod {
    
    case getAllCities()
    case searchForScore(name: String, state: String)
    
    var path:String{
        
        let way = "/Master/CidadeServico.svc/rest"
        switch self{
        case .getAllCities:
            return "\(way)/BuscaTodasCidades"
        case .searchForScore:
            return "\(way)/BuscaPontos "
            
        }
    }
    
    var method:RequestMethod {
        switch self {
        case .searchForScore:
            return .POST
        default:
            return .GET
            
        }
    }
    
    var body:RequestBody {
        switch self {
        case .searchForScore(let name, let state):
                return ["Nome" : name, "Estado" : state]
        default:
            return RequestBody()
            
        }
    }
    
}

public typealias RequestCallback = (_ result:RequestResult)->(Void)

public class RequestResult: NSObject {
    public let rawData:AnyObject?
    public let urlResponse:HTTPURLResponse?
    public let error:Error?
    public let code:NSInteger?
    public var messageForCode:String?
    public var json:String {
        if let raw = rawData {
            do {
                let json = try JSONSerialization.data(withJSONObject: raw, options: JSONSerialization.WritingOptions.prettyPrinted)
                return NSString(data: json, encoding: String.Encoding.utf8.rawValue)! as String
            } catch _ {
                return ""
            }
        }
        return ""
    }
    public var data:NSDictionary{
        if let msg = rawData as? NSDictionary{
            return msg
        } else if let msg = rawData as? [NSDictionary] {
            return ["data": msg]
        } else if let msg = rawData as? Double {
            return ["data": msg]
        }
        return NSDictionary()
    }
    public init(rawData:AnyObject?, urlResponse:HTTPURLResponse?, error:Error?, code:NSInteger?){
        self.urlResponse = urlResponse
        self.error = error
        self.rawData = rawData
        self.code = code
        self.messageForCode = ""
        super.init( )
    }
}


public class Request: NSObject, URLSessionDataDelegate, URLSessionTaskDelegate, URLSessionDelegate {
    private lazy var callbacks = [RequestCallback]( )
    private var task:URLSessionDataTask?
    private var urlResponse:URLResponse?
    public var running:Bool = false
    private var _result:RequestResult? {
        didSet {
            if let res = _result {
                DispatchQueue.main.async {
                    if res.urlResponse != nil {
                            res.messageForCode = HTTPStatusCode(rawValue: res.code!)?.defaultMessage
                        
                    }
                    for callback in self.callbacks {
                        callback(res)
                    }
                    
                }
                
            }
        }
    }
    
    public var result:RequestResult? {
        return _result
    }
    
    let method:WebMethod
    lazy var session:URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        return session
    }()
    
    public init(method:WebMethod) {
        self.method = method
        super.init()
    }
    
    private func request(request: URLRequest?) {
        
        if let urlRequest = request {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let task = self.session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
                
                let httpResponse = response as? HTTPURLResponse
                self.running = false
                print("Completed request: \(self.method.path) | \(httpResponse?.statusCode ?? 0) | \(data?.count ?? 0) bytes")
                
                print(data?.count ?? 0)
                
                if let d = data  {
                    do {
                        
                        let obj = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments)
                        self._result = RequestResult(rawData: obj as AnyObject, urlResponse: httpResponse, error: error, code: httpResponse?.statusCode)
                    } catch _ {
                        self._result = RequestResult(rawData: nil, urlResponse: httpResponse, error: error, code: httpResponse?.statusCode)
                    }
                } else {
                    self._result = RequestResult(rawData: nil, urlResponse: httpResponse, error: error, code: httpResponse?.statusCode)
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false

                }
            })
            
            self.task = task
            _ = self.start( )
            
        }
        
    }
    
    public func run( ) -> Self {
        print(self.method)
        if let urlRequest = method.request {
            self.request(request: urlRequest as URLRequest )
            
        }
        
        return self
    }
    
    public func start( ) -> Self {
        print("Starting request: \(method.method.rawValue) : \(method.path)")
        print("\t\t- headers: \(method.request?.allHTTPHeaderFields?.count ?? 0)")
        if !running {
            task?.resume()
            self.running = true
            
        }
        return self
    }
    
    public func addCallback(callback:@escaping RequestCallback) -> Self {
        callbacks.append(callback)
        return self
    }
}

extension WebMethod {
    var request:NSURLRequest? {
        let comps = NSURLComponents( )
        
        var req: NSMutableURLRequest!
        comps.scheme = Connection.components.scheme
        comps.host = Connection.components.host
        comps.path = path
        
        if let url = comps.url {
            print(url);
            req = NSMutableURLRequest(url: url)
        }
        
        if let req = req {
            req.httpMethod = self.method.rawValue
            req.timeoutInterval = 30.0
            
            switch method {
                
            case .POST:
                do {
                    let json = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
                    print("HEADER: ", req.allHTTPHeaderFields ?? "")
                    print("BODY : ",body)
                    req.setValue("\(json.count)", forHTTPHeaderField: "Content-Length")
                    
                    req.httpBody = json
                    
                } catch _ {
                    return nil
                }
                
            default:
                    req.url = comps.url
                
            }
            
            return req
        }
        
        return nil
    }
}


