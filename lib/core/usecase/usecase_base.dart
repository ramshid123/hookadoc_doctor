import 'package:fpdart/fpdart.dart';
import 'package:hookadoc_server/core/exception/exception.dart';
import 'package:hookadoc_server/core/exception/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<kFailure, SuccessType>> call(Params params);
}

class NoParams {
  const NoParams();
}
