//
//  HeaderPathFixer.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "HeaderPathFixer.h"
#import <AppKit/AppKit.h>
#import "DTXcodeHeaders.h"
#import "DTXcodeUtils.h"
#import "Ultility.h"

@implementation HeaderPathFixer
- (void)fix
{
    DVTSourceTextView *sourceTextView = [DTXcodeUtils currentSourceTextView];
    NSString *source = [sourceTextView string];
    NSString * newSource = [self fixHeaderPath:source];
    [sourceTextView setString:newSource];

}

- (NSString *) fixHeaderPath: (NSString *) source
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    //not work for some old files, new empty lines are created
//    NSArray* lines = [source componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSArray *lines = [source componentsSeparatedByString:@"\n"];

    for(NSString * line in lines){
        if([line hasPrefix:@"#include"]){
            NSString *newLine = [line stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
            [Ultility append:result withLine:newLine];
        }
        else{
            [Ultility append:result withLine:line];
        }
        
        NSLog(result);
    }
    
    return [NSString stringWithString:result];
}
@end
