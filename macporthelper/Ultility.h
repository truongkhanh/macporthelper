//
//  Ultility.h
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 16/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ultility : NSObject
+ (BOOL)checkout:(NSString *)filePath;
+ (BOOL)revert:(NSString *)filePath;
+ (void)openInFinder:(NSString *)path;
+ (void)print:(NSString *)message;
+ (void)openTerminalOnFolder:(NSString*)path;
@end
