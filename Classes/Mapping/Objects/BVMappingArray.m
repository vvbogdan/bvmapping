//
// BVMappingArray.m
//
//  Created by Vitalii Bogdan on 12/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import "BVMappingArray.h"

@interface BVMappingArray ()

@end

@implementation BVMappingArray

+ (id)key:(NSString *)key property:(NSString *)property itemClass:(NSString *)itemClass {
    return [[self new] initWithKey:key andParentKey:nil andItemClass:itemClass andProperty:property];
}


+ (id)key:(NSString *)key parentKey:(NSString *)parentKey property:(NSString *)property itemClass:(NSString *)itemClass {
    return [[self new] initWithKey:key andParentKey:parentKey andItemClass:itemClass andProperty:property];
}


- (id)initWithKey:(NSString *)key
     andParentKey:(NSString *)parentKey
     andItemClass:(NSString *)itemClass
      andProperty:(NSString *)property {

    self = [self initWithKey:key andProperty:property andParseClass:nil];
    if ( self ) {
        self.parentKey = parentKey;
        self.itemClass = itemClass;
    }
    return self;
}

@end