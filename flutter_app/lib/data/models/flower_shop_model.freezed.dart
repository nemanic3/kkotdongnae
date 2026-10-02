// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flower_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FlowerShopModel _$FlowerShopModelFromJson(Map<String, dynamic> json) {
  return _FlowerShopModel.fromJson(json);
}

/// @nodoc
mixin _$FlowerShopModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get addressDetail => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get instagram => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'opening_hours')
  Map<String, String>? get openingHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open_now')
  bool get isOpenNow => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_range')
  int get priceRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rating')
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_count')
  int get reviewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'favorite_count')
  int get favoriteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_meters')
  double? get distanceMeters => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_photo_url')
  String? get primaryPhotoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FlowerShopModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlowerShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlowerShopModelCopyWith<FlowerShopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowerShopModelCopyWith<$Res> {
  factory $FlowerShopModelCopyWith(
    FlowerShopModel value,
    $Res Function(FlowerShopModel) then,
  ) = _$FlowerShopModelCopyWithImpl<$Res, FlowerShopModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String address,
    String? addressDetail,
    String? phone,
    String? website,
    String? instagram,
    double latitude,
    double longitude,
    @JsonKey(name: 'opening_hours') Map<String, String>? openingHours,
    @JsonKey(name: 'is_open_now') bool isOpenNow,
    @JsonKey(name: 'price_range') int priceRange,
    @JsonKey(name: 'average_rating') double averageRating,
    @JsonKey(name: 'review_count') int reviewCount,
    @JsonKey(name: 'favorite_count') int favoriteCount,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'distance_meters') double? distanceMeters,
    @JsonKey(name: 'primary_photo_url') String? primaryPhotoUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$FlowerShopModelCopyWithImpl<$Res, $Val extends FlowerShopModel>
    implements $FlowerShopModelCopyWith<$Res> {
  _$FlowerShopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlowerShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? address = null,
    Object? addressDetail = freezed,
    Object? phone = freezed,
    Object? website = freezed,
    Object? instagram = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? openingHours = freezed,
    Object? isOpenNow = null,
    Object? priceRange = null,
    Object? averageRating = null,
    Object? reviewCount = null,
    Object? favoriteCount = null,
    Object? isVerified = null,
    Object? isActive = null,
    Object? distanceMeters = freezed,
    Object? primaryPhotoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            addressDetail: freezed == addressDetail
                ? _value.addressDetail
                : addressDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            instagram: freezed == instagram
                ? _value.instagram
                : instagram // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            openingHours: freezed == openingHours
                ? _value.openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            isOpenNow: null == isOpenNow
                ? _value.isOpenNow
                : isOpenNow // ignore: cast_nullable_to_non_nullable
                      as bool,
            priceRange: null == priceRange
                ? _value.priceRange
                : priceRange // ignore: cast_nullable_to_non_nullable
                      as int,
            averageRating: null == averageRating
                ? _value.averageRating
                : averageRating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            favoriteCount: null == favoriteCount
                ? _value.favoriteCount
                : favoriteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            distanceMeters: freezed == distanceMeters
                ? _value.distanceMeters
                : distanceMeters // ignore: cast_nullable_to_non_nullable
                      as double?,
            primaryPhotoUrl: freezed == primaryPhotoUrl
                ? _value.primaryPhotoUrl
                : primaryPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlowerShopModelImplCopyWith<$Res>
    implements $FlowerShopModelCopyWith<$Res> {
  factory _$$FlowerShopModelImplCopyWith(
    _$FlowerShopModelImpl value,
    $Res Function(_$FlowerShopModelImpl) then,
  ) = __$$FlowerShopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String address,
    String? addressDetail,
    String? phone,
    String? website,
    String? instagram,
    double latitude,
    double longitude,
    @JsonKey(name: 'opening_hours') Map<String, String>? openingHours,
    @JsonKey(name: 'is_open_now') bool isOpenNow,
    @JsonKey(name: 'price_range') int priceRange,
    @JsonKey(name: 'average_rating') double averageRating,
    @JsonKey(name: 'review_count') int reviewCount,
    @JsonKey(name: 'favorite_count') int favoriteCount,
    @JsonKey(name: 'is_verified') bool isVerified,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'distance_meters') double? distanceMeters,
    @JsonKey(name: 'primary_photo_url') String? primaryPhotoUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$FlowerShopModelImplCopyWithImpl<$Res>
    extends _$FlowerShopModelCopyWithImpl<$Res, _$FlowerShopModelImpl>
    implements _$$FlowerShopModelImplCopyWith<$Res> {
  __$$FlowerShopModelImplCopyWithImpl(
    _$FlowerShopModelImpl _value,
    $Res Function(_$FlowerShopModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlowerShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? address = null,
    Object? addressDetail = freezed,
    Object? phone = freezed,
    Object? website = freezed,
    Object? instagram = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? openingHours = freezed,
    Object? isOpenNow = null,
    Object? priceRange = null,
    Object? averageRating = null,
    Object? reviewCount = null,
    Object? favoriteCount = null,
    Object? isVerified = null,
    Object? isActive = null,
    Object? distanceMeters = freezed,
    Object? primaryPhotoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$FlowerShopModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        addressDetail: freezed == addressDetail
            ? _value.addressDetail
            : addressDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        instagram: freezed == instagram
            ? _value.instagram
            : instagram // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        openingHours: freezed == openingHours
            ? _value._openingHours
            : openingHours // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        isOpenNow: null == isOpenNow
            ? _value.isOpenNow
            : isOpenNow // ignore: cast_nullable_to_non_nullable
                  as bool,
        priceRange: null == priceRange
            ? _value.priceRange
            : priceRange // ignore: cast_nullable_to_non_nullable
                  as int,
        averageRating: null == averageRating
            ? _value.averageRating
            : averageRating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        favoriteCount: null == favoriteCount
            ? _value.favoriteCount
            : favoriteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        distanceMeters: freezed == distanceMeters
            ? _value.distanceMeters
            : distanceMeters // ignore: cast_nullable_to_non_nullable
                  as double?,
        primaryPhotoUrl: freezed == primaryPhotoUrl
            ? _value.primaryPhotoUrl
            : primaryPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlowerShopModelImpl implements _FlowerShopModel {
  const _$FlowerShopModelImpl({
    required this.id,
    required this.name,
    this.description,
    required this.address,
    this.addressDetail,
    this.phone,
    this.website,
    this.instagram,
    required this.latitude,
    required this.longitude,
    @JsonKey(name: 'opening_hours') final Map<String, String>? openingHours,
    @JsonKey(name: 'is_open_now') this.isOpenNow = true,
    @JsonKey(name: 'price_range') this.priceRange = 2,
    @JsonKey(name: 'average_rating') this.averageRating = 0.0,
    @JsonKey(name: 'review_count') this.reviewCount = 0,
    @JsonKey(name: 'favorite_count') this.favoriteCount = 0,
    @JsonKey(name: 'is_verified') this.isVerified = false,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'distance_meters') this.distanceMeters,
    @JsonKey(name: 'primary_photo_url') this.primaryPhotoUrl,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _openingHours = openingHours;

  factory _$FlowerShopModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlowerShopModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String address;
  @override
  final String? addressDetail;
  @override
  final String? phone;
  @override
  final String? website;
  @override
  final String? instagram;
  @override
  final double latitude;
  @override
  final double longitude;
  final Map<String, String>? _openingHours;
  @override
  @JsonKey(name: 'opening_hours')
  Map<String, String>? get openingHours {
    final value = _openingHours;
    if (value == null) return null;
    if (_openingHours is EqualUnmodifiableMapView) return _openingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'is_open_now')
  final bool isOpenNow;
  @override
  @JsonKey(name: 'price_range')
  final int priceRange;
  @override
  @JsonKey(name: 'average_rating')
  final double averageRating;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @override
  @JsonKey(name: 'favorite_count')
  final int favoriteCount;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'distance_meters')
  final double? distanceMeters;
  @override
  @JsonKey(name: 'primary_photo_url')
  final String? primaryPhotoUrl;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FlowerShopModel(id: $id, name: $name, description: $description, address: $address, addressDetail: $addressDetail, phone: $phone, website: $website, instagram: $instagram, latitude: $latitude, longitude: $longitude, openingHours: $openingHours, isOpenNow: $isOpenNow, priceRange: $priceRange, averageRating: $averageRating, reviewCount: $reviewCount, favoriteCount: $favoriteCount, isVerified: $isVerified, isActive: $isActive, distanceMeters: $distanceMeters, primaryPhotoUrl: $primaryPhotoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowerShopModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.addressDetail, addressDetail) ||
                other.addressDetail == addressDetail) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.instagram, instagram) ||
                other.instagram == instagram) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(
              other._openingHours,
              _openingHours,
            ) &&
            (identical(other.isOpenNow, isOpenNow) ||
                other.isOpenNow == isOpenNow) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.favoriteCount, favoriteCount) ||
                other.favoriteCount == favoriteCount) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.primaryPhotoUrl, primaryPhotoUrl) ||
                other.primaryPhotoUrl == primaryPhotoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    description,
    address,
    addressDetail,
    phone,
    website,
    instagram,
    latitude,
    longitude,
    const DeepCollectionEquality().hash(_openingHours),
    isOpenNow,
    priceRange,
    averageRating,
    reviewCount,
    favoriteCount,
    isVerified,
    isActive,
    distanceMeters,
    primaryPhotoUrl,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of FlowerShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowerShopModelImplCopyWith<_$FlowerShopModelImpl> get copyWith =>
      __$$FlowerShopModelImplCopyWithImpl<_$FlowerShopModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FlowerShopModelImplToJson(this);
  }
}

