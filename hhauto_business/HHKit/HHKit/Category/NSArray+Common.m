//
//  NSArray+Common.m
//

#import "NSArray+Common.h"

@implementation NSArray (Common)

- (id)objectAtIndexSafe:(NSInteger)index
{
    if(index < self.count && index >= 0)
    {
        return [self objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

@end
