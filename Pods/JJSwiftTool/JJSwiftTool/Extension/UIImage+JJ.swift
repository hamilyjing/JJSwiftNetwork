//
//  UIImage+JJ.swift
//  PANewToapAPP
//
//  Created by cmh on 16/9/26.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit
import Foundation
import Accelerate

extension UIImage {
    
    public static func jjs_initResizebleWidth(imageName: String) -> UIImage?
    {
        let image = UIImage(named: imageName)
        return (image?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, (image?.size.width)! * 0.5, 0, (image?.size.width)! * 0.5), resizingMode: UIImageResizingMode.stretch))!
    }
    
    public static func jjs_initResizebleHeight(imageName: String) -> UIImage?
    {
        let image = UIImage(named: imageName)
        
        return (image?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, (image?.size.height)! * 0.5, 0, (image?.size.height)! * 0.5), resizingMode: UIImageResizingMode.stretch))!
    }
    
    public static func jjs_scaleName(imageName: String) -> String?
    {
        let url = URL(string: imageName)
        let suffix = url?.pathExtension
        if 0 == suffix?.characters.count || suffix?.lowercased() == "png" || imageName.isEmpty
        {
            return imageName
        }
        
        let nameNoSuffix = url!.deletingPathExtension()
        let scale = NSInteger(UIScreen.main.scale)
        return String(format: "%@@%ldx.%@", arguments: [String(describing: nameNoSuffix), scale, suffix!])
    }
    
    public static func jjs_imageWithFilePath(imageName: String, filePath: String?) -> UIImage
    {
        if String.jjs_isEmpty(str: filePath)
        {
            return UIImage(named: imageName)!
        }
        
        let scaleName = self.jjs_scaleName(imageName: imageName)
        let pathBundle = Bundle(path: filePath!)
        var image = UIImage()
        if #available(iOS 8.0, *)
        {
            image = UIImage(named: scaleName!, in: pathBundle, compatibleWith: nil)!
            if (image.images == nil)
            {
                image = UIImage(named: imageName, in: pathBundle, compatibleWith: nil)!
            }
        }
        return image
    }

    public static func jjs_imageScaleNamed(name: String) -> UIImage?
    {
        let img = UIImage(named: name)
        let array1: [String]? = name.components(separatedBy: "#")
        if let a = array1, a.count == 3
        {
            let tempStr = array1![1]
            let array2: [String]? = tempStr.components(separatedBy: "_")
            if let b = array2, b.count == 4
            {
                if #available(iOS 8.0, *)
                {
                    let edgeInsets = UIEdgeInsetsMake(CGFloat(Double(array2![0])!), CGFloat(Double(array2![1])!), CGFloat(Double(array2![2])!), CGFloat(Double(array2![3])!))
                    return (img?.resizableImage(withCapInsets: edgeInsets))!
                }
                else
                {
                    // Fallback on earlier versions
                }
            }
        }
        return nil
    }
    
    // 等比率缩放
    public func jjs_imageScale(scaleSize: CGFloat) -> UIImage
    {
        var rect = CGRect()
        rect.size = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        rect = rect.integral
        return self.jjs_reSizeImageSize(reSize: rect.size)
    }
    
    // 缩放图片文件大小
    public static func jjs_scaleImageToScale(image: UIImage, scaleSize: CGFloat) -> UIImage?
    {
        UIGraphicsBeginImageContext(CGSize(width: image.size.width * scaleSize, height: image.size.height * scaleSize))
        image.draw(in: CGRect(x: 0.0, y: 0.0, width: image.size.width * scaleSize, height: image.size.height * scaleSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    // 自定长自定长宽
    public func jjs_reSizeImageSize(reSize: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContext(CGSize(width: reSize.width, height: reSize.height))
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: reSize.width, height: reSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizeImage!
    }
    
    // 处理某个特定View 只要是继承UIView的object 都可以处理
    public func jjs_captureView(theView: UIView) -> UIImage
    {
        let rect = theView.frame
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        theView.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    // 将图片旋转到正确的方向
    public func jjs_fixOrientation() -> UIImage
    {
        let imageOrientation = self.imageOrientation
        if imageOrientation == .up
        {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch imageOrientation
        {
            case .down, .downMirrored:
                transform = transform.translatedBy(x: self.size.width, y: self.size.height)
                transform = transform.rotated(by: CGFloat(Double.pi))
            case .left, .leftMirrored:
                transform = transform.translatedBy(x: self.size.width, y: 0.0)
                transform = transform.rotated(by: CGFloat(Double.pi / 2))
            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0.0, y: self.size.height)
                transform = transform.rotated(by: CGFloat(-(Double.pi / 2)))
            case .up, .upMirrored:
                break
        }
        
        switch imageOrientation
        {
            case .upMirrored, .downMirrored:
                transform = transform.translatedBy(x: self.size.width, y: 0.0)
                transform = transform.scaledBy(x: -1, y: 1)
            case .leftMirrored, .rightMirrored:
                transform = transform.translatedBy(x: self.size.height, y: 0.0)
                transform = transform.scaledBy(x: -1, y: 1)
            case .up, .down, .left, .right:
                break
        }

        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent , bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!
        ctx.concatenate(transform)
        switch imageOrientation
        {
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(self.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: self.size.height, height: self.size.width))
            default:
                ctx.draw(self.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height))
        }
        
        let cgimg = ctx.makeImage()!
        let img = UIImage(cgImage: cgimg)
        return img
    }
    
    // 图片裁剪
    public func jjs_getSubImageInRect(rect: CGRect) -> UIImage
    {
        let subImageRef = self.cgImage!.cropping(to: rect)!
        let smallBounds = CGRect(x: 0, y: 0, width: subImageRef.width, height: subImageRef.height)
        UIGraphicsBeginImageContext(smallBounds.size)
        let context = UIGraphicsGetCurrentContext()!
        context.draw(subImageRef, in: smallBounds)
        let smallImage = UIImage(cgImage: subImageRef)
        UIGraphicsEndImageContext()
        return smallImage
    }
    
    /**
     * 获取经过模糊处理的图片
     * @param blur 模糊半径，取值范围0.05~2.0
     * @return 经过模糊处理后的图片，blur小于0.05时，返回原图，大于2.0时，返回blur=2.0的图片
     */
    public func jjs_blurLevel(blur: CGFloat) -> UIImage
    {
        var blurAmount = blur
        if blurAmount < 0.05
        {
            return self
        }
        if blurAmount > 2.0
        {
            blurAmount = 2.0
        }

        var boxSize = Int(blurAmount * 100)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img = self.cgImage
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        let inProvider =  img?.dataProvider
        let inBitmapData =  inProvider?.data
        
        inBuffer.width = vImagePixelCount((img?.width)!)
        inBuffer.height = vImagePixelCount((img?.height)!)
        inBuffer.rowBytes = (img?.bytesPerRow)!
        inBuffer.data = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
        
        let pixelBuffer = malloc((img?.bytesPerRow)! * (img?.height)!)
        
        outBuffer.width = vImagePixelCount((img?.width)!)
        outBuffer.height = vImagePixelCount((img?.height)!)
        outBuffer.rowBytes = (img?.bytesPerRow)!
        outBuffer.data = pixelBuffer
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if (kvImageNoError != error)
        {
            error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            if (kvImageNoError != error)
            {
                error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                                   &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
                                                   UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            }
        }
        
        let colorSpace =  CGColorSpaceCreateDeviceRGB()
        let ctx = CGContext(data: outBuffer.data,
                            width: Int(outBuffer.width),
                            height: Int(outBuffer.height),
                            bitsPerComponent: 8,
                            bytesPerRow: outBuffer.rowBytes,
                            space: colorSpace,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let imageRef = ctx?.makeImage()
        
        free(pixelBuffer)
        return UIImage(cgImage: imageRef!)
    }
    
    public static func jjs_imageWithColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public static func jjs_imageBezierPath(path: UIBezierPath, fillColor: UIColor, lineColor: UIColor) -> UIImage?
    {
        if !path.isEmpty
        {
            let rect = path.bounds
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(UIColor.clear.cgColor)
            context.fill(rect)
            
            fillColor.setStroke()
            path.fill()

            lineColor.setStroke()
            path.stroke()

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image!
        }
        return nil
    }
    
    /**
     *  显示为几个圆形的图片效果
     *
     *  @param size 大小尺寸
     *
     *  @return UIImage
     */
    public func jjs_circleImageSize(size: CGFloat) -> UIImage
    {
        return self.jjs_imageAsCircle(clipToCircle: true, diameter: size, borderColor: UIColor(hue: 0.0, saturation: 0.0, brightness: 0.8, alpha: 1.0), borderWidth: 1.0, shadowOffset: CGSize(width: 0.0, height: 0.0))
    }
    
    public func jjs_squareImageSize(size: CGFloat) -> UIImage
    {
        return self.jjs_imageAsCircle(clipToCircle: false, diameter: size, borderColor: UIColor(hue: 0.0, saturation: 0.0, brightness: 0.8, alpha: 1.0), borderWidth: 1.0, shadowOffset: CGSize(width: 0.0, height: 0.1))
    }
    
    public func jjs_imageAsCircle(clipToCircle: Bool, diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat, shadowOffset: CGSize) -> UIImage
    {
        let increase = diameter * 0.15
        let newSize = diameter + increase
        let newRect: CGRect = CGRect(x: 0.0, y: 0.0, width: newSize, height: newSize)
        let imageRect = CGRect(x: increase, y: increase, width: newRect.size.width - (increase * 2.0), height: newRect.size.height - (increase * 2.0))
        
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        if __CGSizeEqualToSize(shadowOffset, CGSize(width: 0.0, height: 0.0)) == false
        {
            context.setShadow(offset: shadowOffset, blur: 3.0, color: UIColor(white: 0.0, alpha: 0.45).cgColor)
        }
        let borderPath = clipToCircle ? CGPath(ellipseIn: imageRect, transform: nil) : CGPath(rect: imageRect, transform: nil)
        context.setStrokeColor(borderColor.cgColor)
        context.setLineWidth(borderWidth)
        context.addPath(borderPath)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        context.restoreGState()
    
        if clipToCircle == true
        {
            let imgPath = UIBezierPath(ovalIn: imageRect)
            imgPath.addClip()
        }
        self.draw(in: imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    /**
     *  Data
     */
    public func jjs_dataWithCompressionQuality(compressionQuality: CGFloat) -> Data?
    {
        let imageData = UIImagePNGRepresentation(self)
        if !(imageData?.isEmpty)!
        {
            return UIImageJPEGRepresentation(self, compressionQuality)
        }
        return nil
    }
    
    public func jjs_data() -> Data
    {
        return self.jjs_dataWithCompressionQuality(compressionQuality: 1.0)!
    }
    
    /**
     *  Save
     */
    public func jjs_saveToFile(filePath: String) -> Bool
    {
        let data = self.jjs_data()
        
        return ((try? data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])) != nil)
    }
}
