//
//  CAMetalPlainView.h
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//
//

#import <TargetConditionals.h>

#if TARGET_OS_OSX
    #import <AppKit/AppKit.h>
    typedef NSView PlatformView;
#else
    #import <UIKit/UIKit.h>
    typedef UIView PlatformView;
#endif

#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjCCAMetalPlainView : PlatformView

- (instancetype)initWithDevice:(id<MTLDevice>)device
                         queue:(id<MTLCommandQueue>)queue;

@property (nonatomic, strong) id<MTLDevice> device;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;

@end

NS_ASSUME_NONNULL_END
