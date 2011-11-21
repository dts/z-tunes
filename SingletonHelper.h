//
//  SingletonHelper.h
//  Z-Tunes
//
//  Created by Daniel Staudigel on 11/21/11.
//  Copyright (c) 2011 mountainmandan.net. All rights reserved.
//

#ifndef Z_Tunes_SingletonHelper_h
#define Z_Tunes_SingletonHelper_h

#define SINGLETON_DEFS(type,accessor) + (type*)accessor;

#define _SINGLETON_IMPS(variable,type,accessor) \
static type * variable=nil; \
+ (type*)accessor { \
@synchronized(self) { \
if(variable==nil) {\
variable= [[self alloc] init]; \
}\
}\
return variable;\
}\
+ (id)allocWithZone:(NSZone *)zone\
{\
    @synchronized(self) {\
        if (variable == nil) {\
            variable = [super allocWithZone:zone];\
            return variable;  \
        }\
    }\
    return nil; \
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return self;\
}\
\
- (id)retain\
{\
    return self;\
}\
\
- (unsigned)retainCount\
{\
    return UINT_MAX;\
}\
\
- (oneway void)release\
{\
}\
\
- (id)autorelease\
{\
    return self;\
}


#define SINGLETON_IMPS(typeName,accessorName) _SINGLETON_IMPS(__shared_##typeName,typeName,accessorName)


   
#endif
