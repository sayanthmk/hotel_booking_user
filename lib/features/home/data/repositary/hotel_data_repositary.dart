import 'dart:developer';

import 'package:hotel_booking/features/home/data/datasourse/hotel_remote_datasourse.dart';
import 'package:hotel_booking/features/home/domain/entity/hotel_entity.dart';
import 'package:hotel_booking/features/home/domain/repos/hotel_domain_repositary.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;

  HotelRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<HotelEntity>> fetchHotels() async {
    log('data/repo');
    return await remoteDataSource.fetchHotels();
  }
}
