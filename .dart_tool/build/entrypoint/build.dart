// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:freezed/builder.dart' as _i2;
import 'package:json_serializable/builder.dart' as _i3;
import 'package:mockito/src/builder.dart' as _i4;
import 'package:source_gen/builder.dart' as _i5;
import 'package:stacked_generator/builder.dart' as _i6;
import 'dart:isolate' as _i7;
import 'package:build_runner/build_runner.dart' as _i8;
import 'dart:io' as _i9;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'freezed:freezed',
    [_i2.freezed],
    _i1.toDependentsOf(r'freezed'),
    hideOutput: false,
  ),
  _i1.apply(
    r'json_serializable:json_serializable',
    [_i3.jsonSerializable],
    _i1.toDependentsOf(r'json_serializable'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'mockito:mockBuilder',
    [_i4.buildMocks],
    _i1.toDependentsOf(r'mockito'),
    hideOutput: false,
  ),
  _i1.apply(
    r'source_gen:combining_builder',
    [_i5.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.apply(
    r'stacked_generator:stackedBottomsheetGenerator',
    [_i6.stackedBottomsheetGenerator],
    _i1.toDependentsOf(r'stacked_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'stacked_generator:stackedDialogGenerator',
    [_i6.stackedDialogGenerator],
    _i1.toDependentsOf(r'stacked_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'stacked_generator:stackedFormGenerator',
    [_i6.stackedFormGenerator],
    _i1.toDependentsOf(r'stacked_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'stacked_generator:stackedLocatorGenerator',
    [_i6.stackedLocatorGenerator],
    _i1.toDependentsOf(r'stacked_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'stacked_generator:stackedLoggerGenerator',
    [_i6.stackedLoggerGenerator],
    _i1.toDependentsOf(r'stacked_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'stacked_generator:stackedRouterGenerator',
    [_i6.stackedRouterGenerator],
    _i1.toDependentsOf(r'stacked_generator'),
    hideOutput: false,
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i5.partCleanup,
  ),
];
void main(
  List<String> args, [
  _i7.SendPort? sendPort,
]) async {
  var result = await _i8.run(
    args,
    _builders,
  );
  sendPort?.send(result);
  _i9.exitCode = result;
}
