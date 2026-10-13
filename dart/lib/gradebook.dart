import 'logger.dart';
import 'student.dart';

/// 成绩册类：内部持有学生列表，构造时接收列表，并混入日志能力。
///
/// 日志能力通过 `with Logger` 混入，而非 `extends` 某个日志基类；
/// 用 mixin 替代一层继承的理由详见 [Logger] 的文档注释。
class GradeBook with Logger {
  final List<Student> _students;

  /// 接收外部列表并复制一份，避免外部修改影响内部数据
  GradeBook(List<Student> students) : _students = List.of(students);

  /// 只读访问内部列表（返回不可修改视图）
  List<Student> get students => List.unmodifiable(_students);

  /// 平均分；无学生时返回 0
  double average() {
    final value = _students.isEmpty
        ? 0.0
        : _students.map((s) => s.score).reduce((a, b) => a + b) /
            _students.length;
    log('平均分 = ${value.toStringAsFixed(2)}');
    return value;
  }

  /// 最高分学生；无学生时返回 null（并列时取先出现者）
  Student? maxBy() {
    final top = _students.isEmpty
        ? null
        : _students.reduce((a, b) => a.score >= b.score ? a : b);
    log(top == null ? '无学生，最高分为空' : '最高分 = ${top.name} (${top.score})');
    return top;
  }

  /// 及格（成绩 >= 60）人数
  int countPassed() {
    final count = _students.where((s) => s.score >= 60).length;
    log('及格人数 = $count');
    return count;
  }

  /// 及格学生的分档人数汇总，返回形如 `优=1，良=1，中=1` 的字符串。
  ///
  /// 单条链式调用完成"一组统计"：`where → map → fold → entries → map → toList → join`。
  String passedTierSummary() {
    final summary = _students
        .where((s) => s.score >= 60) // 1. 过滤及格学生
        .map((s) => _tierOf(s.score)) // 2. 映射到分档标签
        .fold<Map<String, int>>( // 3. 聚合计数
          <String, int>{},
          (counts, tier) =>
              counts..update(tier, (v) => v + 1, ifAbsent: () => 1),
        )
        .entries // 4. 转为条目集合
        .map((e) => '${e.key}=${e.value}') // 5. 格式化为 "标签=人数"
        .toList() // 6. 收成列表
        .join('，'); // 7. 拼接成串
    log('及格分档汇总 = $summary');
    return summary;
  }

  /// 按优良中分档：优(>=90)、良(80~89)、中(60~79)；低于 60 归入"不及格"
  Map<String, List<Student>> groupByGrade() {
    final grouped = _students.fold(
      <String, List<Student>>{'优': [], '良': [], '中': [], '不及格': []},
      (map, student) {
        map[_tierOf(student.score)]!.add(student);
        return map;
      },
    );
    log('分档统计 = ${grouped.map((k, v) => MapEntry(k, v.length))}');
    return grouped;
  }

  String _tierOf(double score) => switch (score) {
        >= 90 => '优',
        >= 80 => '良',
        >= 60 => '中',
        _ => '不及格',
      };
}
