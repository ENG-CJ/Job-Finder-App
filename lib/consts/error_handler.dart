import 'package:fpdart/fpdart.dart';
import 'package:job_finder/modals/Errors/error_modal.dart';

typedef EitherHandler<T> = Future<Either<ErrorGetter, T?>?>;
