//
//  UILabel+Swizzling.m
//  Method Swizzling
//
//  Created by 锦锋 on 17/2/17.
//  Copyright © 2017年 锦锋. All rights reserved.
//

#import "UILabel+Swizzling.h"

@implementation UILabel (Swizzling)
//消息转发虽然功能强大，但需要我们了解并且能更改对应类的源代码，因为我们需要实现自己的转发逻辑。当我们无法触碰到某个类的源代码，却想更改这个类某个方法的实现时，该怎么办呢？可能继承类并重写方法是一种想法，但是有时无法达到目的。这里介绍的是 Method Swizzling ，它通过重新映射方法对应的实现来达到“偷天换日”的目的。跟消息转发相比，Method Swizzling 的做法更为隐蔽，甚至有些冒险，也增大了debug的难度。
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(willMoveToSuperview:);
        SEL swizzlSel = @selector(swizzl_willMoveToSuperview:);
        
        Method sysMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzlMethod = class_getInstanceMethod([self class], swizzlSel);
        //将系统方法 的IMP转换为自定义的方法的IMP，如果自定义的方法的IMP没有实现，那么就会返回YES。
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzlMethod), method_getTypeEncoding(swizzlMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzlSel, method_getImplementation(sysMethod), method_getTypeEncoding(sysMethod));
        }else{
            method_exchangeImplementations(sysMethod, swizzlMethod);
        }
    });
}
- (void)swizzl_willMoveToSuperview:(UIView *)newSuperView{
    //这一步也很关键，是必须要调用的，因为这一步回去执行系统的方法对应的iMP，因为切换了。多以我们可以通过这方式来扩展系统方法。
    [self swizzl_willMoveToSuperview:newSuperView];
      if ([self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
          self.backgroundColor = [UIColor redColor];
      }
    self.font = [UIFont fontWithName:SCRIPT_NAME size:self.font.pointSize];
    
}
@end
