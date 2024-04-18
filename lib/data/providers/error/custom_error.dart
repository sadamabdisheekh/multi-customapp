import 'package:equatable/equatable.dart';

class CustomError extends Equatable{
 final int statusCode;
  final String message;

  const CustomError({required this.statusCode, required this.message});
  
  @override
  List<Object?> get props => [statusCode,message];
}