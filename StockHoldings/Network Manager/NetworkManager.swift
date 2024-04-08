//
//  HTTPMethod.swift
//
//
//  Created by Akshay Rathi on 22/02/24.
//


import Foundation
import UIKit

public class NetworkManager {
    public static let shared = NetworkManager()
    private init() {}
    
    private func getUrl(from api: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.baseUrl
        components.path = api.path
        var urlQueryItems : [URLQueryItem] = []
        if let queryParams = api.queryParams {
            queryParams.forEach({
                element in
                let urlQueryItem = URLQueryItem(name: element.key, value: element.value)
                urlQueryItems.append(urlQueryItem)
            })
        }
        components.queryItems = urlQueryItems
        return components
    }
    
    func fetchData<T: Decodable>(_ api: API,  completionHandler: @escaping (Result<T, Errors>) -> Void) {
        let components = getUrl(from: api)
        
        guard let url = components.url else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        
        fetchResponse(urlRequest, completionHandler: completionHandler)
        
    }
    
    private func fetchResponse<T: Decodable>(_ urlRequest: URLRequest,  completionHandler: @escaping (Result<T, Errors>) -> Void) {
            
        URLSession.shared.dataTask(with: urlRequest , completionHandler: {
            (data, resposone, error)-> Void in
            if error != nil {
                completionHandler(.failure(.genericError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataDoNotExist))
                return
            }
            if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async(execute: {
                    completionHandler(.success(object))
                })
            } else {
                completionHandler(.failure(.invalidDataFormat))
            }
        }).resume()
    }
}
