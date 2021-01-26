//
//  SYValidationCodeView.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/25.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYValidationCodeView.h"

#define CODETEXTFIELDTAG 1000
#define TEXTFOUNTSIZE 40

static NSString *collectionCellIdentifier = @"collectionCell";

@interface SYValidationCodeView () <UICollectionViewDelegate, UICollectionViewDataSource,SYValidationCodeViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *codeArray;
@property (nonatomic, assign) NSInteger codeViewSpacing;     //视图左右间距
@property (nonatomic, assign) NSInteger codeCount;           //需要验证码的个数
@property (nonatomic, strong) UIColor   *inputCodeColor;     //已经输入Code颜色
@property (nonatomic, strong) UIColor   *waitCodeColor;      //等待输入Code颜色
@property (nonatomic, assign)id <SYValidationCodeViewDelegate>delegate;


@end

@implementation SYValidationCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
}

- (NSMutableArray *)codeArray{
    if (!_codeArray) {
        _codeArray = [NSMutableArray array];
    }
    return _codeArray;
}

- (void)validationPropertySettingViewSpacing:(NSInteger)codeViewSpacing
                                   codeCount:(NSInteger)codeCount
                              inputCodeColor:(UIColor *)inputCodeColor
                               waitCodeColor:(UIColor *)waitCodeColor
                                    delegate:(id<SYValidationCodeViewDelegate>)delegate{
    
    self.codeViewSpacing = codeViewSpacing;
    self.codeCount = codeCount;
    self.inputCodeColor = inputCodeColor;
    self.waitCodeColor = waitCodeColor;
    self.delegate = delegate;
    
    for (NSInteger i = 0; i < codeCount; i++) {
        [self.codeArray addObject:@""];
    }
    [self.collectionView reloadData];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SYValidationCodeViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.codeCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SYValidationCodeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.syTextField.tag = CODETEXTFIELDTAG+indexPath.row;
    cell.syTextField.text = self.codeArray[indexPath.row];
    if (![self.codeArray[indexPath.row] isEqualToString:@""]) {
        
        cell.syTextField.tintColor = self.inputCodeColor;
        cell.syTextField.textColor = self.inputCodeColor;
        cell.syTextField.layer.borderColor = self.inputCodeColor.CGColor;
    }else{
        
        cell.syTextField.tintColor = self.waitCodeColor;
        cell.syTextField.layer.borderColor = self.waitCodeColor.CGColor;
    }
    
    return cell;
}

///输入验证码
- (void)validationCodeViewCellInputCode:(NSString *)code indexTag:(NSInteger)indexTag{
    
    [self.codeArray replaceObjectAtIndex:indexTag withObject:code];
    
    ///完成输入显示颜色
    SYValidationCodeViewCell *changecell = (SYValidationCodeViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexTag inSection:0]];
    changecell.syTextField.layer.borderColor = self.inputCodeColor.CGColor;
    changecell.syTextField.textColor = self.inputCodeColor;
    changecell.syTextField.tintColor = self.inputCodeColor;
    
    ///正在输入显示颜色
    SYValidationCodeViewCell *inputCell = (SYValidationCodeViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexTag+1 inSection:0]];
    [inputCell.syTextField becomeFirstResponder];
    
    
    if (indexTag == self.codeCount-1) {
        [self endEditing:YES];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(validationCodeViewInputCodes:)]) {
        [self.delegate validationCodeViewInputCodes:[self.codeArray componentsJoinedByString:@""]];
    }
    
//    NSLog(@"%@--code:%@--tag:%ld",self.codeArray,code,indexTag);
}

