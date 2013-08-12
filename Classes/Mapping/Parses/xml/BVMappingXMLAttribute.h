//
// BVMappingXMLAttribute.h
//
//  Created by Vitalii Bogdan on 12/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import "BVMappingObject.h"

@interface BVMappingXMLAttribute : BVMappingObject

@property (nonatomic, strong) NSString * attributeKey;

+ (id)key:(NSString *)key attributeKey:(NSString *)attributeKey property:(NSString *)property parseClass:(Class)parseClass;
+ (id)key:(NSString *)key attributeKey:(NSString *)attributeKey property:(NSString *)property;

@end