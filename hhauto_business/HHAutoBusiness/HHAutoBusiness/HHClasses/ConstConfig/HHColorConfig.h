//
//  HHColorConfig.h
//  HHAutoBusiness
//
//  Created by liuwenjie on 16/7/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHColorConfig_h
#define HHColorConfig_h

//alpha通道RGB颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//alpha通道十六进制颜色
#define HEXCOLOR(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:(a)]
//主题色
#define HH_MAIN_THEME_COLOR       RGBACOLOR(45, 103, 203,1)
//主背景色
#define HH_MAIN_BG_COLOR          RGBACOLOR(249, 249, 249,1)
//通用线条颜色
#define HH_LINE_COLOR             RGBACOLOR(211, 212, 212,1)



/////////////////////////////////////////////////////////////////////////////////////////常用颜色
//////////////////////////////////
#define kColorBlue              [UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:1]
#define kColorLightBlue         [UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:0.5]
#define kColorBlueH             [UIColor colorWithRed:9/255.0 green:104/255.0 blue:184/255.0 alpha:1]
#define kColorBlueD             [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1]
#define kColorOrange            [UIColor colorWithRed:255/255.0 green:132/255.0 blue:0/255.0 alpha:1]
#define kColorGreen             [UIColor colorWithRed:76/255.0 green:217/255.0 blue:100/255.0 alpha:1]
#define kColorLine1             [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1]
#define kColorLine2             [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1]
#define kColorGray              [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1]
#define kColorGray1             [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define kColorGray2             [UIColor colorWithRed:141/255.0 green:142/255.0 blue:144/255.0 alpha:1]
#define kColorGray3             [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]
#define kColorGray4             [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]
#define kColorGray5             [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
#define kColorRed               [UIColor colorWithRed:255/255.0 green:74/255.0 blue:74/255.0 alpha:1]
#define kColorRedH              [UIColor colorWithRed:210/255.0 green:58/255.0 blue:58/255.0 alpha:1]
#define kColorWhite             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]

#endif /* HHColorConfig_h */
