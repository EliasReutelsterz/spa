class AddCourseValidators {
  late double grade;
  late String semester;

  String? validate_grade(String? input) {
    if (input == null || input.isEmpty) {
      return "please enter your grade";
    } else {
      input = input.replaceAll(",", ".");
      input = input.replaceAll(" ", "");
      try {
        double inputAsDouble = double.parse(input);
        if (inputAsDouble <= 0) {
          return "I´ve never seen a grade <= 0";
        } else {
          grade = inputAsDouble;
          return null;
        }
      } catch (e) {
        return "Please use format 'x.y'";
      }
    }
  }

  String? validate_semester(dynamic input) {
    if (input == null || input.isEmpty) {
      return "please enter the semester";
    } else {
      semester = input as String;
      return null;
    }
  }
}
