//
//  HeaderPathFixer.m
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "HeaderPathFixer.h"
#import "DTXcodeHeaders.h"
#import "DTXcodeUtils.h"

@implementation HeaderPathFixer
- (void)fix:(NSURL *)filePath
{
    //Follow here http://www.overacker.me/blog/2015/01/25/creating-an-xcode-plugin
    NSLog(@"Fix header file: %@", [filePath absoluteString]);

    
    DVTSourceTextView *sourceTextView = [DTXcodeUtils currentSourceTextView];
    NSString *source = [sourceTextView string];

    
    NSString * newSource = [self fixHeaderPath:source];
    [sourceTextView setString:newSource];

}

- (NSString *) fixHeaderPath: (NSString *) source
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSArray* lines = [source componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    for(NSString * line in lines){
        if([line containsString:@"#include"]){
            NSString *newLine = [line stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
            [result appendFormat:@"%@\n", newLine];
        }
        else{
            [result appendFormat:@"%@\n", line];
        }
    }
    
    return [NSString stringWithString:result];
}
@end
