//
//  DLLogger.m
//  DLImageLoader
//

#import "DLLogger.h"
#import "Log.h"
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <mach-o/loader.h>

static NSMutableArray   *logger = nil;

@implementation DLLogger

+ (void)load
{
    logger = [[NSMutableArray alloc] init];
    [DLLogger readFromFile];
	_dyld_register_func_for_add_image(&dlLoad);
	_dyld_register_func_for_remove_image(&dlUnload);
}


#pragma mark - Callbacks

static void dlLoad(const struct mach_header *header, intptr_t slide)
{
    [DLLogger writeToFile:header withLog:YES];
}


static void dlUnload(const struct mach_header *header, intptr_t slide)
{
    [DLLogger writeToFile:header withLog:NO];
}

#pragma mark - Logger

+ (void) writeToFile: (const struct mach_header *) header withLog: (BOOL) logType {

    Dl_info image_info;
    int rs = dladdr(header, &image_info);

    if (rs == 0) {
        printf("ERROR !!! Could not fetch mach_header: %p\n\n", header);
        return;
    }
    const char *dlName = image_info.dli_fname;
    const intptr_t baseAddress = (intptr_t)image_info.dli_fbase;

    Log *log = [[Log alloc] init];
    log.baseAddress = baseAddress;
    log.dlName = [NSString stringWithUTF8String:dlName];
    log.logType =  logType;
    [logger addObject:log];

    if ([logger count] == _dyld_image_count()) {
        [NSKeyedArchiver archiveRootObject:logger toFile:[DLLogger getPath]];
    }
}

+(void) readFromFile
{
    NSArray *read = [NSKeyedUnarchiver unarchiveObjectWithFile:[DLLogger getPath]];
    for (Log *log in read) {
        NSLog(@"%s\n",[log.description cStringUsingEncoding:NSUTF8StringEncoding]);
    }

}

+(NSString *) getPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"DLImages.dat"];
}

@end
