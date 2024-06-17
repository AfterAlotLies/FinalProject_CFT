//
//  NetworkManager.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import Alamofire
import AlamofireImage

protocol INetworkManager {
    func getImageFromUrl(_ url: String, completion: @escaping (Image?, Error?) -> Void)
    func getProducts(for category: RequestType, completion: @escaping ([DataRepository]?, Error?) -> Void)
}

class NetworkManager: INetworkManager {
    
    func getProducts(for category: RequestType, completion: @escaping ([DataRepository]?, Error?) -> Void) {
        let url = "https://fakestoreapi.com/products/category/\(category.rawValue)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: [DataRepository].self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getImageFromUrl(_ url: String, completion: @escaping (Image?, Error?) -> Void) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(image, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
