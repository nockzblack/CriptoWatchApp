//
//  ImageService.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 19/08/23.
//

import UIKit

final class ImageService {
    
    // MARK: - Public API
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            // Helper
            var image: UIImage?
            
            defer {
                // Execute handle on main thread
                DispatchQueue.main.async {
                    // Execute Handler
                    completion(image)
                }
            }
            
            if let data = data {
                // Create image from data
                image = UIImage(data: data)
            }
        }
        
        // Resume data task
        dataTask.resume()
        
        return dataTask
    }
}
