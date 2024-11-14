import 'dart:developer';

import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';

class FetchHotelsUseCase {
  final HotelRepository repository;

  FetchHotelsUseCase(this.repository);

  Future<List<HotelEntity>> call() async {
    log('domain/usecase');
    return await repository.fetchHotels();
  }
}
