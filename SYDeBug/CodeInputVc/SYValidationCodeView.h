//
//  SYValidationCodeView.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/25.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYTextField;

NS_ASSUME_NONNULL_BEGIN

@protocol SYValidationCodeViewDelegate <NSObject>

- (void)validationCodeViewInputCodes:(NSString *)codes;

@end

@interface SYValidationCodeView : UIView

- (void)validationPropertySettingViewSpacing:(NSInteger)codeViewSpacing
                                   codeCount:(NSInteger)codeCount
                              inputCodeColor:(UIColor *)inputCodeColor
                               waitCodeColor:(UIColor *)waitCodeColor
                                    delegate:(id <SYValidationCodeViewDelegate>)delegate;

@end


@protocol SYValidationCodeViewCellDelegate <NSObject>

///填充的验证码
- (void)validationCodeViewCellInputFillCode:(NSString *)code;
///输入验证码
- (void)validationCodeViewCellInputCode:(NSString *)code indexTag:(NSInteger)indexTag;
///删除验证码
- (void)validationCodeViewCellDeleteCode:(NSString *)code indexTag:(NSInteger)indexTag;;

@end

@interface SYValidationCodeViewCell : UICollectionViewCell <UITextFieldDelegate>

@property (nonatomic, strong) SYTextField *syTextField;
@property (nonatomic, assign)id <SYValidationCodeViewCellDelegate>delegate;

@end


@interface SYTextField : UITextField



@end

NS_ASSUME_NONNULL_END
