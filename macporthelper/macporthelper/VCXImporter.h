//
//  VCXImporter.h
//  macporthelper
//
//  Created by Nguyen Truong Khanh on 14/08/2015.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCXImporter : NSObject
- (BOOL)import:(NSString *)filePath vcProj:(NSString*)filePath2;
@end
