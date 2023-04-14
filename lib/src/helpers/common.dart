///Class that controlls the limit of pages of the up and down arrows
class UpDownPageLimit {
  UpDownPageLimit(this.upLimit, this.downLimit);
  int upLimit;
  int downLimit;
}

///Class that controlls if the up and down arrows are gonna be enabled or not
class UpDownButtonEnableState {
  UpDownButtonEnableState(this.upState, this.downState);
  bool upState;
  bool downState;
}
