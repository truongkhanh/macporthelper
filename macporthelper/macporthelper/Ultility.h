//
//  Ultility.h
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 16/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ultility : NSObject

+ (NSString *) buildCommand: (NSString *) command;
+ (void) append: (NSMutableString *) s withLine: (NSString *) line;
@end
