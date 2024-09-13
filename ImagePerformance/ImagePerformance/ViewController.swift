//
//  ViewController.swift
//  ImagePerformance
//
//  Created by nylah.j on 9/12/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    private let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 200, height: 400))
    
    private let bookCorverUrl: URL = URL(string: "https://dev-story-a.tapas.io/qa/story/226753/bc/2x/Cover_Art__Rise_of_the_Warbringers_.heic")!
    private let comicCoverUrl: URL =  URL(string: "https://dev-story-a.tapas.io/qa/story/170601/c2/2x/c2_The_Lady_and_Her_Butler.heic")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        setBookCoverImage()
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
