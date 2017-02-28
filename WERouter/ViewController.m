//
//  ViewController.m
//  WERouter
//
//  Created by jsb-xiakj on 2017/2/28.
//  Copyright © 2017年 kjx. All rights reserved.
//

#import "ViewController.h"
#import "WERouter.h"
@interface ViewController ()
@property(nonatomic)NSMutableArray *muArray;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    [WERouter openURL:@"url://play您好‘@！#¥……**（）!@&#*($)_+_)((((*，。。，，，,..lllll"
            parameter:@"iplay = 1"
           completion:^(id result) {
               NSLog(@"result:%@",result);
    }];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i=0; i<100000; i++) {
        NSString *url=[NSString stringWithFormat:@"url://play%d",i];
        dispatch_async(queue, ^{
            
            [WERouter registerURLPattern:url
                         toObjectHandler:^id (id parameter) {
                             
                             
                             return @"yes";
                         }];
            NSLog(@"%d",i);
        });
        
        dispatch_async(queue, ^{
            
            [WERouter openURL:url
                    parameter:@"iplay = 1"
                   completion:^(id result) {
                        
                   }];
            
        });
        
        dispatch_async(queue, ^{
            
            if ([WERouter canOpenURL:url]) {
                NSLog(@"YES!");
            }else{
                NSLog(@"NO!");
            }

        });
        
        
        dispatch_async(queue, ^{
            
            [WERouter removeURLPattern:url];
            
        });
        
        
    }

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
