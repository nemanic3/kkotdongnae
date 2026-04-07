// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return _ReviewModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_id')
  String get shopId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  @JsonKey(name: 'helpful_count')
  int get helpfulCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_visible')
  bool get isVisible => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError; // Joined user data
  UserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewModelCopyWith<ReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewModelCopyWith<$Res> {
  factory $ReviewModelCopyWith(
    ReviewModel value,
    $Res Function(ReviewModel) then,
  ) = _$ReviewModelCopyWithImpl<$Res, ReviewModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'shop_id') String shopId,
    int rating,
    String? content,
    List<String> photos,
    @JsonKey(name: 'helpful_count') int helpfulCount,
    @JsonKey(name: 'is_visible') bool isVisible,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    UserModel? user,
  });

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$ReviewModelCopyWithImpl<$Res, $Val extends ReviewModel>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? shopId = null,
    Object? rating = null,
    Object? content = freezed,
    Object? photos = null,
    Object? helpfulCount = null,
    Object? isVisible = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            shopId: null == shopId
                ? _value.shopId
                : shopId // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            photos: null == photos
                ? _value.photos
                : photos // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            helpfulCount: null == helpfulCount
                ? _value.helpfulCount
                : helpfulCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isVisible: null == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReviewModelImplCopyWith<$Res>
    implements $ReviewModelCopyWith<$Res> {
  factory _$$ReviewModelImplCopyWith(
    _$ReviewModelImpl value,
    $Res Function(_$ReviewModelImpl) then,
  ) = __$$ReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'shop_id') String shopId,
    int rating,
    String? content,
    List<String> photos,
    @JsonKey(name: 'helpful_count') int helpfulCount,
    @JsonKey(name: 'is_visible') bool isVisible,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    UserModel? user,
  });

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ReviewModelImplCopyWithImpl<$Res>
    extends _$ReviewModelCopyWithImpl<$Res, _$ReviewModelImpl>
    implements _$$ReviewModelImplCopyWith<$Res> {
  __$$ReviewModelImplCopyWithImpl(
    _$ReviewModelImpl _value,
    $Res Function(_$ReviewModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? shopId = null,
    Object? rating = null,
    Object? content = freezed,
    Object? photos = null,
    Object? helpfulCount = null,
    Object? isVisible = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _$ReviewModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        shopId: null == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        photos: null == photos
            ? _value._photos
            : photos // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        helpfulCount: null == helpfulCount
            ? _value.helpfulCount
            : helpfulCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isVisible: null == isVisible
            ? _value.isVisible
            : isVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewModelImpl implements _ReviewModel {
  const _$ReviewModelImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'shop_id') required this.shopId,
    required this.rating,
    this.content,
    final List<String> photos = const [],
    @JsonKey(name: 'helpful_count') this.helpfulCount = 0,
    @JsonKey(name: 'is_visible') this.isVisible = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    this.user,
  }) : _photos = photos;

  factory _$ReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'shop_id')
  final String shopId;
  @override
  final int rating;
  @override
  final String? content;
  final List<String> _photos;
  @override
  @JsonKey()
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  @JsonKey(name: 'helpful_count')
  final int helpfulCount;
  @override
  @JsonKey(name: 'is_visible')
  final bool isVisible;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  // Joined user data
  @override
  final UserModel? user;

  @override
  String toString() {
    return 'ReviewModel(id: $id, userId: $userId, shopId: $shopId, rating: $rating, content: $content, photos: $photos, helpfulCount: $helpfulCount, isVisible: $isVisible, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.helpfulCount, helpfulCount) ||
                other.helpfulCount == helpfulCount) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    shopId,
    rating,
    content,
    const DeepCollectionEquality().hash(_photos),
    helpfulCount,
    isVisible,
    createdAt,
    updatedAt,
    user,
  );

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      __$$ReviewModelImplCopyWithImpl<_$ReviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewModelImplToJson(this);
  }
}

