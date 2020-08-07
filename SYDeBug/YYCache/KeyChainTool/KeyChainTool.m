//
//  KeyChainTool.m
//  消汇邦
//
//  Created by xiesiyu on 2018/7/24.
//  Copyright © 2018年 深圳消汇邦成都分公司. All rights reserved.
//

#import "KeyChainTool.h"
#import <Security/Security.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation KeyChainTool



+ (NSString*)UUID {
    
    
    NSString *service = [NSString stringWithFormat:@"%@com.xiaohuibang.xiaohuibang",[KeyChainTool bundleSeedID]];
    NSString *uuid = [KeyChainTool load:service];
    if (!uuid) {
        NSString *sysVersion = [UIDevice currentDevice].systemVersion;
        CGFloat version = [sysVersion floatValue];
        
        if (version >= 7.0) {
            uuid = [KeyChainTool _UUID_iOS7];
        }
        else if (version >= 2.0) {
            uuid = [KeyChainTool _UUID_iOS6];
        }
        
        [KeyChainTool save:service data:uuid];
    }
    
    return uuid;
}




//创建服务
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    
    NSMutableDictionary *keyChainQuery = [[NSMutableDictionary alloc] init];
    [keyChainQuery setObject:(__bridge_transfer id)kSecClassGenericPassword forKey:
     (__bridge_transfer id)kSecClass];
    [keyChainQuery setObject:service forKey:(__bridge_transfer id)kSecAttrService];
    [keyChainQuery setObject:service forKey:(__bridge_transfer id)kSecAttrAccount];
    [keyChainQuery setObject:(__bridge_transfer
                              id)kSecAttrAccessibleAfterFirstUnlock forKey:(__bridge_transfer
                                                                            id)kSecAttrAccessible];
    return keyChainQuery;
}

//添加
+ (void)save:(NSString *)server data:(id)data {
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:server];
    //    添加前首先查找是否存在要添加的密码
    OSStatus status = SecItemCopyMatching((__bridge_retained
                                           CFDictionaryRef)keychainQuery, nil);
    if (status == errSecSuccess) {//item已经存在，更新它
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]
                                    initWithDictionary:keychainQuery];
        [dic setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:
         (__bridge_transfer id)kSecValueData];
        SecItemUpdate((__bridge_retained CFDictionaryRef)keychainQuery, (__bridge
                                                                         CFDictionaryRef)dic);
    } else if (status == errSecItemNotFound) {//没有找到则添加
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]
                          forKey:(__bridge_transfer id)kSecValueData];
        SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    }
}

//查找
+ (id)load:(NSString *)server {
    
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:server];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer
                                                        id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:
     (__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge_retained
                                           CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData);
    if (status == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer
                                                              NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@",server,exception);
        } @finally {
            
        }
    }
    return ret;
}

//删除
+ (void)delete:(NSString *)server {
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:server];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}


+ (NSString *)bundleSeedID {
    
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                            (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}



/*
 * iOS 6.0
 * use wifi's mac address
 */
+ (NSString*)_UUID_iOS6
{
    return [KeyChainTool getMacAddress];
}

/*
 * iOS 7.0
 * Starting from iOS 7, the system always returns the value 02:00:00:00:00:00
 * when you ask for the MAC address on any device.
 * use identifierForVendor + keyChain
 * make sure UDID consistency atfer app delete and reinstall
 */
+ (NSString*)_UUID_iOS7
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}


#pragma mark -
#pragma mark Helper Method for Get Mac Address

// from http://stackoverflow.com/questions/677530/how-can-i-programmatically-get-the-mac-address-of-an-iphone
+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = nil;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        if (msgBuffer) {
            free(msgBuffer);
        }
        
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

@end
