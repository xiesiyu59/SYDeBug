//
//  SYPhotoModel.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYPhotoModel.h"

@implementation SYPhotoModel

- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super init]) {
        
        self.thumbImage = image;
        self.originImage = image;
    }
    return self;
}


- (instancetype)initWithImageUrl:(NSString *)imageUrl{
    if (self = [super init]) {
        
        self.thumbImageUrl = [NSURL URLWithString:imageUrl];
        self.originImageUrl = [NSURL URLWithString:imageUrl];
        
    }
    return self;
}


- (void)setThumbImage:(UIImage *)thumbImage{
    _thumbImage = thumbImage;
    self.modelUpdate = YES;
}

- (void)setOriginImage:(UIImage *)originImage{
    _originImage = originImage;
    self.modelUpdate = YES;
}



- (BOOL)hasQrcode{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:(self.originImage.CGImage ?: (self.thumbImage.CGImage ?: nil))]];
    if (features.count > 0) {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        self.qrCode = feature.messageString;
    }
    return features.count;
}

@end
