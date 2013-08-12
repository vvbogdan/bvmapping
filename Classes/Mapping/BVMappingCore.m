//
// BVMappingCore.m
//
//  Created by Vitalii Bogdan on 09/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import "BVMappingCore.h"
#import "BVMappingProtocol.h"
#import "BVMappingObject.h"
#import "BVMappingUtils.h"
#import "BVMappingParseXML.h"
#import "BVMappingArray.h"

@interface BVMappingCore ()

@property (nonatomic, strong) NSMutableDictionary * mappingsInfo;
@property (nonatomic) NSObject<BVMappingParseProtocol> * parserObject;

@end

@implementation BVMappingCore

- (id)init {
    self = [super init];

    if ( self ) {
        self.mappingsInfo = [NSMutableDictionary dictionary];
        self.parserObject = [BVMappingParseXML new];
    }

    return self;
}


+ (instancetype)shared {

    static id instance = nil;

    @synchronized (self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}


+ (void)setParserClass:(Class)clazz {
    [[BVMappingCore shared] setParserObject:[clazz new] ];
}


+ (id)applyMappingFromData:(NSData *)data onClass:(Class)clazz {

    NSError * error;
    NSObject * sourceDocument = [[[BVMappingCore shared] parserObject] documentWithData:data error:&error];

    NSObject * rootElement = [[[BVMappingCore shared] parserObject] rootObjectWithDocumentObject:sourceDocument];

    if ( !rootElement ) {
        rootElement = sourceDocument;
    }

    NSObject * fromObject = [[BVMappingCore shared] mappingClass:clazz sourceObject:rootElement];

    return fromObject;
}


- (NSArray *)mappingInfoForClass:(Class)clazz {
    NSString * className = NSStringFromClass(clazz);

    NSArray * info = [self.mappingsInfo objectForKey:className];

    if ( !info ) {
        NSObject * object = [clazz new];

        if ( [object respondsToSelector:@selector(mappingMetaData)] ) {

            info = [object performSelector:@selector(mappingMetaData)];
            [self.mappingsInfo setObject:info forKey:className];

        }

    }

    return info;
}


- (id)mappingClass:(Class)clazz sourceObject:(id)sourceObject {

    if ( sourceObject == nil ) {
        return nil;
    }

    NSArray * mappingInfo = [[BVMappingCore shared] mappingInfoForClass:clazz];

    id fromObject = [clazz new];

    for ( NSUInteger i = 0; i < [mappingInfo count]; i++ ) {
        id info = [mappingInfo objectAtIndex:i];
        if ( [info isKindOfClass:[BVMappingObject class]] ) {
            BVMappingObject * mappingObject = info;

            NSString * type = [BVMappingUtils typeWithPropertyName:mappingObject.property ofClass:clazz];

            id object = [NSNull null];
            if ( [type isEqualToString:@"NSString"] ) {

                object = [[[BVMappingCore shared] parserObject] valueStringWithMappingObject:mappingObject sourceObject:sourceObject];

            } else if ( [type isEqualToString:@"NSNumber"] ) {

                NSString * objectNumberString = [[[BVMappingCore shared] parserObject] valueStringWithMappingObject:mappingObject sourceObject:sourceObject];
                if ( objectNumberString ) {
                    NSNumber * number = [NSDecimalNumber decimalNumberWithString:objectNumberString];
                    object = number;
                } else {
                    object = [NSNumber numberWithInt:0];
                }

            } else if ( [type isEqualToString:@"BOOL"] ) {

                NSString * objectBoolString = [[[BVMappingCore shared] parserObject] valueStringWithMappingObject:mappingObject sourceObject:sourceObject];
                if ( objectBoolString ) {
                    object = [NSNumber numberWithInt:[objectBoolString intValue]];
                } else {
                    object = [NSNumber numberWithBool:NO];
                }
            } else if ( [type isEqualToString:@"NSArray"] || [type isEqualToString:@"NSMutableArray"] ) {

                if ( [mappingObject isKindOfClass:[BVMappingArray class]] ) {

                    NSArray * sourceArray = [[[BVMappingCore shared] parserObject] arrayWithMappingObject:mappingObject sourceObject:sourceObject];

                    if ( [sourceArray count] > 0 && [(BVMappingArray *)mappingObject itemClass] ) {
                        NSMutableArray * mutableArray = [NSMutableArray array];

                        Class classObject = NSClassFromString([(BVMappingArray *)mappingObject itemClass]);

                        if ( classObject ) {
                            for ( id source in sourceArray ) {
                                id objectOfClass = [self mappingClass:classObject sourceObject:source];

                                if ( objectOfClass != nil ) {
                                    [mutableArray addObject:objectOfClass];
                                }
                            }
                        }

                        object = mutableArray;
                    }

                }

            } else if ( type != nil ) {

                Class classObject = NSClassFromString(type);

                id source = [[[BVMappingCore shared] parserObject] valueObjectWithMappingObject:mappingObject sourceObject:sourceObject];
                object = [self mappingClass:classObject sourceObject:source];

            }

            if ( mappingObject.property && [fromObject respondsToSelector:NSSelectorFromString(mappingObject.property)] ) {
                [fromObject setValue:object forKey:mappingObject.property];
            }
        }
    }


    if ( [fromObject respondsToSelector:@selector(afterMapping:)] ) {
        [fromObject afterMapping:fromObject];
    }

    return fromObject;
}


@end