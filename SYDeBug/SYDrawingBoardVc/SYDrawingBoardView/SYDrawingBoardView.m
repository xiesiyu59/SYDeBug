//
//  SYDrawingBoardView.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYDrawingBoardView.h"
#import "SYDrawingBoardToolView.h"


@interface SYDrawingBoardView ()

@property (nonatomic, strong) NSMutableArray *lines;           //用来管理画板上所有的路径
@property (nonatomic, strong) NSMutableArray * canceledLines;  //撤销的线条数组
@property (nonatomic, strong) SYDrawingUIBezierPath * path;
@property (nonatomic, strong) CAShapeLayer * slayer;


@end


@implementation SYDrawingBoardView

-(NSArray *)lines{
    if(!_lines){
        _lines=[NSMutableArray array];
    }
    return _lines;
}

- (NSMutableArray *)canceledLines{
    if (!_canceledLines) {
        _canceledLines = [NSMutableArray array];
    }
    return _canceledLines;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _lineColor = [UIColor blackColor];
        _lineWidth = 1.0f;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = IMG(@"1");
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    
    return self;
}


#pragma mark - <功能>
- (void)clean{
    
    if (!self.lines.count) return ;
    [self.lines makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [[self mutableArrayValueForKey:@"lines"] removeAllObjects];
    [[self mutableArrayValueForKey:@"canceledLines"] removeAllObjects];
}

- (void)undo{
    
    //当前屏幕已经清空，就不能撤销了
    if (!self.lines.count) return;
    [[self mutableArrayValueForKey:@"canceledLines"] addObject:self.lines.lastObject];
    [self.lines.lastObject removeFromSuperlayer];
    [[self mutableArrayValueForKey:@"lines"] removeLastObject];
}

- (void)redo {
    //当没有做过撤销操作，就不能恢复了
    if (!self.canceledLines.count) return;
    [[self mutableArrayValueForKey:@"lines"] addObject:self.canceledLines.lastObject];
    [[self mutableArrayValueForKey:@"canceledLines"] removeLastObject];
    [self drawLine];
    
}
- (void)eraser{
    
    _lineColor = self.backgroundColor;
}

#pragma mark - <画笔轨迹>
// 根据touches集合获取对应的触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches {
    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint startP = [self pointWithTouches:touches];
    
    if ([event allTouches].count == 1) {
        
        SYDrawingUIBezierPath *path = [SYDrawingUIBezierPath paintPathWithLineWidth:_lineWidth
                                                     startPoint:startP];
        _path = path;
        
        CAShapeLayer * slayer = [CAShapeLayer layer];
        slayer.path = path.CGPath;
        slayer.backgroundColor = [UIColor clearColor].CGColor;
        slayer.fillColor = [UIColor clearColor].CGColor;
        slayer.lineCap = kCALineCapRound;
        slayer.lineJoin = kCALineJoinRound;
        slayer.strokeColor = _lineColor.CGColor;
        slayer.lineWidth = path.lineWidth;
        [self.layer addSublayer:slayer];
        _slayer = slayer;
        [[self mutableArrayValueForKey:@"canceledLines"] removeAllObjects];
        [[self mutableArrayValueForKey:@"lines"] addObject:_slayer];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获取移动点
    CGPoint moveP = [self pointWithTouches:touches];
    
    if ([event allTouches].count > 1){
        
        [self.superview touchesMoved:touches withEvent:event];
        
    }else if ([event allTouches].count == 1) {
        
        [_path addLineToPoint:moveP];
        
        _slayer.path = _path.CGPath;
        
    }
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([event allTouches].count > 1){
        [self.superview touchesMoved:touches withEvent:event];
    }
}

/**
 *  画线
 */
- (void)drawLine{

    [self.layer addSublayer:self.lines.lastObject];
}


- (void)save{
    
    //保存视图到相册
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}


//保存图片的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
//        [YJProgressHUD showMessage:@"保存成功"];
    }else{
//        [YJProgressHUD showMessage:@"保存失败"];
    }
}

@end


@implementation SYDrawingUIBezierPath


+ (instancetype)paintPathWithLineWidth:(CGFloat)width
                            startPoint:(CGPoint)startP {
    
    SYDrawingUIBezierPath * path = [[self alloc] init];
    path.lineWidth = width;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    [path moveToPoint:startP];
    return path;
}


@end

