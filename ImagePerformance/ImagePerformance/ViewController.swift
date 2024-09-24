//
//  ViewController.swift
//  ImagePerformance
//
//  Created by nylah.j on 9/12/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    private var originImageView: UIImageView!
    private var imageView: UIImageView!
    private var stepScaledImageView: UIImageView!
    private var sharpenFilterImageView: UIImageView!
    private var imageViews: [UIImageView] = []
    private var scaledImageViews: [UIImageView] = []
    
    
    private let bookCorverUrl: URL = URL(string: "https://story-a.tapas.io/prod/story/9928b181-d589-4cc6-a4d6-0ab67b17eff2/bc/2x/6d91f071-65e7-49fa-a18e-31a2e0346364.heic")!
    private let comicCoverUrl: URL =  URL(string: "https://dev-story-a.tapas.io/qa/story/170601/c2/2x/c2_The_Lady_and_Her_Butler.heic")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("$$ current display scale: ", traitCollection.displayScale)
        view.backgroundColor = .white
        let (bookCardWidth, bookCardHeight): (CGFloat, CGFloat) = (101, 152)
        let bookCardImageSize = CGSize(width: bookCardWidth, height: bookCardHeight)
        let width: CGFloat = abs(view.frame.width / 3)
        let height: CGFloat = width * 2
        let (x, y): (CGFloat, CGFloat) = (10, 10)
        
        
        originImageView = UIImageView(frame: CGRect(x: 10, y: 100, width: bookCardWidth, height: bookCardHeight))
        imageView = UIImageView(frame: CGRect(x: 10 + width + 10, y: 100, width: bookCardWidth, height: bookCardHeight))
        
        stepScaledImageView = UIImageView(frame: CGRect(x:10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight))
        sharpenFilterImageView = UIImageView(frame: CGRect(x: 10 + width + 10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight))
        
        imageViews = [originImageView, imageView, stepScaledImageView, sharpenFilterImageView]
        scaledImageViews = [imageView, stepScaledImageView, sharpenFilterImageView]
        
        imageViews.forEach { view.addSubview($0) }
        
        originImageView.sd_setImage(with: bookCorverUrl)
        
        downloadAndResizeWithURLSessionWitoutThumbnail(imageView: imageView, url: bookCorverUrl, targetSize: imageView.frame.size, interpolation: "CILanczosScaleTransform")
        downloadAndResizeStepByStep(imageView: stepScaledImageView, url: bookCorverUrl, targetSize: stepScaledImageView.frame.size, interpolation: "CILanczosScaleTransform")
        downloadImage(imageView: sharpenFilterImageView, url: bookCorverUrl) { data in
            guard let data else { return nil }
            
            if let ciImage = CIImage(data: data) {
                return ciImage.applyInterpolationWithSharpening(targetSize: bookCardImageSize, interpolation: "CILanczosScaleTransform")
            }
            
            return nil
        }
    }
    
    func setBookCoverImage() {
        SDWebImageManager.shared.loadImage(with: bookCorverUrl, context: nil, progress: nil) { [weak self] image, data, error, cacheType, finished, url in
            self?.imageView.image = image?.downsampleImage(for: self?.imageView.frame.size ?? .zero)
        }
        
        
        
        // SDWebImageCoderOption: // width, height를 줄이는 작업을 하지 않는다.
        //        let decodeOptions : [SDImageCoderOption : Any] = [
        //            SDImageCoderOption.decodeThumbnailPixelSize: imageView.frame.size
        //        ]
        //        let context = [SDWebImageContextOption.imageDecodeOptions : decodeOptions]
        //        imageView.sd_setImage(with: bookCorverUrl, placeholderImage: nil, context: context)
        
        //         CGImageSourceCreateThumbnailAtIndex 사용 O!!!! , 그런데 이미지가 조금 뭉게지는 것 같아요...
        //        imageView.sd_setImage(with: bookCorverUrl, placeholderImage: nil, options: [], context: [.imageThumbnailPixelSize : imageView.frame.size, .imagePreserveAspectRatio: false])
        
        // 애니메이션 이미지에서
        //        imageView.sd_setImage(with: bookCorverUrl, placeholderImage: nil, options: .decodeFirstFrameOnly)   // -> CGImageSourceCreateThumbnailAtIndex 사용 X
        
        //        let transformer = SDImageResizingTransformer(size: imageView.frame.size, scaleMode: .aspectFill)
        //        imageView.sd_setImage(with: bookCorverUrl, placeholderImage: nil, options: [], context:  [.imageTransformer: transformer])   // -> CGImageSourceCreateThumbnailAtIndex 사용 X
        
        //        imageView.sd_setImage(with: bookCorverUrl, placeholderImage: nil, options: .scaleDownLargeImages)   // -> CGImageSourceCreateThumbnailAtIndex 사용 X
        //        imageView.sd_setImage(with: bookCorverUrl)  // -> CGImageSourceCreateThumbnailAtIndex 사용 X
        
        
        //        imageView.sd_setImage(with: bookCorverUrl, placeholderImage: nil, options: []) // 아무것도 지정하지 않은 것
    }
    
    func customBookCorverImage() {
        //        let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil)!
        //       let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
        //       let options: [CFString : Any] = [
        //           kCGImageSourceThumbnailMaxPixelSize: 100,
        //           kCGImageSourceCreateThumbnailFromImageAlways: true
        //       ]
        //       let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)!
        //       let image = UIImage(cgImage: scaledImage)
        //       imageView.image = image
    }
    
    
}

