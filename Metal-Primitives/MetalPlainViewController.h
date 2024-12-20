//
//  MetalPlainViewController.h
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

#import <TargetConditionals.h>

#if TARGET_OS_OSX
    #import <AppKit/AppKit.h>
#else
    #import <UIKit/UIKit.h>
#endif

#if TARGET_OS_OSX
@interface MetalPlainViewController : NSViewController
#else
@interface MetalPlainViewController : UIViewController
#endif

@end
