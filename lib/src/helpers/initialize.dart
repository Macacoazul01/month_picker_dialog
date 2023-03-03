import '/src/helpers/common.dart';
import '/src/helpers/controller.dart';

//Year Selector

void initializeYearSelector(
  MonthpickerController controller,
) {
  Future<void>.delayed(
    Duration.zero,
    () {
      controller.upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          controller.localFirstDate == null
              ? controller.yearPageController.page!.toInt() * 12
              : controller.localFirstDate!.year +
                  controller.yearPageController.page!.toInt() * 12,
          controller.localFirstDate == null
              ? controller.yearPageController.page!.toInt() * 12 + 11
              : controller.localFirstDate!.year +
                  controller.yearPageController.page!.toInt() * 12 +
                  11,
        ),
      );
      controller.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
            controller.yearPageController.page!.toInt() > 0,
            controller.yearPageController.page!.toInt() <
                controller.yearItemCount - 1),
      );
    },
  );
}

//Month Selector

void initializeMonthSelector(
  MonthpickerController controller,
) {
  Future<void>.delayed(
    Duration.zero,
    () {
      controller.upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          controller.localFirstDate == null
              ? controller.monthPageController.page!.toInt()
              : controller.localFirstDate!.year +
                  controller.monthPageController.page!.toInt(),
          0,
        ),
      );
      controller.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
          controller.monthPageController.page!.toInt() > 0,
          controller.monthPageController.page!.toInt() <
              controller.monthPageCount - 1,
        ),
      );
    },
  );
}
