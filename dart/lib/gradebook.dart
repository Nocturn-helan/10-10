import 'student.dart';

/// 成绩册类：内部持有学生列表，构造时接收列表。
class GradeBook {
  final List<Student> _students;

  /// 接收外部列表并复制一份，避免外部修改影响内部数据
  GradeBook(List<Student> students) : _students = List.of(students);

  /// 只读访问内部列表（返回不可修改视图）
  List<Student> get students => List.unmodifiable(_students);
}
