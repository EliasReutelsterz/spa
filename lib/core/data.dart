import 'package:flutter/material.dart';

class Data {
  List<DropdownMenuItem> getSemesterListAsDropDownItems() {
    List<String> semesters = [
      "HWS 2017",
      "FSS 2018",
      "HWS 2018",
      "FSS 2019",
      "HWS 2019",
      "FSS 2020",
      "HWS 2020",
      "FSS 2021",
      "HWS 2021",
      "FSS 2022",
      "HWS 2022",
      "FSS 2023",
      "HWS 2023",
      "FSS 2024",
      "HWS 2024",
      "FSS 2025",
      "HWS 2025",
      "FSS 2026",
      "HWS 2026",
      "FSS 2027",
      "HWS 2027"
    ];
    List<DropdownMenuItem> dropDownItemList = [];
    for (String semester in semesters) {
      dropDownItemList
          .add(DropdownMenuItem(value: semester, child: Text(semester)));
    }
    return dropDownItemList;
  }
}
