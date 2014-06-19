//
//  Log.h
//  DLImageLoader
//

#import <Foundation/Foundation.h>

@interface Log : NSObject<NSCoding> {
    NSInteger   baseAddress;
    NSString    *dlName;
    BOOL        logType;
}
@property(atomic, assign) NSInteger baseAddress;
@property(atomic, retain) NSString  *dlName;
@property(atomic, assign) BOOL      logType;

@end
