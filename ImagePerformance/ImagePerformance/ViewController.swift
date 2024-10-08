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
    private var bicubicImageView: UIImageView!
    private var sdThumbnailImageView: UIImageView!
    
    private var stepScaledImageView: UIImageView!
    private var sharpenFilterImageView: UIImageView!
    private var dispalyScaleImageView: UIImageView!
    private var imageViews: [UIImageView] = []
    private var scaledImageViews: [UIImageView] = []
    
    // constants
    private let (bookCardWidth, bookCardHeight): (CGFloat, CGFloat) = (101, 152)
    private var width: CGFloat {
        abs(view.frame.width / 3)
    }
    private var height: CGFloat {
        width * 2
    }
    
    private var rects: [CGRect] {
        [
            CGRect(x: 10, y: 100, width: bookCardWidth, height: bookCardHeight),
            CGRect(x: 10 + width + 10, y: 100, width: bookCardWidth, height: bookCardHeight),
            
            CGRect(x:10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight),
            CGRect(x: 10 + width + 10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight),
            
            CGRect(x: 10, y: 10 + height * 2 + 10, width: bookCardWidth, height: bookCardHeight),
            CGRect(x: 10 + width, y: 10 + height * 2 + 10, width: bookCardWidth, height: bookCardHeight),
            
            CGRect(x: 10, y: 10 + height * 3 + 10, width: bookCardWidth, height: bookCardHeight),
        ]
    }
    
    // url
    private let bookCorverUrl: URL = URL(string: "https://story-a.tapas.io/prod/story/9928b181-d589-4cc6-a4d6-0ab67b17eff2/bc/2x/6d91f071-65e7-49fa-a18e-31a2e0346364.heic")!
    private let bookCorverUrl2: URL = URL(string: "https://story-a.tapas.io/prod/story/cef4dc69-f7bf-40ad-a4ed-d37563379ec6/bc/2x/8d9d6365-7bca-4efb-b995-e950847259be.heic")! // 9MB
    private let comicCoverUrl: URL =  URL(string: "https://dev-story-a.tapas.io/qa/story/170601/c2/2x/c2_The_Lady_and_Her_Butler.heic")!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // constant
        print("$$ current display scale: ", traitCollection.displayScale)
        let bookCardImageSize = CGSize(width: bookCardWidth, height: bookCardHeight)
        let (x, y): (CGFloat, CGFloat) = (10, 10)
        
        
        // make image view
        originImageView = UIImageView(frame: CGRect(x: 10, y: 100, width: bookCardWidth, height: bookCardHeight))
        imageView = UIImageView(frame: CGRect(x: 10 + width + 10, y: 100, width: bookCardWidth, height: bookCardHeight))
        bicubicImageView = UIImageView(frame: CGRect(x:10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight))
        sdThumbnailImageView = UIImageView(frame: CGRect(x:10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight))
        
        sharpenFilterImageView = UIImageView(frame: CGRect(x: 10 + width + 10, y: 10 + height + 10, width: bookCardWidth, height: bookCardHeight))
        
        dispalyScaleImageView = UIImageView(frame: CGRect(x: 10, y: 10 + height * 2 + 10, width: bookCardWidth, height: bookCardHeight))
        stepScaledImageView = UIImageView(frame: CGRect(x: 10 + width, y: 10 + height * 2 + 10, width: bookCardWidth, height: bookCardHeight))
        
        scaledImageViews = [imageView, stepScaledImageView, sharpenFilterImageView, dispalyScaleImageView]
        imageViews = [originImageView, imageView, bicubicImageView, sdThumbnailImageView, stepScaledImageView, sharpenFilterImageView, dispalyScaleImageView, bicubicImageView]

        zip(imageViews, rects)
            .forEach { (imageView, rect) in
                imageView.frame = rect
            }
        
        imageViews.forEach { view.addSubview($0) }
        
            
//         1. setImage
//        originImageView.sd_setImage(with: bookCorverUrl2) { image, _, _, _ in
//            if let cgimage = image?.cgImage {
//                let bytes = cgimage.bytesPerRow * cgimage.height
//                print("$$ origin image bytes - \(bytes)")
//            }
//        }
        
//        2. SDImageCoderOption으로 target size를 지정
//        useSdImageCoderOption(url: bookCorverUrl2, imageView: imageView)
        
        
//        3. imageThumbnailSize context option으로 target size를 지정
        useContextToSetPixelSize(url: bookCorverUrl2, imageView: imageView)

//         4. URLSession을 사용해서 이미지 다운로드 -> interpolation을 이용해서 직접 다운스케일링 수행
//        downloadAndResizeWithURLSessionWitoutThumbnail(imageView: imageView, url: bookCorverUrl2, targetSize: imageView.bounds.size, interpolation: "CILanczosScaleTransform")
        