extension ViewController {
    func downloadAndResizeWithURLSession(url: URL, targetSize: CGSize) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to download image: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            let imageSource = CGImageSourceCreateWithData(data as CFData, nil)
            
            // Set options for downscaling using ImageIO
            
            let options: [CFString : Any] = [
                kCGImageSourceThumbnailMaxPixelSize: targetSize.width > targetSize.height ? targetSize.width : targetSize.height, // Define the max pixel size
                kCGImageSourceCreateThumbnailFromImageAlways: true
            ]
            
            // Downscale the image using ImageIO
            if let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource!, 0, options as CFDictionary) {
                
                // Optionally apply bicubic interpolation
                DispatchQueue.main.async {
                    let currentSize: CGSize = CGSize(width: scaledImage.width, height: scaledImage.height)
                    
                    if let resizedImage = scaledImage.resizeWithInterpolation(
                        currentSize: currentSize,
                        targetSize: targetSize,
                        interpolation: "CILanczosScaleTransform")  {
                        
                        self.scaledImageViews.forEach { imageView in
                            imageView.image = UIImage(cgImage: resizedImage)
                        }
                    } else {
                        let downScaledImage = UIImage(cgImage: scaledImage)
                        
                        self.scaledImageViews.forEach { imageView in
                            imageView.image = downScaledImage
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    func downloadImage(imageView: UIImageView, url: URL, makeCIImage: @escaping (Data?) -> CIImage?) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to download image: \(error)")
                return
            }
            
            guard let imageData = data else {
                print("No data received")
                return
            }
            
            // Create CIImage from raw image data
            if let ciImage = makeCIImage(imageData),
               let cgImage = CIContext(options: [.useSoftwareRenderer:false]).createCGImage(ciImage, from: ciImage.extent) { // Apply interpolation
                let uiimage = UIImage(cgImage: cgImage)
                
                DispatchQueue.main.async {
                    imageView.image = uiimage
                }
            }
        }
        task.resume()
    }
    
    func downloadAndResizeWithURLSessionWitoutThumbnail(imageView: UIImageView, url: URL, targetSize: CGSize, interpolation: String) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to download image: \(error)")
                return
            }
            
            guard let imageData = data else {
                print("No data received")
                return
            }
            
            // Create CIImage from raw image data
            if let ciImage = CIImage(data: imageData),
               let interpolatedImage = ciImage.applyInterpolation(targetSize: targetSize, interpolation: interpolation),
               let cgImage = CIContext(options: [.useSoftwareRenderer:false]).createCGImage(interpolatedImage, from: interpolatedImage.extent) { // Apply interpolation
                let uiimage = UIImage(cgImage: cgImage)
                
                DispatchQueue.main.async {
                    imageView.image = uiimage
                }
            }
        }
        
        task.resume()
    }
    
    func downloadAndResizeStepByStep(imageView: UIImageView, url: URL, targetSize: CGSize, interpolation: String) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to download image: \(error)")
                return
            }
            
            guard let imageData = data else {
                print("No data received")
                return
            }
            
            // Create CIImage from raw image data
            if let ciImage = CIImage(data: imageData),
               let interpolatedImage = ciImage.applyStepByStepInterpolation(targetSize: targetSize, interpolation: interpolation),
               let cgImage = CIContext(options: [.useSoftwareRenderer:false]).createCGImage(interpolatedImage, from: interpolatedImage.extent) { // Apply interpolation
                let uiimage = UIImage(cgImage: cgImage)
                
                DispatchQueue.main.async {
                    imageView.image = uiimage
                }
            }
        }
        
        task.resume()
    }
}

