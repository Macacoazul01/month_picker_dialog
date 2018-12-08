#import "MonthPickerDialogPlugin.h"
#import <month_picker_dialog/month_picker_dialog-Swift.h>

@implementation MonthPickerDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMonthPickerDialogPlugin registerWithRegistrar:registrar];
}
@end
