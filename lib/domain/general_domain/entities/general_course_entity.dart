class GeneralCourseEntity {
  final String uniId;
  final String programId;
  final String name;
  final int ects;
  final String field;
  final String id;

  GeneralCourseEntity(
      {required this.uniId,
      required this.programId,
      required this.name,
      required this.ects,
      required this.field,
      required this.id});
}