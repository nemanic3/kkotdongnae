// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FeedPostModel _$FeedPostModelFromJson(Map<String, dynamic> json) {
  return _FeedPostModel.fromJson(json);
}

/// @nodoc
mixin _$FeedPostModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_id')
  String get shopId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  /// 게시글 타입: normal, event, new_arrival, promotion
  @JsonKey(name: 'post_type')
  String get postType => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comment_count')
  int get commentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  int get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_liked')
  bool get isLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// 연결된 가게 정보 (join)
  FlowerShopModel? get shop => throw _privateConstructorUsedError;

  /// Serializes this FeedPostModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedPostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedPostModelCopyWith<FeedPostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedPostModelCopyWith<$Res> {
  factory $FeedPostModelCopyWith(
    FeedPostModel value,
    $Res Function(FeedPostModel) then,
  ) = _$FeedPostModelCopyWithImpl<$Res, FeedPostModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'shop_id') String shopId,
    String title,
    String? content,
    List<String> images,
    @JsonKey(name: 'post_type') String postType,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'comment_count') int commentCount,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    FlowerShopModel? shop,
  });

  $FlowerShopModelCopyWith<$Res>? get shop;
}

/// @nodoc
class _$FeedPostModelCopyWithImpl<$Res, $Val extends FeedPostModel>
    implements $FeedPostModelCopyWith<$Res> {
  _$FeedPostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedPostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopId = null,
    Object? title = null,
    Object? content = freezed,
    Object? images = null,
    Object? postType = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? viewCount = null,
    Object? isLiked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? shop = freezed,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            postType: null == postType
                ? _value.postType
                : postType // ignore: cast_nullable_to_non_nullable
                      as String,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            shop: freezed == shop
                ? _value.shop
                : shop // ignore: cast_nullable_to_non_nullable
                      as FlowerShopModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of FeedPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FlowerShopModelCopyWith<$Res>? get shop {
    if (_value.shop == null) {
      return null;
    }

    return $FlowerShopModelCopyWith<$Res>(_value.shop!, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeedPostModelImplCopyWith<$Res>
    implements $FeedPostModelCopyWith<$Res> {
  factory _$$FeedPostModelImplCopyWith(
    _$FeedPostModelImpl value,
    $Res Function(_$FeedPostModelImpl) then,
  ) = __$$FeedPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'shop_id') String shopId,
    String title,
    String? content,
    List<String> images,
    @JsonKey(name: 'post_type') String postType,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'comment_count') int commentCount,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'is_liked') bool isLiked,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    FlowerShopModel? shop,
  });

  @override
  $FlowerShopModelCopyWith<$Res>? get shop;
}

/// @nodoc
class __$$FeedPostModelImplCopyWithImpl<$Res>
    extends _$FeedPostModelCopyWithImpl<$Res, _$FeedPostModelImpl>
    implements _$$FeedPostModelImplCopyWith<$Res> {
  __$$FeedPostModelImplCopyWithImpl(
    _$FeedPostModelImpl _value,
    $Res Function(_$FeedPostModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedPostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopId = null,
    Object? title = null,
    Object? content = freezed,
    Object? images = null,
    Object? postType = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? viewCount = null,
    Object? isLiked = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? shop = freezed,
  }) {
    return _then(
      _$FeedPostModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        shopId: null == shopId
            ? _value.shopId
            : shopId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        postType: null == postType
            ? _value.postType
            : postType // ignore: cast_nullable_to_non_nullable
                  as String,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        shop: freezed == shop
            ? _value.shop
            : shop // ignore: cast_nullable_to_non_nullable
                  as FlowerShopModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedPostModelImpl implements _FeedPostModel {
  const _$FeedPostModelImpl({
    required this.id,
    @JsonKey(name: 'shop_id') required this.shopId,
    required this.title,
    this.content,
    final List<String> images = const [],
    @JsonKey(name: 'post_type') this.postType = 'normal',
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'comment_count') this.commentCount = 0,
    @JsonKey(name: 'view_count') this.viewCount = 0,
    @JsonKey(name: 'is_liked') this.isLiked = false,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    this.shop,
  }) : _images = images;

  factory _$FeedPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedPostModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'shop_id')
  final String shopId;
  @override
  final String title;
  @override
  final String? content;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  /// 게시글 타입: normal, event, new_arrival, promotion
  @override
  @JsonKey(name: 'post_type')
  final String postType;
  @override
  @JsonKey(name: 'like_count')
  final int likeCount;
  @override
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @override
  @JsonKey(name: 'view_count')
  final int viewCount;
  @override
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// 연결된 가게 정보 (join)
  @override
  final FlowerShopModel? shop;

  @override
  String toString() {
    return 'FeedPostModel(id: $id, shopId: $shopId, title: $title, content: $content, images: $images, postType: $postType, likeCount: $likeCount, commentCount: $commentCount, viewCount: $viewCount, isLiked: $isLiked, createdAt: $createdAt, updatedAt: $updatedAt, shop: $shop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedPostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.shop, shop) || other.shop == shop));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    shopId,
    title,
    content,
    const DeepCollectionEquality().hash(_images),
    postType,
    likeCount,
    commentCount,
    viewCount,
    isLiked,
    createdAt,
    updatedAt,
    shop,
  );

  /// Create a copy of FeedPostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedPostModelImplCopyWith<_$FeedPostModelImpl> get copyWith =>
      __$$FeedPostModelImplCopyWithImpl<_$FeedPostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedPostModelImplToJson(this);
  }
}

abstract class _FeedPostModel implements FeedPostModel {
  const factory _FeedPostModel({
    required final String id,
    @JsonKey(name: 'shop_id') required final String shopId,
    required final String title,
    final String? content,
    final List<String> images,
    @JsonKey(name: 'post_type') final String postType,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'comment_count') final int commentCount,
    @JsonKey(name: 'view_count') final int viewCount,
    @JsonKey(name: 'is_liked') final bool isLiked,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    final FlowerShopModel? shop,
  }) = _$FeedPostModelImpl;

  factory _FeedPostModel.fromJson(Map<String, dynamic> json) =
      _$FeedPostModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'shop_id')
  String get shopId;
  @override
  String get title;
  @override
  String? get content;
  @override
  List<String> get images;

  /// 게시글 타입: normal, event, new_arrival, promotion
  @override
  @JsonKey(name: 'post_type')
  String get postType;
  @override
  @JsonKey(name: 'like_count')
  int get likeCount;
  @override
  @JsonKey(name: 'comment_count')
  int get commentCount;
  @override
  @JsonKey(name: 'view_count')
  int get viewCount;
  @override
  @JsonKey(name: 'is_liked')
  bool get isLiked;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// 연결된 가게 정보 (join)
  @override
  FlowerShopModel? get shop;

  /// Create a copy of FeedPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedPostModelImplCopyWith<_$FeedPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
