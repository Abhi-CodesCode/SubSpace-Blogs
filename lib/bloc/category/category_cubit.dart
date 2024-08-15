import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class CategoryCubit extends Cubit<int> {
  CategoryCubit() : super(0);

  void selectCategory(int index) => emit(index);
}

