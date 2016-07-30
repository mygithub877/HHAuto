//
//  HHGloabConfig.h
//  HHAutoBusiness
//
//  Created by liuwenjie on 16/7/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHGloabConfig_h
#define HHGloabConfig_h

//log日志打印,包含该函数名,行数
#if DEBUG
#define HHLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define HHLog(id, ...)
#endif

//屏幕的高度
#define HH_SCREEN_H [UIScreen mainScreen].bounds.size.height
//屏幕的宽带
#define HH_SCREEN_W [UIScreen mainScreen].bounds.size.width

//3.5英寸屏幕
#define HH_SCREEN_3_5 ([UIScreen mainScreen].bounds.size.height==480.f)

//4.0英寸屏幕
#define HH_SCREEN_4_0 ([UIScreen mainScreen].bounds.size.height==568.f)

//4.7英寸屏幕
#define HH_SCREEN_4_7 ([UIScreen mainScreen].bounds.size.height==667.f)

//5.5英寸屏幕
#define HH_SCREEN_5_5 ([UIScreen mainScreen].bounds.size.height==736.f)

#endif /* HHGloabConfig_h */
