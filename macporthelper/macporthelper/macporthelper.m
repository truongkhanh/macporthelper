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
    //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addImportVCX:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Import VCX file" action:@selector(doImportVCX) keyEquivalent:@""];
    //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addAutoFixHeaderPath:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Fix Header Path" action:@selector(doFixHeaderPath) keyEquivalent:@""];
    //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addOpenTerminal:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Open Terminal" action:@selector(doOpenTerminal) keyEquivalent:@""];
    //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
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
        [self addImportVCX:menuItem];
        [self addAutoFixHeaderPath:menuItem];
        [self addOpenTerminal:menuItem];
    }
}


- (void)doCheckoutTFS
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:ideEditor.fileURL];
    [alert runModal];
}

- (void)doImportVCX
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Import VCX File"];
    [alert runModal];
}

- (void)doFixHeaderPath
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:ideEditor.fileURL];
    [alert runModal];
    
    //Follow here http://www.overacker.me/blog/2015/01/25/creating-an-xcode-plugin
}

- (void)doOpenTerminal
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:ideEditor.fileURL];
    [alert runModal];
    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
