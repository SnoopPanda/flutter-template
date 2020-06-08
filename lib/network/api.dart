
import 'package:my_flutter_template/network/target_type.dart';

class APIs {

  APIs._();

  static TargetType fetchChannel = TargetType().config(
      path: "/j/app/radio/channels",
      method: HTTPMethod.GET,
      encoding: ParameterEncoding.URLEncoding
  );
}