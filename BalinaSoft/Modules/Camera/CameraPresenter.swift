//
//  CameraPresenter.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation
import UIKit

protocol CameraViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol CameraPresenterProtocol {
    func uploadData(photo: UIImage)
}

final class CameraPresenter: CameraPresenterProtocol {

    weak var view: CameraViewProtocol?
    private let dataManager: DataManagerProtocol?

    private var userId: Int
    private var userName: String
    
    init(view: CameraViewProtocol, dataManager: DataManagerProtocol?, userId: Int, userName: String) {
        self.view = view
        self.dataManager = dataManager
        self.userId = userId
        self.userName = userName
    }

    func uploadData(photo: UIImage) {
        
//        guard let photoData = photo.jpegData(compressionQuality: 0.2) else { return }
//        let photoString = photoData.base64EncodedString()
//
//        let uploadData = UploadData(id: userId, name: userName, photo: photoString)
//
//        dataManager?.post(uploadData: uploadData) { result in
//            switch result {
//            case .success(let responseString):
//                print("Response: \(responseString)")
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
    }
}

