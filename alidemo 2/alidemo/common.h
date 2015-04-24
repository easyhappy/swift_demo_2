//
//  common.h
//  alidemo
//
//  Created by 王晨 on 15/3/10.
//  Copyright (c) 2015年 zhfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AS_USERDEFAULTS( __class , NAME) \
@property (nonatomic,strong) __class * NAME;


#define DEF_USERDEFAULTS( __class , NAME) \
@synthesize NAME = _##NAME;  \
- (void)set##NAME:(__class *)NAME  \
{  \
_##NAME = NAME; \
if (NAME) { \
[[NSUserDefaults standardUserDefaults] setObject:NAME forKey:@#NAME]; \
} \
else { \
[[NSUserDefaults standardUserDefaults] removeObjectForKey:@#NAME]; \
} \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} \
- (__class *)NAME \
{ \
if (_##NAME == nil){ \
_##NAME = [[NSUserDefaults standardUserDefaults] objectForKey:@#NAME]; \
} \
return _##NAME; \
}

#define ALERT(x) [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:x delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]
#define NIB(x) [UINib nibWithNibName:@#x bundle:nil]
#define URL(url) [NSURL URLWithString:url]

#define ALISCHEME @"ledialipay"
@interface common : NSObject

@end
