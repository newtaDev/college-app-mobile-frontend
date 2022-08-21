part of app_utils;

String mapPropsToString(Type runtimeType, List<Object?> props) =>
    '\n$runtimeType(${props.map((prop) => prop.toString()).join(', ')})';

class MyEquatable extends Equatable {
  const MyEquatable();

  @override
  List<Object?> get props =>
      throw Exception('Implement Equatable Props in $runtimeType');

  @override
  String toString() {
    return mapPropsToString(runtimeType, props);
  }
}
