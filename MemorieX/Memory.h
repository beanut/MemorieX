//
//  Memory.h
//  CPU
//
//  Created by Bernard Lim on 08/02/2025.
//

#ifndef Memory_h
#define Memory_h

#import <Foundation/Foundation.h>
#import <MemorieX/SizeUnitConverter.h>
#import <mach/mach.h>

#define getTotalPhysicalMemoryGB() getTotalPhysicalMemory(UNIT_GIGABYTE)
#define getTotalPhysicalMemoryFormattedGB() getTotalPhysicalMemoryFormatted(UNIT_GIGABYTE)

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

//double getPurgeableMemory(SizeUnit unit);
//NSString* getPurgeableMemoryFormatted(SizeUnit unit);
#endif /* Memory_h */
