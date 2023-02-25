import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';

import '/src/helpers/common.dart';

//Year Selector

void initializeYearSelector(
    PageController? pageController,
    DateTime? firstDate,
    DateTime? lastDate,
    PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject,
    PublishSubject<UpDownButtonEnableState>
        upDownButtonEnableStatePublishSubject) {
  Future<void>.delayed(
    Duration.zero,
    () {
      upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          firstDate == null
              ? pageController!.page!.toInt() * 12
              : firstDate.year + pageController!.page!.toInt() * 12,
          firstDate == null
              ? pageController.page!.toInt() * 12 + 11
              : firstDate.year + pageController.page!.toInt() * 12 + 11,
        ),
      );
      upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
            pageController.page!.toInt() > 0,
            pageController.page!.toInt() <
                getYearItemCount(firstDate, lastDate) - 1),
      );
    },
  );
}

int getYearPageCount(DateTime? firstDate, DateTime? lastDate) {
  if (firstDate != null && lastDate != null) {
    if (lastDate.year - firstDate.year <= 12)
      return 1;
    else
      return ((lastDate.year - firstDate.year + 1) / 12).ceil();
  } else if (firstDate != null && lastDate == null) {
    return (getYearItemCount(firstDate, lastDate) / 12).ceil();
  } else if (firstDate == null && lastDate != null) {
    return (getYearItemCount(firstDate, lastDate) / 12).ceil();
  } else
    return (9999 / 12).ceil();
}

int getYearItemCount(DateTime? firstDate, DateTime? lastDate) {
  if (firstDate != null && lastDate != null) {
    return lastDate.year - firstDate.year + 1;
  } else if (firstDate != null && lastDate == null) {
    return 9999 - firstDate.year;
  } else if (firstDate == null && lastDate != null) {
    return lastDate.year;
  } else
    return 9999;
}

//Month Selector

void initializeMonthSelector(
    PageController? pageController,
    DateTime? firstDate,
    DateTime? lastDate,
    PublishSubject<UpDownPageLimit> upDownPageLimitPublishSubject,
    PublishSubject<UpDownButtonEnableState>
        upDownButtonEnableStatePublishSubject) {
  Future<void>.delayed(
    Duration.zero,
    () {
      upDownPageLimitPublishSubject.add(
        UpDownPageLimit(
          firstDate == null
              ? pageController!.page!.toInt()
              : firstDate.year + pageController!.page!.toInt(),
          0,
        ),
      );
      upDownButtonEnableStatePublishSubject.add(
        UpDownButtonEnableState(
          pageController.page!.toInt() > 0,
          pageController.page!.toInt() < getMonthPageCount(firstDate, lastDate) - 1,
        ),
      );
    },
  );
}

int getMonthPageCount(DateTime? firstDate, DateTime? lastDate) {
  if (firstDate != null && lastDate != null) {
    return lastDate.year - firstDate.year + 1;
  } else if (firstDate != null && lastDate == null) {
    return 9999 - firstDate.year;
  } else if (firstDate == null && lastDate != null) {
    return lastDate.year + 1;
  } else
    return 9999;
}