///填充验证码
- (void)validationCodeViewCellInputFillCode:(NSString *)code{
    
    NSString *tempString = code;
    if (code.length > self.codeCount) {
        tempString = [code substringToIndex:self.codeCount];
    }
    for (NSInteger i = 0; i < tempString.length; i ++) {
        
        [self.codeArray replaceObjectAtIndex:i withObject:[code substringWithRange:NSMakeRange(i, 1)]];
        ///完成输入显示颜色
        SYValidationCodeViewCell *changecell = (SYValidationCodeViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        changecell.syTextField.layer.borderColor = self.inputCodeColor.CGColor;
        changecell.syTextField.textColor = self.inputCodeColor;
        if (i == tempString.length - 1) {
            [self endEditing:YES];
            [self.collectionView reloadData];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(validationCodeViewInputCodes:)]) {
        [self.delegate validationCodeViewInputCodes:[self.codeArray componentsJoinedByString:@""]];
    }
//    NSLog(@"%@--填充:%@",self.codeArray,code);
    
}

///删除验证码
- (void)validationCodeViewCellDeleteCode:(NSString *)code indexTag:(NSInteger)indexTag{

    [self.codeArray replaceObjectAtIndex:indexTag withObject:@""];
    
    if (![code isEqualToString:@""] && indexTag){
        SYValidationCodeViewCell *cell = (SYValidationCodeViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexTag inSection:0]];
        [self.codeArray replaceObjectAtIndex:indexTag withObject:@""];
        cell.syTextField.text = @"";
        cell.syTextField.layer.borderColor = self.waitCodeColor.CGColor;
        cell.syTextField.tintColor = self.waitCodeColor;
    }
    
    if ([code isEqualToString:@""] && indexTag) {
        SYValidationCodeViewCell *cell = (SYValidationCodeViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexTag-1 inSection:0]];
        [self.codeArray replaceObjectAtIndex:indexTag-1 withObject:@""];
        cell.syTextField.text = @"";
        cell.syTextField.layer.borderColor = self.waitCodeColor.CGColor;
        cell.syTextField.tintColor = self.waitCodeColor;
        [cell.syTextField becomeFirstResponder];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(validationCodeViewInputCodes:)]) {
        [self.delegate validationCodeViewInputCodes:[self.codeArray componentsJoinedByString:@""]];
    }
//    NSLog(@"%@--code:%@--tag:%ld",self.codeArray,code,indexTag);
}


#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = floor((kScreenWidth-self.codeViewSpacing)/self.codeCount);
    return CGSizeMake(width, width);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, self.codeViewSpacing/2, 0, self.codeViewSpacing/2);
}
//横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}
//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end



@implementation SYValidationCodeViewCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.syTextField = [[SYTextField alloc] init];
    
    self.syTextField.backgroundColor = [UIColor whiteColor];
    self.syTextField.font = [UIFont systemFontOfSize:TEXTFOUNTSIZE];
    self.syTextField.layer.borderWidth = 1.0f;
    self.syTextField.layer.cornerRadius = 4;
    self.syTextField.delegate = self;
    [self.syTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    self.syTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.syTextField.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.syTextField];
    [self.syTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
}

- (void)textFieldChange:(UITextField *)textField{
    
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    if (!position) { // 没有高亮选择的字
        //过滤非汉字字符
        textField.text = [self filterCharactor:textField.text withRegex:@"[^[1-9]\\d*|0$]"];
        
        if (textField.text.length == 1) {
            textField.text = [textField.text substringToIndex:1];
            if (self.delegate && [self.delegate respondsToSelector:@selector(validationCodeViewCellInputCode:indexTag:)]) {
                [self.delegate validationCodeViewCellInputCode:textField.text indexTag:textField.tag-CODETEXTFIELDTAG];
            }
            
        }else if(textField.text.length >= 2){
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(validationCodeViewCellInputFillCode:)]) {
                [self.delegate validationCodeViewCellInputFillCode:textField.text];
            }
        }

    }else { //有高亮文字
        //do nothing
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // string.length为0，表明没有输入字符，应该是正在删除，应该返回YES。
    if (string.length == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(validationCodeViewCellDeleteCode:indexTag:)]) {
            [self.delegate validationCodeViewCellDeleteCode:textField.text indexTag:textField.tag-CODETEXTFIELDTAG];
        }
        return YES;
    }
    if (textField.text.length == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self endEditing:YES];
    return YES;
}

//根据正则，过滤字符只允许输入数字
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}


@end


@implementation SYTextField

/// 重写 UITextFiled 子类, 解决长按复制粘贴的问题
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}


@end
