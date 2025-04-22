#import <dlfcn.h>

__attribute__((constructor)) static void init() {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        void *handle = dlopen("/usr/lib/FridaGadget.dylib", RTLD_NOW|RTLD_GLOBAL);
        if (handle) {
            NSLog(@"[FridaLoader] Successfully loaded FridaGadget");
        } else {
            NSLog(@"[FridaLoader] Loading error: %s", dlerror());
        }
    });
}
