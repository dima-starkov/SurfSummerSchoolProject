//
//  BaseNetworkTask.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 16.08.2022.
//

import Foundation

struct BaseNetworkTask<AbstractInput:Encodable,AbstractOutput:Decodable>: NetworkTask {
    
    //MARK: -NetworkTask
    
    typealias Input = AbstractInput
    typealias Output = AbstractOutput
    
    var baseURL: URL? {
        URL(string: "https://pictures.chronicker.fun/api")
    }
    
    let path: String
    let method: NetworkMethod
    let session: URLSession = URLSession(configuration: .default)
    let isNeedInjectToken: Bool
    
    var urlCache: URLCache {
        .shared
    }
    
    var tokenStorage: TokenStorage {
        BaseTokenStorage()
    }
    
    //MARK: -init
    
    init(isNeedInjectToken: Bool, method: NetworkMethod, path: String) {
        self.path = path
        self.method = method
        self.isNeedInjectToken = isNeedInjectToken
    }
    
    //MARK: -NetworkTask Methods
    
    func performRequest(input: AbstractInput,
                        onResponceWasRecived: @escaping (Result<AbstractOutput, Error>) -> Void) {
        do {
            let request = try getRequest(with: input)
            
            if let cacheResponse = getCachedResponceFromCache(by: request) {
                let model = try JSONDecoder().decode(AbstractOutput.self, from: cacheResponse.data)
                onResponceWasRecived(.success(model))
                return
            }
            
            session.dataTask(with: request) { data, response , error in
                guard let data = data,error == nil else {
                    if let error = error {
                        onResponceWasRecived(.failure(error))
                    }
                    return
                }
                
                do{
                    let model = try JSONDecoder().decode(AbstractOutput.self, from: data)
                    onResponceWasRecived(.success(model))
                    saveResponseToCache(response, cachedData: data, by: request)
                } catch {
                    onResponceWasRecived(.failure(error))
                }
            }.resume()
            
        } catch {
            onResponceWasRecived(.failure(error))
        }
    }
    
}

extension BaseNetworkTask where Input == EmptyModel {
    func performRequest(onResponceWasRecived: @escaping (Result<AbstractOutput, Error>) -> Void) {
        performRequest(input: EmptyModel(), onResponceWasRecived: onResponceWasRecived)
    }
}

//MARK: - Cache Logic

private extension BaseNetworkTask {
    
    func getCachedResponceFromCache(by request: URLRequest) -> CachedURLResponse? {
        return urlCache.cachedResponse(for: request)
    }
    
    func saveResponseToCache(_ response: URLResponse?, cachedData: Data?,by request: URLRequest) {
        guard let response = response, let cachedData = cachedData else { return }
       let cachedURLResponse =  CachedURLResponse(response: response, data: cachedData)
        urlCache.storeCachedResponse(cachedURLResponse, for: request)
    }
}

//MARK: - Private methods

private extension BaseNetworkTask {
    
    enum NetworkTaskError: Error {
        case urlWasNotFound
        case urlWasNotCreated
        case parametersIsNotValidJsonObject
        case unknownError
    }
    
    func getRequest(with parameters: AbstractInput) throws -> URLRequest {
        guard let url = completedURL else { throw NetworkTaskError.urlWasNotFound }
        
        var request: URLRequest
        
        switch method {
        case .get:
           let newURl = try getURLWithQueryParameters(for: url, parameters: parameters)
            request = URLRequest(url: newURl)
        case .post:
            request = URLRequest(url: url)
            request.httpBody = try getParametersForBody(from: parameters)
        }
        
        request.httpMethod = method.method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if isNeedInjectToken {
            request.addValue("Token \(try tokenStorage.getToken().token)", forHTTPHeaderField: "Authorization")
        }
        
        
        return request
    }
    
    func getParametersForBody(from encodableParameters: AbstractInput) throws -> Data {
        return try JSONEncoder().encode(encodableParameters)
    }
    
    func getURLWithQueryParameters(for url:URL,parameters: AbstractInput) throws -> URL {
        guard var urlComponents = URLComponents(url: url,resolvingAgainstBaseURL: true) else {
            throw NetworkTaskError.urlWasNotCreated
        }
        
        let parametersInDataRepresentation = try JSONEncoder().encode(parameters)
        let parametersInDictRepresentation = try JSONSerialization.jsonObject(with: parametersInDataRepresentation)
        
        guard let parametersInDictRepresentation = parametersInDictRepresentation as? [String: Any] else { throw NetworkTaskError.parametersIsNotValidJsonObject}
        
       let queryItems = parametersInDictRepresentation.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        if !queryItems.isEmpty {
        urlComponents.queryItems = queryItems
        }
        
        guard let newURLWithQuery = urlComponents.url else { throw NetworkTaskError.urlWasNotFound }
        
        return newURLWithQuery
        
    }
    

    
}
