//
//  WERouter.h
//  WERouter
//
//  Created by jsb-xiakj on 2017/2/28.
//  Copyright © 2017年 kjx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^WERouterHandler)(id parameter);

@interface WERouter : NSObject

+ (instancetype)sharedInstance;

+ (void)registerURLPattern:(NSString *)urlPattern
           toObjectHandler:(WERouterHandler)handler;

+ (void)openURL:(NSString *)urlPattern
      parameter:(id        )parameter
     completion:(void (^)(id result))completion;

+ (void)removeURLPattern:(NSString *)urlPattern;

+ (BOOL)canOpenURL:(NSString *)urlPattern;

@end
