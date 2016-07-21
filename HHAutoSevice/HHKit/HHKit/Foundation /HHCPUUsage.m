//
//  HHCPUUsage.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import "HHCPUUsage.h"
#import <sys/sysctl.h>
#import <sys/types.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <mach/mach.h>
#import <mach/processor_info.h>
#import <mach/mach_host.h>
@interface HHCPUUsage ()

@property (nonatomic, assign) processor_info_array_t prevCPUInfo;
@property (nonatomic, assign) mach_msg_type_number_t numPrevCPUInfo;
@property (nonatomic, assign) unsigned numCPUs;

@end

@implementation HHCPUUsage
float currentProccessCPUUsageImpl(unsigned numCPUs) // CPU使用率
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) // 直接返回错误
    {
        return -1;
    }
    
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) // 直接返回错误
    {
        return -1;
    }
    
    BOOL br = YES;
    float tot_cpu = 0;
    for (int j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) // 遇到一个错误就当失败处理
        {
            br = NO;
            break;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        BOOL idle = (basic_info_th->flags & TH_FLAGS_IDLE);
        if (!idle) // 不空闲
        {
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    tot_cpu = tot_cpu / numCPUs;
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return br ? (tot_cpu / 100.0) : -1;
}


float totalCPUUsageImpl(processor_info_array_t *CPUInfo, mach_msg_type_number_t *num, unsigned numCPUs)
{
    processor_info_array_t cpuInfo = nil;
    mach_msg_type_number_t numCPUInfo = 0;
    
    processor_info_array_t prevCPUInfos = *CPUInfo;
    mach_msg_type_number_t numPrevCPUInfo = *num;
    
    natural_t numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &cpuInfo, &numCPUInfo);
    float cpuUsage = -1;
    if(err == KERN_SUCCESS)
    {
        cpuUsage = 0;
        for(unsigned i = 0U; i < numCPUs; ++i)
        {
            Float32 inUse;
            Float32 total;
            if(prevCPUInfos)
            {
                inUse = ((cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - prevCPUInfos[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                         + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - prevCPUInfos[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                         + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - prevCPUInfos[(CPU_STATE_MAX * i) + CPU_STATE_NICE]));
                total = inUse + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - prevCPUInfos[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            }
            else
            {
                inUse = cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM]
                + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                total = inUse + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            
            NSLog(@"Core : %u, Usage: %.2f%%", i, inUse / total * 100.f);
            cpuUsage = cpuUsage + inUse / total * 100.f;
            NSLog(@"total %.2f", cpuUsage);
        }
        cpuUsage = cpuUsage / numCPUs;
        
        if(prevCPUInfos)
        {
            size_t prevCpuInfoSize = sizeof(integer_t) * numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)prevCPUInfos, prevCpuInfoSize);
        }
        
        *CPUInfo = cpuInfo;
        *num = numCPUInfo;
        
        cpuInfo = nil;
        numCPUInfo = 0U;
    }
    else
    {
        NSLog(@"Error!");
    }
    
    return cpuUsage / 100.0;
}

#pragma mark - singleton

+ (HHCPUUsage *)sharedInstance
{
    static HHCPUUsage *instance = nil;
    if (!instance)
    {
        instance = [HHCPUUsage new];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _prevCPUInfo = nil;
        _numPrevCPUInfo = 0;
        
        int mib[2U] = {CTL_HW, HW_NCPU};
        size_t sizeOfNumCPUs = sizeof(_numCPUs);
        int status = sysctl(mib, 2U, &_numCPUs, &sizeOfNumCPUs, NULL, 0U);
        if(status)
        {
            _numCPUs = 1;
        }
    }
    
    return self;
}

- (void)dealloc
{
    if(_prevCPUInfo)
    {
        size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
        vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
    }
}

#pragma mark - get cpu usage

- (float)currentProccessCPUUsage
{
    return currentProccessCPUUsageImpl(self.numCPUs);
}

- (float)totalCPUUsage
{
    processor_info_array_t CPUInfo = self.prevCPUInfo;
    mach_msg_type_number_t num = self.numPrevCPUInfo;
    float ret = totalCPUUsageImpl(&CPUInfo, &num, self.numCPUs);
    
    self.prevCPUInfo = CPUInfo;
    self.numPrevCPUInfo = num;
    
    return ret;
}

- (NSUInteger)CPUCores
{
    return [NSProcessInfo processInfo].processorCount;
}

@end
