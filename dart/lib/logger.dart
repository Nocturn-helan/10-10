/// 日志能力：以 mixin 形式提供，可混入任意类复用。
///
/// 为什么用「混入」替代「一层继承」？
/// - 若把日志做成基类 `abstract class Loggable`，GradeBook 只能 `extends Loggable`。
///   但 Dart 是单继承，这一层基类会占掉唯一的继承名额，GradeBook 便无法再继承其他
///   更有价值的基类。
/// - 日志表达的是「具备某种能力」（can-do），并非「是一种」（is-a）的父子关系，
///   用继承在语义上也不成立，容易造成继承链膨胀。
/// - `mixin` 通过 `with` 混入，既不占用继承位，又能被任意多个互不相关的类复用；
///   因此这里用 `mixin Logger` + `class GradeBook with Logger` 替代「继承基类」的写法。
mixin Logger {
  /// 日志标签，默认取运行时的类型名，混入方可覆盖
  String get logTag => runtimeType.toString();

  /// 输出一条带标签的日志
  void log(String message) {
    print('[$logTag] $message');
  }
}