abstract class _FlowerShopModel implements FlowerShopModel {
  const factory _FlowerShopModel({
    required final String id,
    required final String name,
    final String? description,
    required final String address,
    final String? addressDetail,
    final String? phone,
    final String? website,
    final String? instagram,
    required final double latitude,
    required final double longitude,
    @JsonKey(name: 'opening_hours') final Map<String, String>? openingHours,
    @JsonKey(name: 'is_open_now') final bool isOpenNow,
    @JsonKey(name: 'price_range') final int priceRange,
    @JsonKey(name: 'average_rating') final double averageRating,
    @JsonKey(name: 'review_count') final int reviewCount,
    @JsonKey(name: 'favorite_count') final int favoriteCount,
    @JsonKey(name: 'is_verified') final bool isVerified,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'distance_meters') final double? distanceMeters,
    @JsonKey(name: 'primary_photo_url') final String? primaryPhotoUrl,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$FlowerShopModelImpl;

  factory _FlowerShopModel.fromJson(Map<String, dynamic> json) =
      _$FlowerShopModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get address;
  @override
  String? get addressDetail;
  @override
  String? get phone;
  @override
  String? get website;
  @override
  String? get instagram;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(name: 'opening_hours')
  Map<String, String>? get openingHours;
  @override
  @JsonKey(name: 'is_open_now')
  bool get isOpenNow;
  @override
  @JsonKey(name: 'price_range')
  int get priceRange;
  @override
  @JsonKey(name: 'average_rating')
  double get averageRating;
  @override
  @JsonKey(name: 'review_count')
  int get reviewCount;
  @override
  @JsonKey(name: 'favorite_count')
  int get favoriteCount;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'distance_meters')
  double? get distanceMeters;
  @override
  @JsonKey(name: 'primary_photo_url')
  String? get primaryPhotoUrl;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of FlowerShopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlowerShopModelImplCopyWith<_$FlowerShopModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopPhotoModel _$ShopPhotoModelFromJson(Map<String, dynamic> json) {
  return _ShopPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$ShopPhotoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_id')
  String get shopId => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_primary')
  bool get isPrimary => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ShopPhotoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopPhotoModelCopyWith<ShopPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopPhotoModelCopyWith<$Res> {
  factory $ShopPhotoModelCopyWith(
    ShopPhotoModel value,
    $Res Function(ShopPhotoModel) then,
  ) = _$ShopPhotoModelCopyWithImpl<$Res, ShopPhotoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'shop_id') String shopId,
    String url,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? caption,
    @JsonKey(name: 'is_primary') bool isPrimary,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$ShopPhotoModelCopyWithImpl<$Res, $Val extends ShopPhotoModel>
    implements $ShopPhotoModelCopyWith<$Res> {
  _$ShopPhotoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopId = null,
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? caption = freezed,
    Object? isPrimary = null,
    Object? sortOrder = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            shopId: null == shopId
                ? _value.shopId
                : shopId // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            caption: freezed == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPrimary: null == isPrimary
                ? _value.isPrimary
                : isPrimary // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShopPhotoModelImplCopyWith<$Res>
    implements $ShopPhotoModelCopyWith<$Res> {
  factory _$$ShopPhotoModelImplCopyWith(
    _$ShopPhotoModelImpl value,
    $Res Function(_$ShopPhotoModelImpl) then,
  ) = __$$ShopPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'shop_id') String shopId,
    String url,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    String? caption,
    @JsonKey(name: 'is_primary') bool isPrimary,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$ShopPhotoModelImplCopyWithImpl<$Res>
    extends _$ShopPhotoModelCopyWithImpl<$Res, _$ShopPhotoModelImpl>
    implements _$$ShopPhotoModelImplCopyWith<$Res> {
  __$$ShopPhotoModelImplCopyWithImpl(
    _$ShopPhotoModelImpl _value,
    $Res Function(_$ShopPhotoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopId = null,
    Object? url = null,
    Object? thumbnailUrl = freezed,
    Object? caption = freezed,
    Object? isPrimary = null,
    Object? sortOrder = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ShopPhotoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        shopId: null == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPrimary: null == isPrimary
            ? _value.isPrimary
            : isPrimary // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopPhotoModelImpl implements _ShopPhotoModel {
  const _$ShopPhotoModelImpl({
    required this.id,
    @JsonKey(name: 'shop_id') required this.shopId,
    required this.url,
    @JsonKey(name: 'thumbnail_url') this.thumbnailUrl,
    this.caption,
    @JsonKey(name: 'is_primary') this.isPrimary = false,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$ShopPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopPhotoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'shop_id')
  final String shopId;
  @override
  final String url;
  @override
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @override
  final String? caption;
  @override
  @JsonKey(name: 'is_primary')
  final bool isPrimary;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ShopPhotoModel(id: $id, shopId: $shopId, url: $url, thumbnailUrl: $thumbnailUrl, caption: $caption, isPrimary: $isPrimary, sortOrder: $sortOrder, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopPhotoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    shopId,
    url,
    thumbnailUrl,
    caption,
    isPrimary,
    sortOrder,
    createdAt,
  );

  /// Create a copy of ShopPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopPhotoModelImplCopyWith<_$ShopPhotoModelImpl> get copyWith =>
      __$$ShopPhotoModelImplCopyWithImpl<_$ShopPhotoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopPhotoModelImplToJson(this);
  }
}

abstract class _ShopPhotoModel implements ShopPhotoModel {
  const factory _ShopPhotoModel({
    required final String id,
    @JsonKey(name: 'shop_id') required final String shopId,
    required final String url,
    @JsonKey(name: 'thumbnail_url') final String? thumbnailUrl,
    final String? caption,
    @JsonKey(name: 'is_primary') final bool isPrimary,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$ShopPhotoModelImpl;

  factory _ShopPhotoModel.fromJson(Map<String, dynamic> json) =
      _$ShopPhotoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'shop_id')
  String get shopId;
  @override
  String get url;
  @override
  @JsonKey(name: 'thumbnail_url')
  String? get thumbnailUrl;
  @override
  String? get caption;
  @override
  @JsonKey(name: 'is_primary')
  bool get isPrimary;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of ShopPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopPhotoModelImplCopyWith<_$ShopPhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
