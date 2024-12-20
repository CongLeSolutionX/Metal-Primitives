//
//  MetalPlainViewController.m
//  Metal-Primitives
//
//  Created by Cong Le on 12/19/24.
//
//

#import "MetalPlainViewController.h"
#import "CAMetalPlainView.h"
#import <Metal/Metal.h>
#import <TargetConditionals.h>

@interface MetalPlainViewController ()

@property (nonatomic, strong) CAMetalPlainView *metalView;
@property (nonatomic, strong) id<MTLDevice> device;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;

@end

@implementation MetalPlainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the Metal device and command queue
    self.device = MTLCreateSystemDefaultDevice();
    NSAssert(self.device, @"Metal is not supported on this device");

    self.commandQueue = [self.device newCommandQueue];
    self.commandQueue.label = @"com.example.metalCommandQueue";

    // Initialize the Metal view
    self.metalView = [[CAMetalPlainView alloc] initWithDevice:self.device
                                                        queue:self.commandQueue];
    self.metalView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.metalView];

    // Set up constraints to match the metal view to the view controller's view
    [NSLayoutConstraint activateConstraints:@[
        [self.metalView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.metalView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.metalView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.metalView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
}

@end
