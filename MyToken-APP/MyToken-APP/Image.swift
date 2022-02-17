import Foundation
import UIKit
import SwiftUI

final class ImageCoin {
    
    typealias GRImageDictionary = [String: CGImage]
    fileprivate var images: GRImageDictionary = [:]
    fileprivate static var scale = 2
    static var shared = ImageCoin()
    
    func image(name: String) -> Image {
        let index = guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageCoin.scale), label: Text(verbatim: name))
    }
    
    static func loadPNGImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "png"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).png from main bundle.")
        }
        return image
    }
    fileprivate func guaranteeImage(name: String) -> GRImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageCoin.loadPNGImage(name: name)
        return images.index(forKey: name)!
    }
}
