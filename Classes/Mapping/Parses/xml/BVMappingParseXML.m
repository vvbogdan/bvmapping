//
// BVMappingParseXML.m
//
//  Created by Vitalii Bogdan on 10/08/2013 .
//  Copyright (c) 2013. All rights reserved.

#import <GDataXML-HTML/GDataXMLNode.h>
#import "BVMappingParseXML.h"
#import "BVMappingObject.h"
#import "BVMappingXMLAttribute.h"
#import "BVMappingArray.h"

@interface BVMappingParseXML ()


@end

@implementation BVMappingParseXML

- (NSObject *)documentWithData:(NSData *)data error:(NSError **)error {
    GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithData:data error:error];
    return document;
}


- (NSObject *)rootObjectWithDocumentObject:(NSObject *)document {
    return [(GDataXMLDocument *)document rootElement];
}


- (NSString *)valueStringWithMappingObject:(BVMappingObject *)mappingObject sourceObject:(id)sourceObject {
    NSString * value = nil;

    if ( [sourceObject isKindOfClass:[GDataXMLElement class]] ) {
        GDataXMLElement * xmlElement = sourceObject;

        if ( [mappingObject isKindOfClass:[BVMappingXMLAttribute class]] ) {
            if ( [(BVMappingXMLAttribute *)mappingObject attributeKey] ) {
                value = [[[sourceObject elementsForName:mappingObject.key][0] attributeForName:[(BVMappingXMLAttribute *)mappingObject attributeKey]] stringValue];
            } else {
                value = [[sourceObject attributeForName:[(BVMappingXMLAttribute *)mappingObject key]] stringValue];
            }
        } else {
            value = [[xmlElement elementsForName:mappingObject.key][0] stringValue];
        }
    }

    return value;
}


- (id)valueObjectWithMappingObject:(BVMappingObject *)mappingObject sourceObject:(id)sourceObject {
    NSString * value = nil;

    if ( [sourceObject isKindOfClass:[GDataXMLElement class]] ) {
        GDataXMLElement * xmlElement = sourceObject;
        value = [xmlElement elementsForName:mappingObject.key][0];
    }

    return value;

}


- (NSArray *)arrayWithMappingObject:(BVMappingObject *)mappingObject sourceObject:(id)sourceObject {
    NSArray * array = nil;
    if ( [sourceObject isKindOfClass:[GDataXMLElement class]] ) {
        GDataXMLElement * xmlElement = sourceObject;
        if ( [mappingObject isKindOfClass:[BVMappingArray class]] ) {
            if ( [(BVMappingArray *)mappingObject parentKey] ) {
                array = [[xmlElement elementsForName:[(BVMappingArray *)mappingObject parentKey]][0] elementsForName:mappingObject.key];
            } else {
                array = [xmlElement elementsForName:mappingObject.key];
            }
        }
    }

    return array;
}

@end