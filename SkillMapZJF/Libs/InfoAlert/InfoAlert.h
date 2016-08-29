//
//  InfoAlert.h
//  RailTraffic
//
//  Created by Lion User on 21/03/2013.
//
//

#import <UIKit/UIKit.h>

#define kSGInfoAlert_fontSize   17
#define kSGInfoAlert_width  200
#define kMax_ConstrainedSize    CGSizeMake(200,100)

@interface InfoAlert : UIView
{
    CGColorRef bgcolor_;
    NSString *info_;
    CGSize fontSize_;
}

// info为提示信息，frame为提示框大小，view是为消息框的superView（推荐Tabbarcontroller.view)
// vertical 为垂直方向上出现的位置
+ (void)showInfo:(NSString*)info
         bgColor:(CGColorRef)color
          inView:(UIView*)view
        vertical:(float)height;

+ (void)showInfo:(NSString*)info
         bgColor:(CGColorRef)color
          inView:(UIView*)view
               x:(float)x
               y:(float)y;



@end
