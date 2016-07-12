/* Copyright (c) 2010 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

#if MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_5

//
// URI Template
//
// http://tools.ietf.org/html/draft-gregorio-uritemplate-04
//
// NOTE: This implemention is only a subset of the spec.  It should be able
// to parse any template that matches the spec, but if the template makes use
// of a feature that is not supported, it will fail with an error.
//

@interface GTMURITemplate : NSObject

// Process the template.  If the template uses an unsupported feature, it will
// throw an exception to help catch that limitation.  Currently unsupported
// feature is partial result modifiers (prefix/suffix).
//
// valueProvider should be anything that implements -objectForKey:.  At the
// simplest level, this can be an NSDictionary.  However, a custom class that
// implements valueForKey may be better for some uses (like if the values
// are coming out of some other structure).
+ (NSString *)expandTemplate:(NSString *)uriTemplate values:(id)valueProvider;

@end

#endif  // MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_5
