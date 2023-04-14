//
//  CalculateAttendance.c
//  JIIT_Buddy
//
//  Created by Anshumali Karna on 12/04/23.
//

#include "CalculateAttendance.h"


float calculateAttendance(float attendedClasses, float totalClasses){
    float attendance;
    
    attendance = (attendedClasses/totalClasses)*100;
    
    
    return attendance;
}
