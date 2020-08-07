//
//  PrivacyPermissionManager.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/2.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 系统权限
 *  相册
<key>NSPhotoLibraryUsageDescription</key>
<string>App需要您的同意,才能访问相册</string>
 *  相机
<key>NSCameraUsageDescription</key>
<string>App需要您的同意,才能访问相机</string>
 *  麦克风
<key>NSMicrophoneUsageDescription</key>
<string>App需要您的同意,才能访问麦克风</string>
 *  位置
<key>NSLocationUsageDescription</key>
<string>App需要您的同意,才能访问位置</string>
 *  在使用期间访问位置
<key>NSLocationWhenInUseUsageDescription</key>
<string>App需要您的同意,才能在使用期间访问位置</string>
 *  始终访问位置
<key>NSLocationAlwaysUsageDescription</key>
<string>App需要您的同意,才能始终访问位置</string>
 *  日历
<key>NSCalendarsUsageDescription</key>
<string>App需要您的同意,才能访问日历</string>
 *  提醒事项
<key>NSRemindersUsageDescription</key>
<string>App需要您的同意,才能访问提醒事项</string>
 *  运动与健身
<key>NSMotionUsageDescription</key>
<string>App需要您的同意,才能访问运动与健身</string>
 *  健康更新
<key>NSHealthUpdateUsageDescription</key>
<string>App需要您的同意,才能访问健康更新 </string>
 *  健康分享
<key>NSHealthShareUsageDescription</key>
<string>App需要您的同意,才能访问健康分享</string>
 *  蓝牙
<key>NSBluetoothPeripheralUsageDescription</key>
<string>App需要您的同意,才能访问蓝牙</string>
 *  媒体资料库
<key>NSAppleMusicUsageDescription</key>
<string>App需要您的同意,才能访问媒体资料库</string>
 */


@interface PrivacyPermissionManager : NSObject

+ (instancetype)manager;

//定位权限
- (void)openLocationServiceWithBlock:(void(^)(BOOL open))returnBlock;


@end

NS_ASSUME_NONNULL_END
