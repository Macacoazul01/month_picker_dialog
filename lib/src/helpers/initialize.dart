import 'package:flutter/widgets.dart';

import '/src/helpers/common.dart';
import '/src/helpers/controller.dart';

//Year Selector

void initializeYearSelector(
  PageController? pageController,
  MonthpickerController controller,
) {
  Future<void>.delayed(
    Duration.zero,
    () {
      controller.upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          controller.localFirstDate == null
              ? pageController!.page!.toInt() * 12
              : controller.localFirstDate!.year +
                  pageController!.page!.toInt() * 12,
          controller.localFirstDate == null
              ? pageController.page!.toInt() * 12 + 11
              : controller.localFirstDate!.year +
                  pageController.page!.toInt() * 12 +
                  11,
        ),
      );
      controller.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(pageController.page!.toInt() > 0,
            pageController.page!.toInt() < controller.yearItemCount - 1),
      );
    },
  );
}

//Month Selector

void initializeMonthSelector(
  PageController? pageController,
  MonthpickerController controller,
) {
  Future<void>.delayed(
    Duration.zero,
    () {
      controller.upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          controller.localFirstDate == null
              ? pageController!.page!.toInt()
              : controller.localFirstDate!.year + pageController!.page!.toInt(),
          0,
        ),
      );
      controller.upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
          pageController.page!.toInt() > 0,
          pageController.page!.toInt() < controller.monthPageCount - 1,
        ),
      );
    },
  );
}
