//
//  WERouter.m
//  WERouter
//
//  Created by jsb-xiakj on 2017/2/28.
//  Copyright © 2017年 kjx. All rights reserved.
//

#import "WERouter.h"
@interface WERouter()

@property (nonatomic) NSMutableDictionary *routes;

@end

@implementation WERouter

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static WERouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[WERouter alloc] init];
    });
    return router;
}

+ (BOOL)canOpenURL:(NSString *)urlPattern
{
    return [[WERouter sharedInstance] canOpenURL:urlPattern];
}

+ (void)registerURLPattern:(NSString *)urlPattern
           toObjectHandler:(WERouterHandler)handler
{
    NSLog(@"\nregisterURL:\n%@",urlPattern);
    [[WERouter sharedInstance] addURLPattern:urlPattern
                            andObjectHandler:handler];
}

+ (void)openURL:(NSString *)urlPattern
      parameter:(id        )parameter
     completion:(void (^)(id result))completion
{
    [[WERouter sharedInstance] openURL:urlPattern
                             parameter:parameter
                            completion:completion];
}

+ (void)removeURLPattern:(NSString *)urlPattern
{
    [[WERouter sharedInstance] removeURLPattern:urlPattern];
}

- (void)addURLPattern:(NSString *)urlPattern
     andObjectHandler:(WERouterHandler)handler
{
    @synchronized (self.routes)
    {
        [self.routes setValue:[handler copy]
                        forKey:urlPattern];
    }
}

- (BOOL)canOpenURL:(NSString *)urlPattern
{
    
    __block WERouterHandler rHandler =nil;
    @synchronized (self.routes)
    {
        rHandler = [[self.routes objectForKey:urlPattern] copy];
    }
    return rHandler?YES:NO;
    
}

- (void)removeURLPattern:(NSString *)urlPattern
{
    @synchronized (self.routes)
    {
        [self.routes removeObjectForKey:urlPattern];
    }
}

- (void)openURL:(NSString *)urlPattern
      parameter:(id        )parameter
     completion:(void (^)(id result))completion
{
    NSLog(@"\nparameter:\n%@",parameter);
    __block WERouterHandler rHandler =nil;
    @synchronized (self.routes)
    {
       rHandler = [[self.routes objectForKey:urlPattern] copy];
    }
    if (rHandler) {
        id result=[rHandler(parameter) copy];
        if (completion) {
            completion(result);
            NSLog(@"\nresult:\n%@",result);
        }
    }else{
        NSLog(@"can't find handle!");
    }
}

- (NSMutableDictionary *)routes
{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

@end
