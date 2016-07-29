//
//  HHAlertView.m
//  HHKit
//
//  Created by liuwenjie on 16/7/24.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHAlertView.h"
#import "PrivateHeader.h"

@implementation HHAlertView{
    void (^_alertHandleBlock)(NSInteger);
    UIAlertView *_alertView;
    UIAlertController *_alertController;
    
    NSInteger _buttonIndex;
}
-(void)initWithTitle:(NSString *)title message:(NSString *)msg showTarget:(UIViewController *)controller handle:(void (^)(NSInteger))clickButtonAtIndex cancle:(NSString *)cancle others:(NSString *)others, ...{
    _alertHandleBlock=[clickButtonAtIndex copy];

    if ([self iosVersion] >= 8.0) {
        __block int i=0;
        _alertController=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        if (cancle) {
            i++;
            UIAlertAction *action=[UIAlertAction actionWithTitle:cancle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (clickButtonAtIndex) {
                    if (i==2) {
                        [self buttonClickIndex:0 complete:clickButtonAtIndex];
                    }else{
                        [self buttonClickIndex:i-1 complete:clickButtonAtIndex];
                    }
                }
            }];
            [_alertController addAction:action];
        }
        
        if (others) {
            i++;
            UIAlertAction *action=[UIAlertAction actionWithTitle:others style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (clickButtonAtIndex) {
                    if (i==2&&cancle) {
                        [self buttonClickIndex:1 complete:clickButtonAtIndex];
                    }else{
                        [self buttonClickIndex:0 complete:clickButtonAtIndex];
                    }
                }
            }];
            [_alertController addAction:action];
        }
        id eachObject;
        va_list args;
        va_start(args, others);
        int k=i;
        while ((eachObject=va_arg(args, id))) {
            i++;
            k++;
            UIAlertAction *action=[UIAlertAction actionWithTitle:eachObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (clickButtonAtIndex) {
                    if (cancle) {
                        [self buttonClickIndex:k-2 complete:clickButtonAtIndex];
                    }else{
                        [self buttonClickIndex:k-1 complete:clickButtonAtIndex];
                    }
                }
                
            }];
            [_alertController addAction:action];
            FMKLOG(@"%@",eachObject);
        }
        va_end(args);
        [controller presentViewController:_alertController animated:YES completion:nil];
    }else{
        _alertView=[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancle otherButtonTitles:others, nil];
        id eachObject;
        va_list args;
        va_start(args, others);
        if (others) {
            while ((eachObject=va_arg(args, id))) {
                FMKLOG(@"%@",eachObject);
                [_alertView addButtonWithTitle:eachObject];
            }
            va_end(args);
        }
        [_alertView show];
    }

}
- (void)addButtonTitle:(NSString *)title {
    if ([self iosVersion] >= 8.0) {
        _buttonIndex++;
        int i=_buttonIndex;
        UIAlertAction *action=[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self buttonClickIndex:i complete:_alertHandleBlock];
        }];
        [_alertController addAction:action];
    }else{
        [_alertView addButtonWithTitle:title];
    }
}
#pragma mark - private
- (void)buttonClickIndex:(NSInteger)index complete:(void (^)(NSInteger))clickButtonAtIndex{
    _buttonIndex=index;
    clickButtonAtIndex(index);
}
- (CGFloat)iosVersion;          ///< 操作系统版本
{
    static float versionValue = -1.0;
    if(versionValue < 0.f)
    {
        NSString *os_verson = [[UIDevice currentDevice] systemVersion];
        
        // 处理形如6.1.3的版本号，使其变成6.13，方便外部处理
        NSArray* versionNumbers = [os_verson componentsSeparatedByString:@"."];
        os_verson = @"";
        for (int i = 0; i < versionNumbers.count; i++)
        {
            os_verson = [os_verson stringByAppendingString:[versionNumbers objectAtIndex:i]];
            if (i == 0)
            {
                os_verson = [os_verson stringByAppendingString:@"."];
            }
        }
        
        versionValue = [os_verson floatValue];
    }
    
    return versionValue;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_alertHandleBlock) {
        [self buttonClickIndex:buttonIndex complete:_alertHandleBlock];
    }
}

@end
