//
//  UIImageView+RLTransfrom.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/3.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "UIImageView+RLTransfrom.h"

@implementation UIImageView (RLTransfrom)

- (void)transfromImageViewWith:(UIImageOrientation)Orientation Model:(MyEyesCellModel *)model{
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.coverBlurred] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
  
    
    UIImage *aImage = image;
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    CGFloat boundHeight;
    
    UIImageOrientation orient = aImage.imageOrientation;
    
    
    switch(Orientation)
    
        {
            
            case UIImageOrientationUp:
            
                transform = CGAffineTransformIdentity;
            
                break;
            
            case UIImageOrientationUpMirrored:
            
                transform = CGAffineTransformMakeTranslation(width, 0.0);
                
                transform = CGAffineTransformScale(transform, -1.0, 1.0); //沿y轴向左翻
            
                break;
            
            case UIImageOrientationDown:
                transform = CGAffineTransformMakeTranslation(width, height);
                
                transform = CGAffineTransformRotate(transform, M_PI);
                
                break;
            
            case UIImageOrientationDownMirrored:
                
                transform = CGAffineTransformMakeTranslation(0.0, height);
            
                transform = CGAffineTransformScale(transform, 1.0, -1.0);
                
                break;
            
            case UIImageOrientationLeft:
            
                boundHeight = bounds.size.height;
            
                bounds.size.height = bounds.size.width;
            
                bounds.size.width = boundHeight;
            
                transform = CGAffineTransformMakeTranslation(0.0, width);
            
                transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
                break;
            
            case UIImageOrientationLeftMirrored:
            
                boundHeight = bounds.size.height;
            
                bounds.size.height = bounds.size.width;
            
                bounds.size.width = boundHeight;
            
                transform = CGAffineTransformMakeTranslation(height, width);
            
                transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
                transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
                break;
            
            case UIImageOrientationRight: //EXIF = 8
            
                boundHeight = bounds.size.height;
            
                bounds.size.height = bounds.size.width;
            
                bounds.size.width = boundHeight;
            
                transform = CGAffineTransformMakeTranslation(height, 0.0);
                
                transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
                break;
            
            case UIImageOrientationRightMirrored:
            
                boundHeight = bounds.size.height;
            
                bounds.size.height = bounds.size.width;
            
                bounds.size.width = boundHeight;
                
                transform = CGAffineTransformMakeScale(-1.0, 1.0);
                
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
    
        self.image = imageCopy;
      }];
}

@end
