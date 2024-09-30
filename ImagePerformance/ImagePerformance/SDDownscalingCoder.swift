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
        guard let size = options?[SDImageCoderOption.decodeThumbnailPixelSize] as? CGSize,
              let data,
              let ciImage = CIImage(data: data) else {
            
            let uiimage =  super.decodedImage(with: data, options: options)
            let bytesPerRow = uiimage?.cgImage?.bytesPerRow ?? .zero
            let height = uiimage?.cgImage?.height ?? .zero
            print("$$ not downscale: \(bytesPerRow * height)")
            return uiimage
        }
            
        print("$$ size in options: \(size), options: \(options?[SDImageCoderOption.decodeThumbnailPixelSize])")
        
        let targetSize: CGSize = if size == .zero {
            ciImage.extent.size
        } else {
            size
        }
        
        if let interpolatedImage = ciImage.applyDownScaling(targetSize: targetSize, interpolation: "CILanczosScaleTransform"),
           let cgImage = CIContext(options: [.useSoftwareRenderer:true]).createCGImage(interpolatedImage, from: interpolatedImage.extent) {
            let uiimage = UIImage(cgImage: cgImage)
            print("$$ after decode cgImageBytes: - \(cgImage.bytesPerRow * cgImage.height)")
            return uiimage
        }
        return super.decodedImage(with: data, options: options)
    }
}

extension CIImage {
    func applyDownScaling(targetSize: CGSize, interpolation: String) -> CIImage? {
        let (scaleWidth, scaleHeight): (CGFloat, CGFloat) = (targetSize.width / extent.width, targetSize.height / extent.height)
        
        let scale = min(scaleWidth, scaleHeight)
        
        print("$$ extent \(extent) - targetSize: \(targetSize) - scaleWidth: \(scaleWidth) - scaleHeight: \(scaleHeight)")

        let filter = CIFilter(name: interpolation)
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        return filter?.outputImage
    }
}