abstract class _ReviewModel implements ReviewModel {
  const factory _ReviewModel({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'shop_id') required final String shopId,
    required final int rating,
    final String? content,
    final List<String> photos,
    @JsonKey(name: 'helpful_count') final int helpfulCount,
    @JsonKey(name: 'is_visible') final bool isVisible,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    final UserModel? user,
  }) = _$ReviewModelImpl;

  factory _ReviewModel.fromJson(Map<String, dynamic> json) =
      _$ReviewModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'shop_id')
  String get shopId;
  @override
  int get rating;
  @override
  String? get content;
  @override
  List<String> get photos;
  @override
  @JsonKey(name: 'helpful_count')
  int get helpfulCount;
  @override
  @JsonKey(name: 'is_visible')
  bool get isVisible;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // Joined user data
  @override
  UserModel? get user;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateReviewRequest _$CreateReviewRequestFromJson(Map<String, dynamic> json) {
  return _CreateReviewRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateReviewRequest {
  @JsonKey(name: 'shop_id')
  String get shopId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;

  /// Serializes this CreateReviewRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReviewRequestCopyWith<CreateReviewRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReviewRequestCopyWith<$Res> {
  factory $CreateReviewRequestCopyWith(
    CreateReviewRequest value,
    $Res Function(CreateReviewRequest) then,
  ) = _$CreateReviewRequestCopyWithImpl<$Res, CreateReviewRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'shop_id') String shopId,
    int rating,
    String? content,
    List<String> photos,
  });
}

/// @nodoc
class _$CreateReviewRequestCopyWithImpl<$Res, $Val extends CreateReviewRequest>
    implements $CreateReviewRequestCopyWith<$Res> {
  _$CreateReviewRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopId = null,
    Object? rating = null,
    Object? content = freezed,
    Object? photos = null,
  }) {
    return _then(
      _value.copyWith(
            shopId: null == shopId
                ? _value.shopId
                : shopId // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            photos: null == photos
                ? _value.photos
                : photos // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateReviewRequestImplCopyWith<$Res>
    implements $CreateReviewRequestCopyWith<$Res> {
  factory _$$CreateReviewRequestImplCopyWith(
    _$CreateReviewRequestImpl value,
    $Res Function(_$CreateReviewRequestImpl) then,
  ) = __$$CreateReviewRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'shop_id') String shopId,
    int rating,
    String? content,
    List<String> photos,
  });
}

/// @nodoc
class __$$CreateReviewRequestImplCopyWithImpl<$Res>
    extends _$CreateReviewRequestCopyWithImpl<$Res, _$CreateReviewRequestImpl>
    implements _$$CreateReviewRequestImplCopyWith<$Res> {
  __$$CreateReviewRequestImplCopyWithImpl(
    _$CreateReviewRequestImpl _value,
    $Res Function(_$CreateReviewRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopId = null,
    Object? rating = null,
    Object? content = freezed,
    Object? photos = null,
  }) {
    return _then(
      _$CreateReviewRequestImpl(
        shopId: null == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        photos: null == photos
            ? _value._photos
            : photos // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReviewRequestImpl implements _CreateReviewRequest {
  const _$CreateReviewRequestImpl({
    @JsonKey(name: 'shop_id') required this.shopId,
    required this.rating,
    this.content,
    final List<String> photos = const [],
  }) : _photos = photos;

  factory _$CreateReviewRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReviewRequestImplFromJson(json);

  @override
  @JsonKey(name: 'shop_id')
  final String shopId;
  @override
  final int rating;
  @override
  final String? content;
  final List<String> _photos;
  @override
  @JsonKey()
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString() {
    return 'CreateReviewRequest(shopId: $shopId, rating: $rating, content: $content, photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReviewRequestImpl &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    shopId,
    rating,
    content,
    const DeepCollectionEquality().hash(_photos),
  );

  /// Create a copy of CreateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReviewRequestImplCopyWith<_$CreateReviewRequestImpl> get copyWith =>
      __$$CreateReviewRequestImplCopyWithImpl<_$CreateReviewRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReviewRequestImplToJson(this);
  }
}

abstract class _CreateReviewRequest implements CreateReviewRequest {
  const factory _CreateReviewRequest({
    @JsonKey(name: 'shop_id') required final String shopId,
    required final int rating,
    final String? content,
    final List<String> photos,
  }) = _$CreateReviewRequestImpl;

  factory _CreateReviewRequest.fromJson(Map<String, dynamic> json) =
      _$CreateReviewRequestImpl.fromJson;

  @override
  @JsonKey(name: 'shop_id')
  String get shopId;
  @override
  int get rating;
  @override
  String? get content;
  @override
  List<String> get photos;

  /// Create a copy of CreateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReviewRequestImplCopyWith<_$CreateReviewRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
