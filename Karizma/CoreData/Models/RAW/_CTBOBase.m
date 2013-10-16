// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CTBOBase.m instead.

#import "_CTBOBase.h"

const struct CTBOBaseAttributes CTBOBaseAttributes = {
};

const struct CTBOBaseRelationships CTBOBaseRelationships = {
};

const struct CTBOBaseFetchedProperties CTBOBaseFetchedProperties = {
};

@implementation CTBOBaseID
@end

@implementation _CTBOBase

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CTBOBase" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CTBOBase";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CTBOBase" inManagedObjectContext:moc_];
}

- (CTBOBaseID*)objectID {
	return (CTBOBaseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}









@end
