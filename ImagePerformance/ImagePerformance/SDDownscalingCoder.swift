//
//  SDDownscalingCoder.swift
//  ImagePerformance
//
//  Created by nylah.j on 9/26/24.
//

import Foundation
import SDWebImage

final class SDDownscalingCoder: SDImageIOCoder {
    override func canDecode(from data: Data?) -> Bool {
        print("$$ canDecode")
        return super.canDecode(from: data)
    }
    
    override func decodedImage(with data: Data?, options: [SDImageCoderOption : Any]? = nil) -> UIImage? {
        let size = options?[SDImageCoderOption.decodeThumbnailPixelSize] as? CGSize
        print("$$ size in options: \(size), options: \(options?[SDImageCoderOption.decodeThumbnailPixelSize])")
        
        guard let data else {
            return super.decodedImage(with: data, options: options)
        }
        
        guard let ciImage = CIImage(data: data) else {
            return super.decodedImage(with: data, options: options)
        }
        
        let targetSize: CGSize
        if let size, size == .zero {
            targetSize = ciImage.extent.size
        } else if let size {
            targetSize = size
        } else {
            targetSize = ciImage.extent.size
        }
        
        if let interpolatedImage = ciImage.applyInterpolation(targetSize: targetSize, interpolation: "CILanczosScaleTransform"),
           let cgImage = CIContext(options: [.useSoftwareRenderer:true]).createCGImage(interpolatedImage, from: interpolatedImage.extent) {
            let uiimage = UIImage(cgImage: cgImage)
            return uiimage
        }
        return super.decodedImage(with: data, options: options)
    }
}
