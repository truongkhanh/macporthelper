//
//  macporthelper.h
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 13/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <AppKit/AppKit.h>

@class macporthelper;

static macporthelper *sharedPlugin;

@interface macporthelper : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end