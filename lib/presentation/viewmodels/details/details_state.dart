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

