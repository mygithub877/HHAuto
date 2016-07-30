//
//  UIImage+Util.m
//  BSports
//
//  Created by 柳文杰 on 15/1/31.
//  Copyright (c) 2015年 ist. All rights reserved.
//

#import "UIImage+Util.h"
@import Accelerate;

#include <float.h>
@implementation UIImage (Util)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //UIGraphicsBeginImageContext(rect.size);
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)imageWithTintColor:(UIColor *)color{

    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;

}
-(UIImage *)stretchableImage{
    return [self stretchableImageWithLeftCapWidth:self.size.width*0.5 topCapHeight:self.size.height*0.5];
}
-(UIImage *)cutImageForView{
    CGRect imageRect;
    if (self.size.height>self.size.width) {
        imageRect=CGRectMake(0, self.size.height/2-self.size.width/2, self.size.width, self.size.width);
    }else if (self.size.height==self.size.width){
        imageRect=CGRectMake(0, 0, self.size.width, self.size.height);
    }else{
        imageRect=CGRectMake(self.size.width/2-self.size.height/2,0, self.size.height, self.size.height);
    }
    
    CGImageRef imageRef= CGImageCreateWithImageInRect(self.CGImage, imageRect);
//    BOOL or=(self.imageOrientation==UIImageOrientationUp);
//    UIImageOrientation orientation=or?UIImageOrientationUp:UIImageOrientationRight;
    UIImage *image=[UIImage imageWithCGImage:imageRef scale:1.0f orientation:0];
    
    
    CGImageRelease(imageRef);
    return  image;
}
-(UIImage *)cutImageWithRect:(CGRect)rect{
    CGImageRef imageRef= CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image=[UIImage imageWithCGImage:imageRef scale:1.0f orientation:0];
    CGImageRelease(imageRef);
    return  image;

}
-(UIImage *)transforImageOri:(UIImageOrientation)orien{
    CGImageRef imageRef= CGImageCreateWithImageInRect(self.CGImage, CGRectMake(0, 0, self.size.width, self.size.height));

    UIImage *img=[UIImage imageWithCGImage:imageRef scale:1.0f orientation:orien];
    CGImageRelease(imageRef);
    return img;
}
-(UIImage *)rotateImage{
        int kMaxResolution = 960; // Or whatever
        CGImageRef imgRef = self.CGImage;
        
        CGFloat width = CGImageGetWidth(imgRef);
        CGFloat height = CGImageGetHeight(imgRef);
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        CGRect bounds = CGRectMake(0, 0, width, height);
        if (width > kMaxResolution || height > kMaxResolution) {
            CGFloat ratio = width/height;
            if (ratio > 1) {
                bounds.size.width = kMaxResolution;
                bounds.size.height = bounds.size.width / ratio;
            }
            else {
                bounds.size.height = kMaxResolution;
                bounds.size.width = bounds.size.height * ratio;
            }
        }
        
        CGFloat scaleRatio = bounds.size.width / width;
        CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
        CGFloat boundHeight;
        UIImageOrientation orient = self.imageOrientation;
        switch(orient) {
                
            case UIImageOrientationUp: //EXIF = 1
                transform = CGAffineTransformIdentity;
                break;
                
            case UIImageOrientationUpMirrored: //EXIF = 2
                transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
                transform = CGAffineTransformScale(transform, -1.0, 1.0);
                break;
                
            case UIImageOrientationDown: //EXIF = 3
                transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationDownMirrored: //EXIF = 4
                transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
                transform = CGAffineTransformScale(transform, 1.0, -1.0);
                break;
                
            case UIImageOrientationLeftMirrored: //EXIF = 5
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
                transform = CGAffineTransformScale(transform, -1.0, 1.0);
                transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
                break;
                
            case UIImageOrientationLeft: //EXIF = 6
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
                transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
                break;
                
            case UIImageOrientationRightMirrored: //EXIF = 7
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = CGAffineTransformMakeScale(-1.0, 1.0);
                transform = CGAffineTransformRotate(transform, M_PI / 2.0);
                break;
                
            case UIImageOrientationRight: //EXIF = 8
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
                transform = CGAffineTransformRotate(transform, M_PI / 2.0);
                break;
                
            default:
                [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
                
        }
        
        UIGraphicsBeginImageContext(bounds.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
            CGContextScaleCTM(context, -scaleRatio, scaleRatio);
            CGContextTranslateCTM(context, -height, 0);
        }
        else {
            CGContextScaleCTM(context, scaleRatio, -scaleRatio);
            CGContextTranslateCTM(context, 0, -height);
        }
        
        CGContextConcatCTM(context, transform);
        
        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
        UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imageCopy;
    
}


#pragma marl -
- (UIImage *)applyLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.5;
    UIColor *effectColor = tintColor;
    unsigned long componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
