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
#import "TFSUltility.h"
#import "VCXImporter.h"
#import "HeaderPathFixer.h"
#import "TerminalUltility.h"


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
    [actionMenuItem setKeyEquivalent:@"k"];
    [actionMenuItem setKeyEquivalentModifierMask:NSAlternateKeyMask | NSCommandKeyMask];
    
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addImportVCX:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Import VCX file" action:@selector(doImportVCX) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}

- (void)addAutoFixHeaderPath:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Fix Header Path" action:@selector(doFixHeaderPath) keyEquivalent:@""];
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

- (void)addInsertIfDefMac:(NSMenuItem *)menuItem
{
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Insert #ifdef" action:@selector(doInsertIfDef) keyEquivalent:@""];
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
//        [self addImportVCX:menuItem];
        [self addCheckOutTFSMenu:menuItem];
        [self addAutoFixHeaderPath:menuItem];
        [self addPrintPath:menuItem];
        [self addOpenTerminal:menuItem];
        [self addInsertIfDefMac: menuItem];
    }
}


- (void)doCheckoutTFS
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];

    TFSUltility *tfs = [[TFSUltility alloc] init];
    [tfs checkout:[ideEditor.fileURL path]];
}

- (void)doImportVCX
{
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setTitle:@"Select VCX project file (*.vcxproj)"];
    
    NSInteger cnt = [panel runModal];
    if(cnt == NSFileHandlingPanelOKButton)
    {
        [panel.URL fileSystemRepresentation];
        NSURL *vcxProj = [panel.URL filePathURL];
        
        [panel setTitle:@"Select XCode project file (*.xcodeproj)"];
        cnt = [panel runModal];
        if(cnt == NSFileHandlingPanelOKButton)
        {
            [panel.URL fileSystemRepresentation];
            NSURL *xcodeProj = [panel.URL filePathURL];
            
            VCXImporter *importer = [[VCXImporter alloc] init];
            [importer importVCXProj:vcxProj.path toXCodeProj:xcodeProj.path];
        }
    }
}

- (void)doFixHeaderPath
{
    HeaderPathFixer * fixer = [[HeaderPathFixer alloc] init];
    [fixer fix];
}

- (void)doPrintFilePath
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    
    TerminalUltility *terminal = [[TerminalUltility alloc] init];
    [terminal print:[ideEditor.fileURL path]];
}

- (void)doOpenTerminal
{
    IDESourceCodeDocument * ideEditor = [DTXcodeUtils currentSourceCodeDocument];
    
    TerminalUltility *terminal = [[TerminalUltility alloc] init];
    [terminal open:[ideEditor.fileURL path]];
}

- (void)doInsertIfDef
{
    DVTSourceTextView *sourceTextView = [DTXcodeUtils currentSourceTextView];
    NSRange selectedTextRange = [sourceTextView selectedRange];
    NSString *selectedString = [sourceTextView.textStorage.string substringWithRange:selectedTextRange];
    NSString *ifDefInsert = @"#ifdef <CONDITION>";
    NSString *endIfInsert = @"#endif";
    NSString *newString = [NSString stringWithFormat:@"%@\n%@\n%@", ifDefInsert,
                                 selectedString, endIfInsert];
    
    if (selectedString) {
        [sourceTextView replaceCharactersInRange:selectedTextRange withString:newString];
        NSRange newRange = NSMakeRange(selectedTextRange.location, newString.length);
        [sourceTextView setSelectedRange:newRange];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
