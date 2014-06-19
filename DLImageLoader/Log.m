//
//  Log.m
//  DLImageLoader
//

#import "Log.h"

#define kEncodeKeyStringValue   @"kEncodeKeyStringValue"
#define kEncodeKeyIntValue      @"kEncodeKeyIntValue"
#define kEncodeKeyBOOLValue     @"kEncodeKeyBOOLValue"

@implementation Log

@synthesize logType;
@synthesize dlName;
@synthesize baseAddress;

#pragma Encoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.dlName forKey:kEncodeKeyStringValue];
    [aCoder encodeInt32:self.baseAddress forKey:kEncodeKeyIntValue];
    [aCoder encodeBool:self.logType forKey:kEncodeKeyBOOLValue];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.dlName = [aDecoder decodeObjectForKey:kEncodeKeyStringValue];
        self.baseAddress = [aDecoder decodeInt32ForKey:kEncodeKeyIntValue];
        self.logType = [aDecoder decodeBoolForKey:kEncodeKeyBOOLValue];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ 0x%02lx %@ \n",
            self.logType ? @"Load :" : @"Unload :", (long)self.baseAddress, self.dlName];
}


@end
