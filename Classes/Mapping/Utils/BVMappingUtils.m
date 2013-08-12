//
// BVMappingUtils.m
//
//  Created by Vitalii Bogdan on 10/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import <objc/runtime.h>
#import "BVMappingUtils.h"

@interface BVMappingUtils ()

@end

@implementation BVMappingUtils

+ (NSString *)typeWithPropertyName:(NSString *)propertyName ofClass:(Class)clazz {
    objc_property_t property = class_getProperty(clazz, [propertyName UTF8String]);

    const char * attributes;
    if ( property ) {
        attributes = property_getAttributes(property);
    } else {
        Ivar ivar = class_getInstanceVariable(clazz, [propertyName UTF8String]);
        attributes = ivar_getTypeEncoding(ivar);
    }

    if ( !attributes ) {
        return nil;
    }

    NSString * attributesString = [NSString stringWithUTF8String:attributes];

    // Class
    if ( [attributesString hasPrefix:@"T@\""] ) {
        int commaSeparator = [attributesString rangeOfString:@","].location;
        NSString * name = [attributesString substringWithRange:NSMakeRange(3, commaSeparator - 4)];
        return name;
    }

    // Structure
    // T{CGRect="origin"{CGPoint="x"f"y"f}"size"{CGSize="width"f"height"f}},N,V_rectProperty
    if ( [attributesString hasPrefix:@"T{"] ) {
        int separator = [attributesString rangeOfString:@"="].location;
        NSString * name = [attributesString substringWithRange:NSMakeRange(2, separator - 2 )];
        return name;
    }

    // Number
    // BOOL == char
    // Tc,N,V_iPadEnabled
    if ([attributesString hasPrefix:@"Tf"] ||
            [attributesString hasPrefix:@"Ti"] ||
            [attributesString hasPrefix:@"Td"] ||
            [attributesString hasPrefix:@"Ts"]) {
        NSString *name = @"NSNumber";
        return name;
    }

    // BOOL
    if ([attributesString hasPrefix:@"Tc"]) {
        return @"BOOL";
    }

    return nil;
}



@end