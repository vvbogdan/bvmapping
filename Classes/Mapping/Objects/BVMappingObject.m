//
// BVMappingObject.m
//
//  Created by Vitalii Bogdan on 09/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import "BVMappingObject.h"

@interface BVMappingObject ()

@end

@implementation BVMappingObject

+ (id)key:(NSString *)key property:(NSString *)property parseClass:(Class)parseClass {
    return [[self new] initWithKey:key andProperty:property andParseClass:parseClass];
}


+ (id)key:(NSString *)key property:(NSString *)property {
    return [self key:key property:property parseClass:nil];
}


- (id)initWithKey:(NSString *)key
      andProperty:(NSString *)property
    andParseClass:(Class)parseClass {

    self = [self init];
    if ( self ) {
        self.key = key;
        self.property = property;
        self.parseClass = parseClass;
    }
    return self;
}

@end