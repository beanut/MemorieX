//
//  DarwinKernelInfo.h
//  CPU
//
//  Created by Bernard Lim on 07/02/2025.
//

#ifndef DarwinKernelInfo_h
#define DarwinKernelInfo_h

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <sys/sysctl.h>

typedef NS_ENUM(NSInteger, DarwinKernelAttribute) {
    DarwinKernelAttributeSysname,
    DarwinKernelAttributeNodename,
    DarwinKernelAttributeRelease,
    DarwinKernelAttributeVersion,
    DarwinKernelAttributeMachine
};

NSString *getKernelInfo(DarwinKernelAttribute attr);

#endif /* DarwinKernelInfo_h */
