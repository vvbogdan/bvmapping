//
// BVMappingObject.h
//
//  Created by Vitalii Bogdan on 09/08/2013 .
//  Copyright (c) 2013. All rights reserved.

@interface BVMappingObject : NSObject

@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSString * property;
@property (nonatomic, assign) Class parseClass;

- (id)initWithKey:(NSString *)key
      andProperty:(NSString *)property
    andParseClass:(Class)parseClass;

+ (id)key:(NSString *)key property:(NSString *)property parseClass:(Class)parseClass;
+ (id)key:(NSString *)key property:(NSString *)property;

@end