/*
 * Copyright (C) 2010- Peer internet solutions
 *
 * This file is part of mixare.
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>
 */
//
//  BarcodeInput.m
//  Mixare
//
//  Created by Aswin Ly on 13-11-12.
//

#import "BarcodeInput.h"

@implementation BarcodeInput

- (NSString*)getTitle {
    return @"Barcode Scanner";
}

- (void)runInput:(id<SetDataSource>)classToSetYourData {
    /*aClass = classToSetYourData;
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:reader animated:YES completion:nil];*/
}
/*
- (void) imagePickerController:(UIImagePickerController *) reader didFinishPickingMediaWithInfo:(NSDictionary *)info {
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results) {
        break;
    }
    [aClass setNewData:@{@"title":@"Scanned Source Title", @"url":symbol.data}];
    [reader dismissViewControllerAnimated:YES completion:nil];
}*/

@end
