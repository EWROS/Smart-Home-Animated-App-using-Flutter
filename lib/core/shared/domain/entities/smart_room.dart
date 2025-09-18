import 'package:smart_home_animation/core/shared/domain/entities/smart_device.dart';

import 'music_info.dart';

class SmartRoom {
  SmartRoom({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.urunSayisi,
    required this.urunText,
    required this.lights,
    required this.airCondition,
    required this.timer,
    required this.musicInfo,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String urunSayisi;
  final String urunText;
  final SmartDevice lights;
  final SmartDevice airCondition;
  final SmartDevice timer;
  final MusicInfo musicInfo;

  SmartRoom copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? urunSayisi,
    String? urunText,
    SmartDevice? lights,
    SmartDevice? airCondition,
    SmartDevice? timer,
    MusicInfo? musicInfo,
  }) =>
      SmartRoom(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        urunSayisi: urunSayisi ?? this.urunSayisi,
        urunText: urunText ?? this.urunText,
        lights: lights ?? this.lights,
        airCondition: airCondition ?? this.airCondition,
        musicInfo: musicInfo ?? this.musicInfo,
        timer: timer ?? this.timer,
      );

  static List<SmartRoom> fakeValues = [
    _room,
    _room.copyWith(id: '1', name: 'SOFA SETS', urunSayisi: '44', urunText: 'Modern tasarımlar, farklı renk', imageUrl: _imagesUrls[0]),
    _room.copyWith(id: '2', name: 'CORNER SOFA SETS', urunSayisi: '4', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[1]),
    _room.copyWith(id: '3', name: 'ARMCHAIRS', urunSayisi: '19', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[2]),
    _room.copyWith(id: '4', name: 'TV UNITS', urunSayisi: '8', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[3]),
    _room.copyWith(id: '5', name: 'DINING ROOM', urunSayisi: '6', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[4]),
    _room.copyWith(id: '6', name: 'CONSOLES', urunSayisi: '76', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[5]),
    _room.copyWith(id: '7', name: 'DINING TABLE', urunSayisi: '26', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[6]),
    _room.copyWith(id: '8', name: 'CHAIRS', urunSayisi: '76', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[7]),
    _room.copyWith(id: '9', name: 'BEDROOM', urunSayisi: '23', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[8]),
    _room.copyWith(id: '10', name: 'COFFEE TABLES', urunSayisi: '10', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[9]),
    _room.copyWith(id: '11', name: 'POUFS', urunSayisi: '10', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[10]),
    _room.copyWith(id: '12', name: 'BOOKSHELF', urunSayisi: '55', urunText: 'Modern tasarımlar, farklı renk seçenekle', imageUrl: _imagesUrls[11]),
  ];
}

final _room = SmartRoom(
  id: '13',
  name: 'ALL COLLECTIONS',
  imageUrl: _imagesUrls[12],
  urunSayisi: '1233',
  urunText: 'Modern tasarımlar, farklı renk seçenekleriyle.',
  lights: SmartDevice(isOn: true, value: 20),
  timer: SmartDevice(isOn: false, value: 20),
  airCondition: SmartDevice(isOn: false, value: 10),
  musicInfo: MusicInfo(
    isOn: false,
    currentSong: Song.defaultSong,
  ),
);

const _imagesUrls = [
  'assets/images/sofa_sets.jpg',
  'assets/images/corner_sofa_sets.jpg',
  'assets/images/armchairs.jpg',
  'assets/images/tv_units.jpg',
  'assets/images/dining_room.jpg',
  'assets/images/consoles.jpg',
  'assets/images/dining_tables.jpg',
  'assets/images/chairs.jpg',
  'assets/images/bedroom.jpg',
  'assets/images/coffee_tables.jpg',
  'assets/images/poufs.jpg',
  'assets/images/bookshelf.jpg',
  'assets/images/all_collections.jpg',
];
