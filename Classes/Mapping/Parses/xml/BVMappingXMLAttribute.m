//
// BVMappingXMLAttribute.m
//
//  Created by Vitalii Bogdan on 12/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import "BVMappingXMLAttribute.h"

@interface BVMappingXMLAttribute ()

@end

@implementation BVMappingXMLAttribute

+ (id)key:(NSString *)key attributeKey:(NSString *)attributeKey property:(NSString *)property parseClass:(Class)parseClass {
    return [[self new] initWithKey:key andAttributeKey:attributeKey andProperty:property andParseClass:parseClass];
}


+ (id)key:(NSString *)key attributeKey:(NSString *)attributeKey property:(NSString *)property {
    return [self key:key attributeKey:attributeKey property:property parseClass:nil];
}


- (id)initWithKey:(NSString *)key
  andAttributeKey:(NSString *)attributeKey
      andProperty:(NSString *)property
    andParseClass:(Class)parseClass {

    self = [super initWithKey:key andProperty:property andParseClass:parseClass];
    if ( self ) {
        self.attributeKey = attributeKey;
    }
    return self;
}

@end