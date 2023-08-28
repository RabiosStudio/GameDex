//
//  AlamofireAPI.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation
import Alamofire

class AlamofireAPI: API {
    
    // MARK: - Properties
    var lastTask: URLSessionTask?
    var basePath: String {
        return "https://api.mobygames.com/v1/"
    }
    
    func getData<T, U>(with endpoint: T, resultType: U.Type) async -> Result<U, APIError> where T: APIEndpoint, U: Decodable {
        //        self.session = Alamofire.Session(configuration: configuration)
        guard let url = URL(string: "\(self.basePath)\(endpoint.path)") else {
            //            return result
            return .failure(APIError.wrongUrl)
        }
        
        do {
            let APIrequest = await withCheckedContinuation { continuation in
                Session.default.request(
                    url,
                    method: AlamofireAPI.method(
                        apiMethod: endpoint.method
                    ),
                    parameters: endpoint.entryParameters,
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
