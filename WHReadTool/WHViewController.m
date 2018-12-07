//
//  WHViewController.m
//  WHReadTool
//
//  Created by 静 on 2018/9/27.
//  Copyright © 2018年 静. All rights reserved.
//

#import "WHViewController.h"


#define textCount 40
@interface WHViewController ()<NSWindowDelegate>
@property(nonatomic,strong) NSMenu * subMenu;
@property(nonatomic,strong) NSString * book;
@property(nonatomic,assign) BOOL isBlack;
@property(nonatomic,assign) BOOL isMiniaturized;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSString * bookName;

@end

@implementation WHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.textFidel.maximumNumberOfLines = 0;
    self.isBlack = YES;
    //main menu
    NSMenu *mainMenu = [NSApp mainMenu];
    
    //menuitem
    NSMenuItem *MenuItem = [[NSMenuItem alloc]
                            init];
    [MenuItem setTitle:@"Load_TEXT"];
    
    //sub menu
    self.subMenu = [[NSMenu alloc]
                       initWithTitle:@"alsjhdaklsjhdl akjhsdl akjhsd akjhsdlkjahsdlkjhdlkjsdhl asjdlakshdl akhsjd "];

    
//    //sub menuItem1
//
//    [subMenu
//     addItemWithTitle:@"Load_Text1"action:@selector(test)keyEquivalent:@"E"];
//
//    //sub menuitem2
//
//    [subMenu
//     addItemWithTitle:@"Load_Text2"action:@selector(addNewMenuItem)keyEquivalent:@"Q"];
//

    
    
    //set sub menu
    [MenuItem setSubmenu:self.subMenu];
    
    
    
    //add new menuitem
    [mainMenu addItem:MenuItem];
    NSLog(@"%@",mainMenu);
    
    self.index = 0;
    
    self.label.stringValue = @"请选择文件";
    
    self.textFidel.placeholderString = @"请选择txt文件或者将要阅读的文字粘贴到此处。粘贴文字暂不支持保存阅读记录";
    
    
    
 
}

- (IBAction)readBtnClick:(id)sender {
    self.index = 0;
    [self nextBtnClick:self.nextBtn];
}

-(void)showAlert:(NSString *)content{
    NSAlert *alert = [[NSAlert alloc]init];
    //        alert.icon = [NSImage imageNamed:@"baba.png"];[alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    alert.messageText = @"提示";
    alert.informativeText = content;
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSModalResponse returnCode) {        if (returnCode == NSAlertFirstButtonReturn ) {            NSLog(@"this is OK Button tap");
        
    }else if (returnCode == NSAlertSecondButtonReturn){            NSLog(@"this is Cancel Button tap");
        
    }
        
    }];
}

- (IBAction)colorBtnClick:(id)sender {
    
    self.textFidel.textColor = self.isBlack?[NSColor whiteColor]:[NSColor blackColor];
    self.isBlack = !self.isBlack;
}
- (IBAction)chooseFileBtnClick:(id)sender {
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    NSArray *array = [NSArray arrayWithObject:@"txt"];
     [panel setAllowedFileTypes:array];
    [panel setAllowsMultipleSelection:NO];  //是否允许多选file
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            NSMutableArray* filePaths = [[NSMutableArray alloc] init];
            for (NSURL* elemnet in [panel URLs]) {
                self.book = [NSString stringWithContentsOfURL:elemnet encoding:NSUTF8StringEncoding error:nil];
                [filePaths addObject:[elemnet path]];
                // 从路径中获得完整的文件名（带后缀）
               NSString * exestr = [elemnet lastPathComponent];
                NSLog(@"%@",exestr);
                // 获得文件名（不带后缀）
                self.bookName = [exestr stringByDeletingPathExtension];
                [self finshChooseFile];
            }
            
            NSLog(@"filePaths : %@",filePaths);
        }
        
    }];
   
}

-(void)finshChooseFile{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *index = [ user objectForKey:self.bookName];
    
    self.index = index.integerValue;
    if (!self.index) {
        self.index = 0;
    }
    
    self.indexTextFeild.stringValue = [NSString stringWithFormat:@"%ld",(long)self.index];
    
    self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%@字",self.bookName,self.indexTextFeild.stringValue];
}
- (IBAction)jumpBtnClick:(id)sender {
    self.index = self.indexTextFeild.stringValue.integerValue;
    if (self.index<0) {
        [self showAlert:@"请输出正确数字"];
    }
    if (self.book.length>self.index + textCount) {
        self.subMenu.title  =  [self.book substringWithRange:NSMakeRange(self.index, textCount)];
        self.index = self.index+textCount;
        self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%ld字",self.bookName,(long)self.index];
    }else if (self.textFidel.stringValue.length > self.index+textCount) {
        self.subMenu.title  =  [self.textFidel.stringValue substringWithRange:NSMakeRange(self.index, textCount)];
        self.index = self.index+textCount;
        self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%ld字",self.bookName,(long)self.index];
    }else{
        [self showAlert:@"请输出正确数字"];
    }
}
- (IBAction)saveBtnClick:(id)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (self.index == 0) {
        [self showAlert:@"没有开始阅读"];
    }else{
    [user setObject:@(self.index) forKey:self.bookName];
        self.indexTextFeild.stringValue = [NSString stringWithFormat:@"%ld",(long)self.index];
    }
}

- (void)viewDidDisappear{
    self.isMiniaturized = YES;
}

- (void)viewDidAppear{
    self.isMiniaturized = NO;
}

- (void)keyDown:(NSEvent *)event{
    if (!self.isMiniaturized) {
        return;
    }
    
    if (event.keyCode == 124) {
        [self nextBtnClick:self.nextBtn];
    }else if (event.keyCode == 123){
        [self previousBtnClick:self.previousBtn];
    }
}

- (void)keyUp:(NSEvent *)event{
    
}
-(void)awakeFromNib{
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull aEvent) {
        [self keyDown:aEvent];
        return aEvent;
    }];
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskFlagsChanged handler:^NSEvent * _Nullable(NSEvent * _Nonnull aEvent) {
        [self flagsChanged:aEvent];
        return aEvent;
    }];
}



- (IBAction)previousBtnClick:(id)sender {
    if (self.index - textCount > 0) {
        if (self.book.length>1) {
            self.subMenu.title  =  [self.book substringWithRange:NSMakeRange(self.index - textCount, textCount)];
            self.index = self.index-textCount;
            
            self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%ld字",self.bookName,(long)self.index];
        }else {
            self.subMenu.title  =  [self.textFidel.stringValue substringWithRange:NSMakeRange(self.index, textCount)];
            self.index = self.index+textCount;
            self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%ld字",self.bookName,(long)self.index];
        }
    }else{
        
        [self showAlert:@"已经是第一句了"];
        
        
    }
    
}
- (IBAction)nextBtnClick:(id)sender {
    if (self.book.length>self.index+textCount) {
        self.subMenu.title  =  [self.book substringWithRange:NSMakeRange(self.index, textCount)];
        self.index = self.index+textCount;
        self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%ld字",self.bookName,(long)self.index];
    }else if (self.textFidel.stringValue.length > self.index+textCount) {
        self.subMenu.title  =  [self.textFidel.stringValue substringWithRange:NSMakeRange(self.index, textCount)];
        self.index = self.index+textCount;
        self.label.stringValue = [NSString stringWithFormat:@"当前阅读%@到%ld字",self.bookName,(long)self.index];
    }else{
        
        [self showAlert:@"没有更多了"];
        
        
    }
}
@end
