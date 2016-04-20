//
//  macporthelper.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 13/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "macporthelper.h"
#import "DTXcodeHeaders.h"
#import "DTXcodeUtils.h"
#import "Ultility.h"


@interface macporthelper()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation macporthelper

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)addCheckOutTFSMenu:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Checkout TFS" action:@selector(doCheckoutTFS) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addRevertTFSMenu:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Revert TFS" action:@selector(doRevertTFS) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addOpenFolder:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Open Folder" action:@selector(doOpenFolder) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addPrintPath:(NSMenuItem *)menuItem
{
  NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Print File Path" action:@selector(doPrintFilePath) keyEquivalent:@""];
  [actionMenuItem setTarget:self];
  [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addOpenTerminal:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Open Terminal" action:@selector(doOpenTerminal) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        [self addCheckOutTFSMenu:menuItem];
        [self addRevertTFSMenu:menuItem];
//        [self addOpenFolder: menuItem];
        [self addPrintPath:menuItem];
        [self addOpenTerminal:menuItem];
    }
}


- (void)doCheckoutTFS
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];

    [Ultility checkout:[ideEditor.fileURL path]];
}

- (void)doRevertTFS
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    
    [Ultility revert:[ideEditor.fileURL path]];
}

- (void)doOpenFolder
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    
    NSString *parentFolderPath = [[ideEditor.fileURL path] stringByDeletingLastPathComponent];
    [Ultility openInFinder:parentFolderPath];
}

- (void)doPrintFilePath
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    
    [Ultility print:[ideEditor.fileURL path]];
}

- (void)doOpenTerminal
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    
    NSString *parentFolderPath = [[ideEditor.fileURL path] stringByDeletingLastPathComponent];
    [Ultility openTerminalOnFolder:parentFolderPath];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
