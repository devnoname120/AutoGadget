#import <dlfcn.h>
#import <Foundation/Foundation.h>

__attribute__((constructor)) static void init() {
    @autoreleasepool {
        NSString *gadgetPath = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"Frameworks/FridaGadget.dylib"];
        
        void *handle = dlopen(gadgetPath.UTF8String, RTLD_NOW);
        if (handle) {
            NSLog(@"[FG] FridaGadget loaded successfully");
        } else {
            NSLog(@"[FG] Load error: %s", dlerror());
        }
    }
}
