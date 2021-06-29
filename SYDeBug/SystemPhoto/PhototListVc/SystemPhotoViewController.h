//
//  SystemPhotoViewController.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/11/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PhotoType){
    PhotoTypeAll,
    PhotoTypeImage,
    PhotoTypeVideo,
};

@interface SystemPhotoViewController : BaseViewController

@property (nonatomic, assign)PhotoType type;

@end

NS_ASSUME_NONNULL_END
