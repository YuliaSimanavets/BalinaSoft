//
//  UploadData.swift
//  BalinaSoft
//
//  Created by Yuliya on 24/09/2023.
//

import UIKit

struct UploadData: Codable {
    let id: Int
    let name: String
    let photo: Data
}
//
//extension UIImage {
//    var data: Data? {
//        if let data = self.jpegData(compressionQuality: 1.0) {
//            return data
//        } else {
//            return nil
//        }
//    }
//}
//
//extension Data {
//    var image: UIImage? {
//        if let image = UIImage(data: self) {
//            return image
//        } else {
//            return nil
//        }
//    }
//}
/*
struct UploadData: Codable {
    let id: Int
    let name: String
    let photo: Data
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo
    }
    
    init(id: Int, name: String, photo: UIImage) {
        self.id = id
        self.name = name
        
        // Конвертируем изображение UIImage в данные Data
        if let photoData = photo.pngData() {
            self.photo = photoData
        } else {
            fatalError("Failed to convert UIImage to Data")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(photo, forKey: .photo)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        photo = try container.decode(Data.self, forKey: .photo)
    }
}
*/
