//
//  CAMetalPlainView.m
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//

#import "CAMetalPlainView.h"
#import <TargetConditionals.h>

@implementation CAMetalPlainView {
#if TARGET_OS_OSX
    CVDisplayLinkRef _displayLink;
#endif
}

#if TARGET_OS_OSX

- (CALayer *)makeBackingLayer {
    CAMetalLayer *metalLayer = [CAMetalLayer layer];
    return metalLayer;
}

#else

+ (Class)layerClass {
    // This makes the view use a CAMetalLayer as its backing layer
    return [CAMetalLayer class];
}

#endif

- (instancetype)initWithDevice:(id<MTLDevice>)device
                         queue:(id<MTLCommandQueue>)queue {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _device = device;
        _commandQueue = queue;

#if TARGET_OS_OSX
        self.wantsLayer = YES; // Make the view layer-backed
#endif

        CAMetalLayer *metalLayer = (CAMetalLayer *)self.layer;
        metalLayer.device = device;
        metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
        metalLayer.framebufferOnly = YES;

        [self setupDisplayLink];
    }
    return self;
}

#if TARGET_OS_OSX

- (void)setupDisplayLink {
    CVReturn result = CVDisplayLinkCreateWithActiveCGDisplays(&_displayLink);
    if (result == kCVReturnSuccess) {
        CVDisplayLinkSetOutputCallback(_displayLink, &MyDisplayLinkCallback, (__bridge void * _Nullable)(self));
        CVDisplayLinkStart(_displayLink);
    } else {
        NSLog(@"Failed to create display link with error: %d", result);
    }
}

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink,
                                      const CVTimeStamp *now,
                                      const CVTimeStamp *outputTime,
                                      CVOptionFlags flagsIn,
                                      CVOptionFlags *flagsOut,
                                      void *displayLinkContext)
{
    @autoreleasepool {
        CAMetalPlainView *view = (__bridge CAMetalPlainView *)displayLinkContext;
        [view render];
    }
    return kCVReturnSuccess;
}

- (void)dealloc {
    if (_displayLink) {
        CVDisplayLinkStop(_displayLink);
        CVDisplayLinkRelease(_displayLink);
        _displayLink = NULL;
    }
}

#else

- (void)setupDisplayLink {
    // Create a CADisplayLink to synchronize rendering with the display's refresh rate
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self
                                                             selector:@selector(render)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#endif

- (void)render {
    // Rendering code goes here
    CAMetalLayer *metalLayer = (CAMetalLayer *)self.layer;
    id<CAMetalDrawable> drawable = [metalLayer nextDrawable];
    if (!drawable) {
        return;
    }

    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    commandBuffer.label = @"MyCommandBuffer";

    // Create a render pass descriptor
    MTLRenderPassDescriptor *renderPassDescriptor = [MTLRenderPassDescriptor renderPassDescriptor];
    if (renderPassDescriptor != nil) {
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture;
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 0, 1); // Green color
        renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
        renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;

        id<MTLRenderCommandEncoder> renderEncoder =
            [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder endEncoding];

        [commandBuffer presentDrawable:drawable];
    }

    [commandBuffer commit];
}

#if TARGET_OS_OSX

- (void)updateLayer {
    [self render];
}

#else

- (void)layoutSubviews {
    [super layoutSubviews];
    [self render];
}

#endif

@end
