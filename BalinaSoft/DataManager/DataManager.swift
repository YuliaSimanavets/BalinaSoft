//
//  DataManager.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation

protocol DataManagerProtocol {
    func getData(completion: @escaping (Result<[Content], Error>) -> ())
    func upload(_ uploadData: UploadData, completion: @escaping (Result<UploadData?, Error>) -> Void)
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
    
    func upload(_ uploadData: UploadData, completion: @escaping (Result<UploadData?, Error>) -> Void) {

        let url = URL(string: "https://junior.balinasoft.com/api/v2/photo")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBodyWithParameters(parameters: uploadData,
                                                    imageData: uploadData.photo)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data ?? Data()) as? UploadData
                
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func createBodyWithParameters(parameters: UploadData, imageData: Data) -> Data {
        let body = NSMutableData()
        // name
        body.appendString("\"name=\(parameters.name)\"")
        body.appendString("\t")
        
        //photo
        body.appendString("\"photo=")
        body.append(imageData)
        body.appendString(";type=image/jpeg\"")
        body.appendString("\t")
        
        //id
        body.appendString("\"id=\(parameters.id)\"")
        body.appendString("\t")
        return body as Data
    }
}
