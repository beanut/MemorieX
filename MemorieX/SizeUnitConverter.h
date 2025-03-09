//
//  UnitEnum.h
//  CPU
//
//  Created by Bernard Lim on 02/03/2025.
//

#ifndef UnitEnum_h
#define UnitEnum_h

#import <Foundation/Foundation.h>

#define UNIT_GIGABYTE SizeUnitGigabyte


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

#endif /* UnitEnum_h */
