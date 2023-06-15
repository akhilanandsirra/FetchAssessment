//
//  ImageView.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 14/06/23.
//

import SwiftUI

struct ImageView: View {
    let imageUrl: URL
    let placeholderImage: UIImage?
    
    @State private var loadedImage: UIImage?
    
    var body: some View {
        Image(uiImage: loadedImage ?? placeholderImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                loadAndCacheImage()
            }
    }
    
    private func loadAndCacheImage() {
        UIImageView().load(url: imageUrl, placeholder: placeholderImage) { image in
            loadedImage = image
        }
    }
}

extension UIImageView {
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil, completion: @escaping (UIImage?) -> Void) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
                completion(image)
            }
        } else {
            self.image = placeholder
            
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let data = data, let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                let cachedData = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                
                DispatchQueue.main.async {
                    self?.image = image
                    completion(image)
                }
            }.resume()
        }
    }
}


