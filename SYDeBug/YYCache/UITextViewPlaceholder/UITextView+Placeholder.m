//
//  UITextView+Placeholder.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/14.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "UITextView+Placeholder.h"

static const char *syPlaceholderTextView = "syPlaceholderTextView";
static const void *SYTextViewInputLimitMaxLength = &SYTextViewInputLimitMaxLength;


@implementation UITextView (Placeholder)


- (UITextView *)syPlaceholderTextView{
    return objc_getAssociatedObject(self, syPlaceholderTextView);
}

- (void)setSyPlaceholderTextView:(UITextView *)placeholderTextView{
    
    objc_setAssociatedObject(self, syPlaceholderTextView, placeholderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)syAddPlaceholder:(NSString *)placeholder{
    
    if (![self syPlaceholderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeholder;
        [self addSubview:textView];
        [self setSyPlaceholderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    self.syPlaceholderTextView.text = placeholder;
}


# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.syPlaceholderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.syPlaceholderTextView.hidden = NO;
    }
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// 字数限制

- (NSInteger)syMaxLength{
    
    return [objc_getAssociatedObject(self, SYTextViewInputLimitMaxLength) integerValue];
}

- (void)setSyMaxLength:(NSInteger)maxLength{
    
    objc_setAssociatedObject(self, SYTextViewInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(syTextViewTextDidChange:)
                                                name:@"UITextViewTextDidChangeNotification" object:self];
}

- (void)syTextViewTextDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.syMaxLength > 0 && toBeString.length > self.syMaxLength)){
        
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.syMaxLength];
        if (rangeIndex.length == 1){
            
            self.text = [toBeString substringToIndex:self.syMaxLength];
        }else{
            
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.syMaxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.syMaxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}



- (instancetype)setupAttributedText:(NSString *)text{
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
    return self;
}



@end
