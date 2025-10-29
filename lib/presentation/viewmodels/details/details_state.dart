import 'package:equatable/equatable.dart';

abstract class DetailsState extends Equatable{
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState{}

class DetailsLoaded extends DetailsState{
  final bool isSaved;

  const DetailsLoaded({required this.isSaved});

  @override
  List<Object> get props => [isSaved];
}

class DetailsActionFailure extends DetailsLoaded {
  final String message;

  const DetailsActionFailure({
    required this.message,
    required super.isSaved, 
  });

  @override
  List<Object> get props => [message, isSaved];
}

