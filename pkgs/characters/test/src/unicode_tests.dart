// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:characters/src/grapheme_clusters/constants.dart";
import 'package:characters/src/grapheme_clusters/table.dart';

export "unicode_grapheme_tests.dart";

/// Readable description of the [expected] grapheme clusters.
///
/// The list of strings is the expected grapheme cluster separation
/// of the concatenation of those strings.
///
/// The description converts each code unit to a 4-digit hex number,
/// puts ` × ` between the code units of the same grapheme cluster
/// and ` ÷ ` before, after and between the grapheme clusters.
/// (This is the format of the original Unicode test data, so it
/// can be compared to the original tests.)
String testDescription(List<String> expected) {
  var expectedString = expected
      .map((s) =>
          s.runes.map((x) => x.toRadixString(16).padLeft(4, "0")).join(" × "))
      .join(" ÷ ");
  return "÷ $expectedString ÷";
}

int _category(int codePoint) {
  if (codePoint < 0x10000) return low(codePoint);
  return high((codePoint - 0x10000) >> 10, codePoint & 0x3ff);
}

String partCategories(List<String> parts) {
  return parts.map((part) {
    return part.runes.map((n) => categoryName[_category(n)]).join(" × ");
  }).join(" ÷ ");
}

final List<String> categoryName = List<String>.filled(categoryCount, "")
  ..[categoryOther] = "Other"
  ..[categoryCR] = "CR"
  ..[categoryLF] = "LF"
  ..[categoryControl] = "Control"
  ..[categoryExtend] = "Extend"
  ..[categoryZWJ] = "ZWJ"
  ..[categoryRegionalIndicator] = "RI"
  ..[categoryPrepend] = "Prepend"
  ..[categorySpacingMark] = "SpacingMark"
  ..[categoryL] = "L"
  ..[categoryV] = "V"
  ..[categoryT] = "T"
  ..[categoryLV] = "LV"
  ..[categoryLVT] = "LVT"
  ..[categoryPictographic] = "Pictographic"
  ..[categoryOtherIndicConsonant] = "Other{InCB=Consonant}"
  ..[categoryExtendIndicExtend] = "Extend{InCB=Extend}"
  ..[categoryExtendIndicLinked] = "Extend{InCB=Linked}"
  ..[categoryEoT] = "EoT";
