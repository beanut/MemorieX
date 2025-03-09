//
//  DarwinKernelInfo.m
//  CPU
//
//  Created by Bernard Lim on 07/02/2025.
//

#import "DarwinKernelInfo.h"

NS_ASSUME_NONNULL_BEGIN

//struct  utsname {
//    char    sysname[_SYS_NAMELEN];  /* [XSI] Name of OS */
//    char    nodename[_SYS_NAMELEN]; /* [XSI] Name of this network node */
//    char    release[_SYS_NAMELEN];  /* [XSI] Release level */
//    char    version[_SYS_NAMELEN];  /* [XSI] Version level */
//    char    machine[_SYS_NAMELEN];  /* [XSI] Hardware type */
//};

NSString *getKernelInfo(DarwinKernelAttribute attr) {
    struct utsname* utsname_inst = malloc(sizeof(struct utsname));
    
    if (NULL == utsname_inst) {
        return @"malloc(sizeof(struct utsname)) failed";
    }

    if (0 == uname(utsname_inst)) {
        NSString *outp = @"";
        switch (attr) {
            case DarwinKernelAttributeSysname:
                outp = [NSString stringWithUTF8String:utsname_inst->sysname];
                break;
            case DarwinKernelAttributeNodename:
                outp = [NSString stringWithUTF8String:utsname_inst->nodename];
                break;
            case DarwinKernelAttributeVersion:
                outp = [NSString stringWithUTF8String:utsname_inst->version];
                break;
            case DarwinKernelAttributeRelease:
                outp = [NSString stringWithUTF8String:utsname_inst->release];
                break;
            default:
                outp = [NSString stringWithUTF8String:utsname_inst->machine];
                break;
        }
        
        free(utsname_inst);
        utsname_inst = NULL;
        return outp;
    } else {
        free(utsname_inst);
        utsname_inst = NULL;
        return @"Unknown";
    }
}

NS_ASSUME_NONNULL_END
