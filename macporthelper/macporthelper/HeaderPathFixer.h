//
//  HeaderPathFixer.h
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface HeaderPathFixer : NSObject
- (void)fix:(NSURL *)filePath;

@end
