//
//  Log.m
//  DLImageLoader
//

#import "Log.h"

#define kEncodeKeyDLName        @"kEncodeKeyDLName"
#define kEncodeKeyBaseAddress   @"kEncodeKeyBaseAddress"
#define kEncodeKeyLogType       @"kEncodeKeyLogType"

@implementation Log

@synthesize logType;
@synthesize dlName;
@synthesize baseAddress;

#pragma Encoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.dlName forKey:kEncodeKeyDLName];
    [aCoder encodeInt32:self.baseAddress forKey:kEncodeKeyBaseAddress];
    [aCoder encodeBool:self.logType forKey:kEncodeKeyLogType];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.dlName = [aDecoder decodeObjectForKey:kEncodeKeyDLName];
        self.baseAddress = [aDecoder decodeInt32ForKey:kEncodeKeyBaseAddress];
        self.logType = [aDecoder decodeBoolForKey:kEncodeKeyLogType];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ 0x%02lx %@ \n",
            self.logType ? @"Load :" : @"Unload :", (long)self.baseAddress, self.dlName];
}


@end
