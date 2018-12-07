//
//  WHViewController.h
//  WHReadTool
//
//  Created by 静 on 2018/9/27.
//  Copyright © 2018年 静. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WHViewController : NSViewController
@property (nonatomic,strong)IBOutlet NSButton *readBtn;
@property (nonatomic,strong)IBOutlet NSTextField *textFidel;
- (IBAction)readBtnClick:(id)sender;
- (IBAction)colorBtnClick:(id)sender;

@property (nonatomic,strong)IBOutlet NSButton *colorBtn;

@property (nonatomic,strong)IBOutlet NSButton *chooseBtn;
- (IBAction)chooseFileBtnClick:(id)sender;

@property (nonatomic,strong)IBOutlet NSButton *jumpBtn;
- (IBAction)jumpBtnClick:(id)sender;

@property (nonatomic,strong)IBOutlet NSTextField *indexTextFeild;

@property (nonatomic,strong)IBOutlet NSButton *saveBtn;
- (IBAction)saveBtnClick:(id)sender;

@property (nonatomic,strong)IBOutlet NSTextField *label;

@property (nonatomic,strong)IBOutlet NSButton *previousBtn;
- (IBAction)previousBtnClick:(id)sender;

@property (nonatomic,strong)IBOutlet NSButton *nextBtn;
- (IBAction)nextBtnClick:(id)sender;

@end
