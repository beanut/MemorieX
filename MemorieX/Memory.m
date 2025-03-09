//
//  Memory.m
//  CPU
//
//  Created by Bernard Lim on 08/02/2025.
//

#import "Memory.h"

double getTotalPhysicalMemory(SizeUnit unit) {
    uint64_t mem = [NSProcessInfo processInfo].physicalMemory;
    mem = convertSize(mem, unit);
    return mem;
}

NSString* getTotalPhysicalMemoryFormatted(SizeUnit unit) {
    NSString* ret = formattedSize(getTotalPhysicalMemory(SizeUnitByte), unit);
    return ret;
}

vm_statistics_data_t get_vm_stat(void) {
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;

    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);

    vm_statistics_data_t vm_stat;

    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        assert(false);
    }
    
    return vm_stat;
}

vm_size_t get_mem_page_size(void) {
    mach_port_t host_port;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_page_size(host_port, &pagesize);
    
    return pagesize;
}

double getMemoryAllocatedForCPU(SizeUnit unit) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    vm_size_t mem_page_size = get_mem_page_size();
    
    double memoryAllocated = ((double)vm_stat.active_count +
                              (double)vm_stat.inactive_count +
                              (double)vm_stat.wire_count +
                              (double)vm_stat.free_count) * (double)mem_page_size;

//    fprintf(stdout, "%f\n", memoryAllocated);
    
    memoryAllocated = convertSize(memoryAllocated, unit);
    
    return memoryAllocated;
}

NSString* getMemoryAllocatedForCPUFormatted(SizeUnit unit) {
    double mem_size = getMemoryAllocatedForCPU(SizeUnitByte);
    return formattedSize(mem_size, unit);
}

double getMemoryAllocatedForGPU(SizeUnit unit) {
    return getTotalPhysicalMemory(unit) - getMemoryAllocatedForCPU(unit);
}

NSString* getMemoryAllocatedForGPUFormatted(SizeUnit unit) {
    return formattedSize(getMemoryAllocatedForGPU(SizeUnitByte), unit);
}

double getFreeMemory(SizeUnit unit) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    vm_size_t mem_page_size = get_mem_page_size();
    
    double mem_ret = convertSize((double)vm_stat.free_count * (double)mem_page_size, unit);
    
    return mem_ret;
}

NSString* getFreeMemoryFormatted(SizeUnit unit) {
    NSString* ret = formattedSize(getFreeMemory(SizeUnitByte), unit);
    return ret;
}

double getActiveMemory(SizeUnit unit) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    vm_size_t mem_page_size = get_mem_page_size();
    
    double mem_ret = convertSize((double)vm_stat.active_count * (double)mem_page_size, unit);
    
    return mem_ret;
}

NSString* getActiveMemoryFormatted(SizeUnit unit) {
    NSString* ret = formattedSize(getFreeMemory(SizeUnitByte), unit);
    return ret;
}

double getInactiveMemory(SizeUnit unit) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    vm_size_t mem_page_size = get_mem_page_size();
    
    double mem_ret = convertSize((double)vm_stat.inactive_count * (double)mem_page_size, unit);
    
    return mem_ret;
}

NSString* getInactiveMemoryFormatted(SizeUnit unit) {
    NSString* ret = formattedSize(getInactiveMemory(SizeUnitByte), unit);
    return ret;
}

double getWiredMemory(SizeUnit unit) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    vm_size_t mem_page_size = get_mem_page_size();
    
    double mem_ret = convertSize((double)vm_stat.wire_count * (double)mem_page_size, unit);
    
    return mem_ret;
}

NSString* getWiredMemoryFormatted(SizeUnit unit) {
    NSString* ret = formattedSize(getWiredMemory(SizeUnitByte), unit);
    return ret;
}

// There’s limited information available on how memory pressure is calculated on Apple systems. However, the following calculation yields a value similar to the one displayed in macOS Activity Monitor.

double getMemoryPressure(void) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    vm_size_t mem_page_size = get_mem_page_size();
    
    uint64_t used_mem = (vm_stat.active_count + vm_stat.wire_count) * mem_page_size;
    
    double pressure = ((double)(used_mem)/ getMemoryAllocatedForCPU(SizeUnitByte)) * 100;
    
    return pressure;
}

double getMemoryPageIns(void) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    return vm_stat.pageins;
}

double getMemoryPageOuts(void) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    return vm_stat.pageouts;
}

double getMemoryFaults(void) {
    vm_statistics_data_t vm_stat = get_vm_stat();
    return vm_stat.faults;
}

//double getPurgeableMemory(SizeUnit unit) {
//    vm_statistics_data_t vm_stat = get_vm_stat();
//    vm_size_t mem_page_size = get_mem_page_size();
//    
//    double mem_ret = convertSize((double)vm_stat.purgeable_count * (double)mem_page_size, unit);
//    
//    return mem_ret;
//}
//
//NSString* getPurgeableMemoryFormatted(SizeUnit unit) {
//    NSString* ret = formattedSize(getPurgeableMemory(SizeUnitByte), unit);
//    return ret;
//}
