/// 日志能力：以 mixin 形式提供，可混入任意类复用。
mixin Logger {
  /// 日志标签，默认取运行时的类型名，混入方可覆盖
  String get logTag => runtimeType.toString();

  /// 输出一条带标签的日志
  void log(String message) {
    print('[$logTag] $message');
  }
}
