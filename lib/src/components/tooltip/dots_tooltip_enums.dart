enum DotsToolTipTailPosition {
  topAlignLeadingEdge,
  topAlignLeading,
  topAlignCenter,
  topAlignTrailing,
  topAlignTrailingEdge,
  bottomAlignLeadingEdge,
  bottomAlignLeading,
  bottomAlignCenter,
  bottomAlignTrailing,
  bottomAlignTrailingEdge;

  bool get isTop {
    return this == topAlignLeadingEdge ||
        this == topAlignLeading ||
        this == topAlignCenter ||
        this == topAlignTrailing ||
        this == topAlignTrailingEdge;
  }

  bool get isBottom {
    return this == bottomAlignLeadingEdge ||
        this == bottomAlignLeading ||
        this == bottomAlignCenter ||
        this == bottomAlignTrailing ||
        this == bottomAlignTrailingEdge;
  }

  bool get isCenter {
    return this == topAlignCenter || this == bottomAlignCenter;
  }

  bool get isLeft {
    switch (this) {
      case DotsToolTipTailPosition.bottomAlignLeadingEdge:
      case DotsToolTipTailPosition.topAlignLeadingEdge:
      case DotsToolTipTailPosition.bottomAlignLeading:
      case DotsToolTipTailPosition.topAlignLeading:
        return true;
      case DotsToolTipTailPosition.bottomAlignTrailingEdge:
      case DotsToolTipTailPosition.topAlignTrailingEdge:
      case DotsToolTipTailPosition.topAlignTrailing:
      case DotsToolTipTailPosition.bottomAlignTrailing:
        return false;
      case DotsToolTipTailPosition.bottomAlignCenter:
      case DotsToolTipTailPosition.topAlignCenter:
        return true;
    }
  }

  bool get isRight {
    switch (this) {
      case DotsToolTipTailPosition.bottomAlignLeadingEdge:
      case DotsToolTipTailPosition.topAlignLeadingEdge:
      case DotsToolTipTailPosition.bottomAlignLeading:
      case DotsToolTipTailPosition.topAlignLeading:
        return false;
      case DotsToolTipTailPosition.bottomAlignTrailingEdge:
      case DotsToolTipTailPosition.topAlignTrailingEdge:
      case DotsToolTipTailPosition.topAlignTrailing:
      case DotsToolTipTailPosition.bottomAlignTrailing:
        return true;
      case DotsToolTipTailPosition.bottomAlignCenter:
      case DotsToolTipTailPosition.topAlignCenter:
        return true;
    }
  }
}
