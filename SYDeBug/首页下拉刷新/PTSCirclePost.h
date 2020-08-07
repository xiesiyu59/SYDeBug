//
//  PTSCirclePost.h
//  PetStore
//
//  Created by Sarkizz on 2020/1/22.
//  Copyright © 2020 petstore. All rights reserved.
//

#import "PTSBaseModel.h"
#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,AlivcPlayerControllerState) {
    AlivcPlayerControllerStateActive =  0,                  //正常状态
    AlivcPlayerControllerStateShowMask = 1 << 0,            //显示maskView
    AlivcPlayerControllerStateEnterbackground = 1 << 1      //进入后台
};

@interface PTSCirclePost : PTSBaseModel



@property (nonatomic , assign) BOOL                is_unlike;
@property (nonatomic , copy) NSString              * relation;
@property (nonatomic , copy) NSString              * like_num;
@property (nonatomic , copy) NSString              * share_num;
@property (nonatomic , copy) NSString              * is_collect;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * updated_at;
@property (nonatomic , copy) NSString              * lng;
@property (nonatomic , copy) NSString              * uuid;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * video;
@property (nonatomic , copy) NSString              * report_num;
@property (nonatomic , copy) NSString              * adcode;
@property (nonatomic , copy) NSString              * flag;
@property (nonatomic , copy) NSString              * type; //1是图片2是视频
@property (nonatomic , copy) NSString              * comment_num;
@property (nonatomic , strong) NSArray <NSString *>              * imgs;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * collect_num;
@property (nonatomic , copy) NSString              * lat;
@property (nonatomic , copy) NSString              * created_at;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , copy) NSString              * citycode;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * is_privacy;
@property (nonatomic , copy) NSArray              * topics;
@property (nonatomic , copy) PTSUserInfo              * user;
@property (nonatomic , copy) NSString              * is_like;

//圈子列表用
@property (nonatomic , copy) NSString              * user_name;
@property (nonatomic , copy) NSString              * user_sex;
@property (nonatomic , copy) NSString              * user_avatar;
//首页用
@property (nonatomic , copy) NSString              * distance;

@property (nonatomic , assign) BOOL              hasLoad;

@property (nonatomic , assign) NSInteger rank;
@property (nonatomic , assign) NSInteger hot_num;
//喜欢列表用
@property (nonatomic , copy) NSString              * posts_id;

@property(nonatomic, copy) NSString *attention_by_posts;
@property(nonatomic, copy) NSString *is_black_list;

//圈子首页用
@property(nonatomic, copy) NSString *is_top;
//同城瀑布流用，自定义属性
@property (nonatomic , strong)  NSString               * imgsSize;
@property (nonatomic , strong)  UIImage               * coverImage;

@end

NS_ASSUME_NONNULL_END

@interface PTSCirclePostDraft : NSObject

@property (nonatomic , copy) NSArray              * _Nullable images;
@property (nonatomic , copy) NSArray              * _Nullable selectedTopics;
@property (nonatomic , copy) NSArray              * _Nullable selectedCircles;
@property (nonatomic , assign) NSInteger            isPravicy;
@property (nonatomic , assign) NSInteger            type;
@property (nonatomic , copy) NSString              * _Nullable desc;
@property (nonatomic , copy) NSString              * _Nullable video;
@property (nonatomic , copy) NSString              * _Nullable address;
@property (nonatomic , copy) NSString              * _Nullable address_name;
@property (nonatomic , copy) NSString              * _Nullable userId;
@property (nonatomic , assign) CGFloat            lng;
@property (nonatomic , assign) CGFloat            lat;
@property (nonatomic , assign) CGFloat            videoTime;




@end


@interface  NSObject (bg_delete)

- (void)deleteSelf;

@end
