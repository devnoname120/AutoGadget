#import <Foundation/Foundation.h>
#import <dlfcn.h>

__attribute__((constructor)) static void init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        void *handle = dlopen("/usr/lib/FridaGadget.dylib", RTLD_NOW);
        if (handle) {
            NSLog(@"[FridaLoader] Gadget loaded successfully");
        } else {
            NSLog(@"[FridaLoader] Error loading gadget: %s", dlerror());
        }
    });
}
