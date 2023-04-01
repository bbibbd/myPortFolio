


double getPaddingValue(double screenWidth){
  double paddingValue = 12;

  if (screenWidth > 320 && screenWidth <= 375) {
    paddingValue = 12;
  } else if (screenWidth > 375 && screenWidth <= 414) {
    paddingValue = 20;
  } else if (screenWidth > 414 && screenWidth <= 480) {
    paddingValue = 28;
  } else if (screenWidth > 480 && screenWidth <= 540) {
    paddingValue = 36;
  } else if (screenWidth > 540 && screenWidth <= 600) {
    paddingValue = 44;
  } else if (screenWidth > 600 && screenWidth <= 720) {
    paddingValue = 52;
  } else if (screenWidth > 720 && screenWidth <= 840) {
    paddingValue = 60;
  } else if (screenWidth > 840 && screenWidth <= 960) {
    paddingValue = 68;
  } else if (screenWidth > 960 && screenWidth <= 1080) {
    paddingValue = 76;
  } else if (screenWidth > 1080) {
    paddingValue = 84;
  }

  return paddingValue;
}

double getPaddingValueOfDetailPage(double screenWidth){
  double paddingValue = 12;
  if (screenWidth > 320 && screenWidth <= 375) {
    paddingValue = 12;
  } else if (screenWidth > 375 && screenWidth <= 414) {
    paddingValue = 24;
  } else if (screenWidth > 414 && screenWidth <= 480) {
    paddingValue = 36;
  } else if (screenWidth > 480 && screenWidth <= 540) {
    paddingValue = 48;
  } else if (screenWidth > 540 && screenWidth <= 600) {
    paddingValue = 60;
  } else if (screenWidth > 600 && screenWidth <= 720) {
    paddingValue = 72;
  } else if (screenWidth > 720 && screenWidth <= 840) {
    paddingValue = 84;
  } else if (screenWidth > 840 && screenWidth <= 960) {
    paddingValue = 96;
  } else if (screenWidth > 960 && screenWidth <= 1080) {
    paddingValue = 108;
  } else if (screenWidth > 1080) {
    paddingValue = 120;
  }
  return paddingValue;
}