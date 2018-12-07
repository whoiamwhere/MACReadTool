//
//  AppDelegate.m
//  WHReadTool
//
//  Created by 静 on 2018/9/27.
//  Copyright © 2018年 静. All rights reserved.
//

#import "AppDelegate.h"
#import "WHViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong) IBOutlet WHViewController *viewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.viewController  = [[WHViewController alloc]initWithNibName:@"WHViewController" bundle:nil];
    
    
//    self.window.contentView.frame = CGRectMake(0, 0, 500, 260);
    
    [self.window.contentView addSubview:self.viewController.view];
    
    
    self.viewController.view.frame = self.window.contentView.bounds;
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
