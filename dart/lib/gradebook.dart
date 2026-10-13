import 'student.dart';

/// 成绩册类：内部持有学生列表，构造时接收列表。
class GradeBook {
  final List<Student> _students;

  /// 接收外部列表并复制一份，避免外部修改影响内部数据
  GradeBook(List<Student> students) : _students = List.of(students);

  /// 只读访问内部列表（返回不可修改视图）
  List<Student> get students => List.unmodifiable(_students);

  /// 平均分；无学生时返回 0
  double average() => _students.isEmpty
      ? 0
      : _students.map((s) => s.score).reduce((a, b) => a + b) /
          _students.length;

  /// 最高分学生；无学生时返回 null（并列时取先出现者）
  Student? maxBy() => _students.isEmpty
      ? null
      : _students.reduce((a, b) => a.score >= b.score ? a : b);

  /// 及格（成绩 >= 60）人数
  int countPassed() => _students.where((s) => s.score >= 60).length;

  /// 按优良中分档：优(>=90)、良(80~89)、中(60~79)；低于 60 归入"不及格"
  Map<String, List<Student>> groupByGrade() => _students.fold(
        <String, List<Student>>{'优': [], '良': [], '中': [], '不及格': []},
        (map, student) {
          map[_tierOf(student.score)]!.add(student);
          return map;
        },
      );

  String _tierOf(double score) => switch (score) {
        >= 90 => '优',
        >= 80 => '良',
        >= 60 => '中',
        _ => '不及格',
      };
}
