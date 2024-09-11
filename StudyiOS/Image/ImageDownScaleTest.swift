//
//  ImageDownScaleTest.swift
//  StudyiOS
//
//  Created by 김수현 on 9/11/24.
//

import Foundation
import UIKit
import CoreGraphics


final class ImageDownScaleViewController: UIViewController {
    let imageView: UIImageView = .init(frame: CGRect(x: 20, y: 20, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        downscaleImage()
        
    }
    
    
        
        func downscaleImage() {
            let url = URL(filePath: "./hight_resolution.avif")
            let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil)! // CGImageSourceCreateWithURL로 인스턴스 획득
            let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) // 이미지의 크기 설정, 파라미터를 통해 리사이징된 이미지 획득
            let options: [CFString : Any] = [
                kCGImageSourceThumbnailMaxPixelSize: 100,
                kCGImageSourceCreateThumbnailFromImageAlways: true
            ]
            let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)!
            // 얻어진 CGImage를 UIImage로 감싸서 사용
            let image = UIImage(cgImage: scaledImage)
            imageView.image = image
        }
        
}
