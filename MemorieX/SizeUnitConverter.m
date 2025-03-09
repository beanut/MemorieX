//
//  SizeUnitConverter.m
//  CPU
//
//  Created by Bernard Lim on 02/03/2025.
//

#import "SizeUnitConverter.h"

double convertSize(double bytes, SizeUnit unit) {
    switch (unit) {
        case SizeUnitByte:       return bytes;
        case SizeUnitKilobyte:   return bytes / 1024.0;
        case SizeUnitMegabyte:   return bytes / (1024.0 * 1024.0);
        case SizeUnitGigabyte:   return bytes / (1024.0 * 1024.0 * 1024.0);
        case SizeUnitTerabyte:   return bytes / (1024.0 * 1024.0 * 1024.0 * 1024.0);
        case SizeUnitPetabyte:   return bytes / (1024.0 * 1024.0 * 1024.0 * 1024.0 * 1024.0);
        case SizeUnitMillibyte:  return bytes * 1000.0;
        case SizeUnitMicrobyte:  return bytes * 1e6;
        case SizeUnitNanobyte:   return bytes * 1e9;
        case SizeUnitPicobyte:   return bytes * 1e12;
        default:                 return 0.0;
    }
}

NSString *formattedSize(double bytes, SizeUnit unit) {
    double convertedValue = convertSize(bytes, unit);
    NSArray *unitNames = @[@"B", @"KB", @"MB", @"GB", @"TB", @"PB", @"mB", @"µB", @"nB", @"pB"];
    
    return [NSString stringWithFormat:@"%.2f %@", convertedValue, unitNames[unit]];
}
