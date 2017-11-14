//
//  PrefixHeader.h
//  project
//
//  Created by Super on 2017/9/8.
//  Copyright © 2017年 Super. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h
#import <AFNetworking/AFNetworking.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#ifdef DEBUG
#define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#define DLog(...)
#endif
#define TopHeight         (Version7?64:44)
#define BoldFont(x)       [UIFont boldSystemFontOfSize:x]
#define Font(x)           [UIFont systemFontOfSize:x]
#define Version7          ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define Version8          ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
#define Net   ({AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];manager.responseSerializer = [AFJSONResponseSerializer serializer];\
manager.requestSerializer=[AFHTTPRequestSerializer serializer];[manager.requestSerializer setValue:@"text/json"  forHTTPHeaderField:@"Accept"];\
[manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];\
manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain", @"application/xml",\
@"text/xml",@"text/html",@"text/javascript", @"application/x-plist",   @"image/tiff", @"image/jpeg", @"image/gif", @"image/png", @"image/ico",\
@"image/x-icon", @"image/bmp", @"image/x-bmp", @"image/x-xbitmap", @"image/x-win-bitmap", nil];(manager);})
#define HOMEPATH           NSHomeDirectory()//主页路径
#define documentLocalPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) objectAtIndex:0]//Documents路径
#define cachesPath         [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define tempPath           NSTemporaryDirectory()
#define WS(weakSelf)       __weak __typeof(self)weakSelf = self;
#define WEAK(obj,name)     __weak __typeof(obj)name = obj;
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HEXCOLOR(s)        [UIColor colorFromHex:s]
#define HEXACOLOR(s,a)     [UIColor colorFromHex:s alpha:a]
#define APPW               [UIScreen mainScreen].bounds.size.width
#define APPH               [UIScreen mainScreen].bounds.size.height
#define W(obj)             (!obj?0:(obj).frame.size.width)
#define H(obj)             (!obj?0:(obj).frame.size.height)
#define X(obj)             (!obj?0:(obj).frame.origin.x)
#define Y(obj)             (!obj?0:(obj).frame.origin.y)
#define XW(obj)            (X(obj)+W(obj))
#define YH(obj)            (Y(obj)+H(obj))
/*******************我的网络资源文件*****************/
#define FileResource(s)   [[NSBundle mainBundle]pathForResource:s ofType:nil]
#define alertErrorTxt     @"服务器异常,请稍后再试"
#define holdImage      [UIImage imageNamed:@"默认"]
#define LanguageCode [[HXLanguageManager shareInstance] currentLanguage]
#define LocalStr(key, comment) [[HXLanguageManager shareInstance] localizedStringForKey:key value:comment]
#endif /* PrefixHeader_h */
