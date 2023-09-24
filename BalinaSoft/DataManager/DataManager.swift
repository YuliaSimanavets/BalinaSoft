//
//  DataManager.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation

protocol DataManagerProtocol {
    func getData(completion: @escaping (Result<[Content], Error>) -> ())
//    func post(uploadData: UploadData, completion: @escaping (Result<UploadData?, Error>) -> Void)
}

final class DataManager: DataManagerProtocol {
        
    var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "junior.balinasoft.com"
        return components
    }()
    
    func getData(completion: @escaping (Result<[Content], Error>) -> ()) {
        
        components.path = "/api/v2/photo/type"
        guard let url = components.url?.absoluteString else { return }

        let request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if error != nil {
                print("error")
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let responseData = data {

                let data = try? JSONDecoder().decode(Main.self, from: responseData)

                DispatchQueue.main.async {
                    completion(.success(data?.content ?? []))
                }
            }
        }
        task.resume()
    }
}
