// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8404562337274385/2392531295';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8404562337274385/2392531295';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8404562337274385/9721871376';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8404562337274385/9721871376';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8404562337274385/9926324811';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8404562337274385/9926324811';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