//        downloadAndResizeStepByStep(imageView: stepScaledImageView, url: bookCorverUrl, targetSize: stepScaledImageView.bounds.size, interpolation: "CILanczosScaleTransform")
//        downloadImage(imageView: sharpenFilterImageView, url: bookCorverUrl) { data in
//            if let ciImage = CIImage(data: data) {
//                return ciImage.applyInterpolationWithSharpening(targetSize: bookCardImageSize, interpolation: "CILanczosScaleTransform")
//            }
//            
//            return nil
//        }
//        
//        
//        downloadImage(imageView: dispalyScaleImageView, url: bookCorverUrl, makeCIImage: { data in
//            if let ciImage = CIImage(data: data) {
//                return ciImage.applyDisplayScaleInterplation(targetSize: bookCardImageSize, interpolation: "CILanczosScaleTransform", displayScale: displayScale)
//            }
//            
//            return nil
//        })
//      
        
//         -- biciubic algorithm 사용
//        downloadImage(imageView: bicubicImageView, url: bookCorverUrl2) { data in
//            if let ciImage = CIImage(data: data) {
//                return ciImage.applyInterpolation(targetSize: bookCardImageSize, interpolation: "CIBicubicScaleTransform")
//            }
//            return nil
//        }
    }
    
    /// SDWebImageCoderOption: width, height를 줄이는 작업을 하지 않는다.
    func useSdImageCoderOption(url: URL, imageView: UIImageView) {
        let displayScale = UITraitCollection.current.displayScale
        let targetSize = CGSize(width: imageView.bounds.width * displayScale, height: imageView.bounds.height * displayScale)
        
        let decodeOptions : [SDImageCoderOption : CGSize] = [
            SDImageCoderOption.decodeThumbnailPixelSize: targetSize
        ]
        
        print("$$ set sdImageCoderOption.thumbnailPixelSize: ", targetSize)
        let context = [SDWebImageContextOption.imageDecodeOptions : decodeOptions]
        imageView.sd_setImage(with: url, placeholderImage: nil, context: context)
    }
    

    /// CGImageSourceCreateThumbnailAtIndex 사용 O!!!! , 그런데 이미지가 조금 뭉게지는 것 같아요...
    func useContextToSetPixelSize(url: URL, imageView: UIImageView) {
        let displayScale = UITraitCollection.current.displayScale
        let targetSize = CGSize(width: imageView.bounds.width * displayScale, height: imageView.bounds.height * displayScale)
        
        let decodeOptions : [SDImageCoderOption : CGSize] = [
            SDImageCoderOption.decodeThumbnailPixelSize: targetSize
        ]
        
        
        imageView.sd_setImage(with: url, placeholderImage: nil, options: [], context: [
            .imageThumbnailPixelSize : targetSize,
            .imageDecodeOptions : decodeOptions,
            .imageCoder: SDDownscalingCoder()
        ])
    }
        
        
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
//    }
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
    
    func downloadImage(imageView: UIImageView, url: URL, makeCIImage: @escaping (Data) -> CIImage?) {
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
                let imageSize = cgImage.bytesPerRow * cgImage.height
                print("$$ downloadImage - imageSize: ", imageSize)
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
               let cgImage = CIContext(options: [.useSoftwareRenderer:true]).createCGImage(interpolatedImage, from: interpolatedImage.extent) { // Apply interpolation
                let uiimage = UIImage(cgImage: cgImage)
                
                let imageSize = cgImage.bytesPerRow * cgImage.height
                print("$$ lanchos image size: ", imageSize)
                
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
    
    func sdDownloadWithResizing(imageView: UIImageView, url: URL, targetSize: CGSize) {
        let transformer = SDImageResizingTransformer(size: targetSize, scaleMode: .fill)
        SDWebImageManager.shared.loadImage(
            with: url,
            options: [.fromLoaderOnly],
            context: [.storeCacheType: SDImageCacheType.none.rawValue],
            progress: nil,
            completed: { [weak self] (image, data, error, cacheType, finished, url) in
                imageView.image = image
            }
        )
    }
}

extension CIImage {
    func applyInterpolation(targetSize: CGSize, interpolation: String) -> CIImage? {
        let displayScale: CGFloat = UITraitCollection.current.displayScale
        let (widthPointCount, heightPointCount): (CGFloat, CGFloat) = (displayScale * targetSize.width, displayScale * targetSize.height)
        let (scaleWidth, scaleHeight): (CGFloat, CGFloat) = (widthPointCount / extent.width, heightPointCount / extent.height)
        
        let scale = min(scaleWidth, scaleHeight)
//        let scale = 0.5
        
        print("$$ extent \(extent) - targetSize: \(targetSize) - scaleWidth: \(scaleWidth) - scaleHeight: \(scaleHeight)")

        let filter = CIFilter(name: interpolation)
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
        filter?.setValue(1.0, forKey: kCIInputAspectRatioKey)
        return filter?.outputImage
    }
    
    func applyDisplayScaleInterplation(targetSize: CGSize, interpolation: String, displayScale: CGFloat) -> CIImage? {
        // 배수를 하게 되면, downscale이 아니라 upscale이 될 수 있는 우려가 있다.
        let scaledTargetSize = CGSize(width: targetSize.width * displayScale, height: targetSize.height * displayScale)
        let scale = min(scaledTargetSize.width / self.extent.width, scaledTargetSize.height / self.extent.height)
        
        print("$$ scale: \(scale) - width: \(scaledTargetSize.width / self.extent.width) - height: \(scaledTargetSize.height / self.extent.height)")
        
        let filter = CIFilter(name: interpolation)
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: Double(scale)), forKey: kCIInputScaleKey)
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

