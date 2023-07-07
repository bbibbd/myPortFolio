


// double getPaddingValue(double screenWidth){
//   double paddingValue = 12;
//
//   if (screenWidth > 320 && screenWidth <= 375) {
//     paddingValue = 60;
//   } else if (screenWidth > 375 && screenWidth <= 414) {
//     paddingValue = 70;
//   } else if (screenWidth > 414 && screenWidth <= 480) {
//     paddingValue = 80;
//   } else if (screenWidth > 480 && screenWidth <= 540) {
//     paddingValue = 90;
//   } else if (screenWidth > 540 && screenWidth <= 600) {
//     paddingValue = 100;
//   } else if (screenWidth > 600 && screenWidth <= 720) {
//     paddingValue = 200;
//   } else if (screenWidth > 720 && screenWidth <= 840) {
//     paddingValue = 300;
//   } else if (screenWidth > 840 && screenWidth <= 960) {
//     paddingValue = 400;
//   } else if (screenWidth > 960 && screenWidth <= 1080) {
//     paddingValue = 500;
//   } else if (screenWidth > 1080) {
//     paddingValue = 600;
//   }
//
//   return paddingValue;
// }

double getPaddingValue(double screenWidth) {
  double paddingRatio;

  // 스크린 너비가 600 이하인 경우
  if (screenWidth <= 800) {
    return 12; // 10%
  }
  if (screenWidth <= 1280) {
    paddingRatio = 0.1; // 10%
  }
  // 스크린 너비가 600보다 큰 경우
  else if (screenWidth <= 1600){
    paddingRatio = 0.15; // 25%
  }
  else if (screenWidth <= 1920){
    paddingRatio = 0.2; // 25%
  } else{
    paddingRatio = 0.25;
  }

  return screenWidth * paddingRatio;
}

double getPaddingValueOfDetailPage(double screenWidth) {
  double paddingRatio;

  // 스크린 너비가 600 이하인 경우
  if (screenWidth <= 800) {
    return 12;
  }
  if (screenWidth <= 1280) {
    paddingRatio = 0.1; // 10%
  }
  // 스크린 너비가 600보다 큰 경우
  else if (screenWidth <= 1600){
    paddingRatio = 0.15; // 25%
  }
  else if (screenWidth <= 1920){
    paddingRatio = 0.2; // 25%
  } else{
    paddingRatio = 0.25;
  }

  return screenWidth * paddingRatio;

}
//
// double getPaddingValueOfDetailPage(double screenWidth){
//   double paddingValue = 12;
//   if (screenWidth > 320 && screenWidth <= 375) {
//     paddingValue = 12;
//   } else if (screenWidth > 375 && screenWidth <= 414) {
//     paddingValue = 24;
//   } else if (screenWidth > 414 && screenWidth <= 480) {
//     paddingValue = 36;
//   } else if (screenWidth > 480 && screenWidth <= 540) {
//     paddingValue = 48;
//   } else if (screenWidth > 540 && screenWidth <= 600) {
//     paddingValue = 60;
//   } else if (screenWidth > 600 && screenWidth <= 720) {
//     paddingValue = 72;
//   } else if (screenWidth > 720 && screenWidth <= 840) {
//     paddingValue = 84;
//   } else if (screenWidth > 840 && screenWidth <= 960) {
//     paddingValue = 96;
//   } else if (screenWidth > 960 && screenWidth <= 1080) {
//     paddingValue = 108;
//   } else if (screenWidth > 1080) {
//     paddingValue = 120;
//   }
//   return paddingValue;
// }