extension CIImage {
    func applyInterpolation(targetSize: CGSize, interpolation: String) -> CIImage? {
        let filter = CIFilter(name: interpolation)
        filter?.setValue(self, forKey: kCIInputImageKey)
        
        let scaleWidth = targetSize.width / extent.width
        let scaleHeight = targetSize.height / extent.height
        let scale = max(scaleWidth, scaleHeight)
        let refactoredScale = scale * 2
        
        print("$$ extent \(extent) - targetSize: \(targetSize) - originScale: \(scale) - scale: \(refactoredScale)")
        filter?.setValue(NSNumber(value: Double(0.5)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        return filter?.outputImage
    }
    
    func applyStepByStepInterpolation(targetSize: CGSize, interpolation: String) -> CIImage? {
        // Initial size
        var currentImage = self
        let initialSize = self.extent.size
        
        // Calculate the number of steps for downscaling
        let stepCount = 10 // You can adjust this value to control the number of downscaling steps
        let widthStep = (initialSize.width - targetSize.width) / CGFloat(stepCount)
        let heightStep = (initialSize.height - targetSize.height) / CGFloat(stepCount)
        
        // Perform downscaling in steps
        for i in 1...stepCount {
            let intermediateSize = CGSize(
                width: initialSize.width - (widthStep * CGFloat(i)),
                height: initialSize.height - (heightStep * CGFloat(i))
            )
            let scale = max(intermediateSize.width / currentImage.extent.width, intermediateSize.height / currentImage.extent.height)
            
            let filter = CIFilter(name: interpolation)
            filter?.setValue(currentImage, forKey: kCIInputImageKey)
            filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
            filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
            
            if let outputImage = filter?.outputImage {
                currentImage = outputImage
            } else {
                return nil
            }
        }
        
        // Final scaling to the target size
        let finalScale = max(targetSize.width / currentImage.extent.width, targetSize.height / currentImage.extent.height)
        let filter = CIFilter(name: interpolation)
        filter?.setValue(currentImage, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(finalScale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        
        return filter?.outputImage
    }
    
    func applyInterpolationWithSharpening(targetSize: CGSize, interpolation: String) -> CIImage? {
        // Initial size
        var currentImage = self
        let initialSize = self.extent.size
        
        // Calculate the number of steps for downscaling
        let stepCount = 100 // Number of intermediate downscaling steps
        let widthStep = (initialSize.width - targetSize.width) / CGFloat(stepCount)
        let heightStep = (initialSize.height - targetSize.height) / CGFloat(stepCount)
        
        // Perform downscaling in steps
        for i in 1...stepCount {
            let intermediateSize = CGSize(
                width: initialSize.width - (widthStep * CGFloat(i)),
                height: initialSize.height - (heightStep * CGFloat(i))
            )
            let scale = max(intermediateSize.width / currentImage.extent.width, intermediateSize.height / currentImage.extent.height)
            
            let filter = CIFilter(name: interpolation)
            filter?.setValue(currentImage, forKey: kCIInputImageKey)
            filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
            filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
            
            if let outputImage = filter?.outputImage {
                currentImage = outputImage
            } else {
                return nil
            }
        }
        
        // Final scaling to the target size
        let finalScale = max(targetSize.width / currentImage.extent.width, targetSize.height / currentImage.extent.height)
        let filter = CIFilter(name: interpolation)
        filter?.setValue(currentImage, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(finalScale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        
        guard let downscaledImage = filter?.outputImage else { return nil }
        
        // Apply sharpening filter to enhance image quality
        let sharpenFilter = CIFilter(name: "CISharpenLuminance")
        sharpenFilter?.setValue(downscaledImage, forKey: kCIInputImageKey)
        sharpenFilter?.setValue(0.4, forKey: kCIInputSharpnessKey) // Adjust sharpness value as needed
        
        return sharpenFilter?.outputImage
    }
    
    func applySharpening(targetSize: CGSize, interpolation: String) -> CIImage? {
        // Final scaling to the target size
        let scale = max(targetSize.width / self.extent.width, targetSize.height / self.extent.height)
        let filter = CIFilter(name: interpolation)
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        
        guard let downscaledImage = filter?.outputImage else { return nil }
        
        // Apply sharpening filter to enhance image quality
        let sharpenFilter = CIFilter(name: "CISharpenLuminance")
        sharpenFilter?.setValue(downscaledImage, forKey: kCIInputImageKey)
        sharpenFilter?.setValue(0.4, forKey: kCIInputSharpnessKey) // Adjust sharpness value as needed
        
        return sharpenFilter?.outputImage
    }
    
    func applyHigherSizeAndSharpen(targetSize: CGSize, interpolation: String) -> CIImage? {
        let adjustedTargetSize = CGSize(width: targetSize.width * 1.5, height: targetSize.height * 1.5)
        let scaleWidth = adjustedTargetSize.width / extent.width
        let scaleHeight = adjustedTargetSize.height / extent.height
        let scale = max(scaleWidth, scaleHeight)
        
        let filter = CIFilter(name: "CILanczosScaleTransform")
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        
        guard let outputImage = filter?.outputImage else { return nil }
        
        let sharpenFilter = CIFilter(name: "CISharpenLuminance")
        sharpenFilter?.setValue(outputImage, forKey: kCIInputImageKey)
        sharpenFilter?.setValue(0.4, forKey: kCIInputSharpnessKey)
        
        return sharpenFilter?.outputImage
    }
    
    func applySmoothingAfterDownscale(targetSize: CGSize, interpolation: String) -> CIImage? {
        let scale = min(targetSize.width / self.extent.width, targetSize.height / self.extent.height)
        let filter = CIFilter(name: interpolation)
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        
        guard let downscaledImage = filter?.outputImage else { return nil }
        
        // Apply Gaussian blur to smooth out artifacts
        let smoothingFilter = CIFilter(name: "CIGaussianBlur")
        smoothingFilter?.setValue(downscaledImage, forKey: kCIInputImageKey)
        smoothingFilter?.setValue(2.0, forKey: kCIInputRadiusKey) // Adjust blur radius as needed
        
        return smoothingFilter?.outputImage
    }
}



extension CGImage {
    func resizeWithInterpolation(currentSize: CGSize, targetSize: CGSize, interpolation: String) -> CGImage? {
        
        let ciImage = CIImage(cgImage: self)
        
        let filter = CIFilter(name: interpolation)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(targetSize.width / currentSize.width)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        
        guard let outputCIImage = filter?.outputImage,
              let outputCGImage = CIContext(options: nil).createCGImage(outputCIImage, from: outputCIImage.extent) else {
            return nil
        }
        
        return outputCGImage
    }
}



extension UIImage {
    func downsampleImage(for size: CGSize) -> UIImage? {
        var aspectFillSize = size
        
        let newWidth: CGFloat = size.width / self.size.width
        let newHeight: CGFloat = size.height / self.size.height
        
        if newHeight > newWidth {
            aspectFillSize.width = newHeight * self.size.width
        } else if newHeight < newWidth {
            aspectFillSize.height = newWidth * self.size.height
        }
        
        let renderer = UIGraphicsImageRenderer(size: aspectFillSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: aspectFillSize))
        }
    }
}

