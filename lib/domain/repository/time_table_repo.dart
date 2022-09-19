import '../../data/models/response/class_time_table_res.dart';

abstract class TimeTableRepository {
  Future<ClassTimeTableRes> getClassTimeTableForStudent(String classId);
  Future<ClassTimeTableRes> getClassTimeTableForTeacher(String teacherId);
}
