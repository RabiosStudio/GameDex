//
//  AlamofireAPI.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation
import Alamofire

class AlamofireAPI: API {
    
    enum Constants {
        static let apiKey = "api_key"
    }
    
    // MARK: - Properties
    var lastTask: URLSessionTask?
    var basePath: String {
        return "https://api.mobygames.com/v1/"
    }
    
    var commonParameters: [String: Any]? {
        guard let apiKey = ProcessInfo.processInfo.environment["MOBYGAMES_API_KEY"] else {
            return nil
        }
        return [Constants.apiKey: apiKey]
    }
    
    func getData<T, U>(with endpoint: T) async -> Result<U, APIError> where T: APIEndpoint, U: Decodable {
        guard let url = URL(string: "\(self.basePath)\(endpoint.path)") else {
            return .failure(APIError.wrongUrl)
        }
        
        var finalParameters = self.commonParameters ?? [:]
        
        if let endpointParameters = endpoint.entryParameters {
            for (key, value) in endpointParameters {
                finalParameters[key] = value
            }
        }
        
        do {
            let APIrequest = await withCheckedContinuation { continuation in
                Session.default.request(
                    url,
                    method: AlamofireAPI.method(
                        apiMethod: endpoint.method
                    ),
                    parameters: finalParameters,
                    encoding: URLEncoding.default,
                    headers: nil
                ).validate().responseData { apiRequest in
                    continuation.resume(returning: apiRequest)
                }
            }
            
            guard let httpResponse = APIrequest.response,
                  httpResponse.statusCode == 200 else {
                return .failure(APIError.server)
            }
            guard let requestData = APIrequest.value else {
                return .failure(APIError.noData)
            }
            
            let decoder = JSONDecoder()
            let decodedResponse: U
            decodedResponse = try decoder.decode(U.self, from: requestData)
            return .success(decodedResponse)
        } catch {
            return .failure(APIError.parsingError)
        }
    }
    
    class func method(apiMethod: APIMethod) -> HTTPMethod {
        
        let alamofireMethod: HTTPMethod
        
        switch apiMethod {
        case .get:
            alamofireMethod = .get
        case .post:
            alamofireMethod = .post
        case .put:
            alamofireMethod = .put
        case .delete:
            alamofireMethod = .delete
        }
        
        return alamofireMethod
    }
}
