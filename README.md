# MemorieX
A lightweight library for retrieving memory statistics on iOS and macOS. This is part of an app I'm currently developing.

## 🚀 Features
- Retrieve system memory usage (free, active, wired, etc).
- Get CPU and GPU memory stats.
- Built on top of <mach/mach.h>.

## 📦 Installation
- Drag and drop the folder MemorieX into your project.
- For memory statistics, #import <MemorieX/Memory.h>
- For kernel information, #import <MemorieX/DarwinKernelInfo.h>

## ❓ How to use
- The enums methods defined in the headers are pretty self-explanatory.
- To expose to Swift, import the headers you need in your bridging header file.

Memory.h:
``` c
double getTotalPhysicalMemory(SizeUnit unit);
NSString* getTotalPhysicalMemoryFormatted(SizeUnit unit);
vm_statistics_data_t get_vm_stat(void);
vm_size_t get_mem_page_size(void);
double getMemoryAllocatedForCPU(SizeUnit unit);
NSString* getMemoryAllocatedForCPUFormatted(SizeUnit unit);
double getMemoryAllocatedForGPU(SizeUnit unit);
NSString* getMemoryAllocatedForGPUFormatted(SizeUnit unit);
double getFreeMemory(SizeUnit unit);
NSString* getFreeMemoryFormatted(SizeUnit unit);
double getActiveMemory(SizeUnit unit);
NSString* getActiveMemoryFormatted(SizeUnit unit);
double getInactiveMemory(SizeUnit unit);
NSString* getInactiveMemoryFormatted(SizeUnit unit);
double getWiredMemory(SizeUnit unit);
NSString* getWiredMemoryFormatted(SizeUnit unit);

// There’s limited information available on how memory pressure is calculated on Apple systems. However, the following function returns a value similar to the one displayed in macOS Activity Monitor.
double getMemoryPressure(void);

double getMemoryPageIns(void);
double getMemoryPageOuts(void);
double getMemoryFaults(void);
``` 

DarwinKernelInfo.h:
``` c
typedef NS_ENUM(NSInteger, DarwinKernelAttribute) {
    DarwinKernelAttributeSysname,
    DarwinKernelAttributeNodename,
    DarwinKernelAttributeRelease,
    DarwinKernelAttributeVersion,
    DarwinKernelAttributeMachine
};

NSString *getKernelInfo(DarwinKernelAttribute attr);
``` 

SizeUnitConverter.h:
``` c
typedef NS_ENUM(NSInteger, SizeUnit) {
    SizeUnitByte,
    
    SizeUnitKilobyte,
    SizeUnitMegabyte,
    SizeUnitGigabyte,
    SizeUnitTerabyte,
    SizeUnitPetabyte,
    
    SizeUnitMillibyte,
    SizeUnitMicrobyte,
    SizeUnitNanobyte,
    SizeUnitPicobyte
};

double convertSize(double bytes, SizeUnit unit);
NSString *formattedSize(double bytes, SizeUnit unit);
``` 

