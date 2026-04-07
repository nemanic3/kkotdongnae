import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/review_model.dart';
import '../../providers/review_provider.dart';
import '../../providers/shop_provider.dart';

class WriteReviewScreen extends ConsumerStatefulWidget {
  final String shopId;

  const WriteReviewScreen({
    super.key,
    required this.shopId,
  });

  @override
  ConsumerState<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends ConsumerState<WriteReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  int _rating = 5;
  final List<String> _selectedPhotos = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    if (_selectedPhotos.length >= AppConstants.maxPhotosPerReview) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('최대 ${AppConstants.maxPhotosPerReview}장까지 추가할 수 있습니다'),
        ),
      );
      return;
    }

    final picker = ImagePicker();
    final images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      final remainingSlots =
          AppConstants.maxPhotosPerReview - _selectedPhotos.length;
      final imagesToAdd = images.take(remainingSlots);

      setState(() {
        _selectedPhotos.addAll(imagesToAdd.map((img) => img.path));
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('별점을 선택해주세요')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // In a real app, you'd upload photos to Supabase Storage first
      // and get the URLs, then include them in the review
      final request = CreateReviewRequest(
        shopId: widget.shopId,
        rating: _rating,
        content: _contentController.text.trim(),
        photos: [], // Would be actual uploaded URLs
      );

      final success =
          await ref.read(createReviewProvider.notifier).createReview(request);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('리뷰가 등록되었습니다')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('리뷰 등록 실패: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopAsync = ref.watch(shopDetailProvider(widget.shopId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 작성'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submitReview,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('등록'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop name
              shopAsync.maybeWhen(
                data: (shop) => shop != null
                    ? Text(
                        shop.name,
                        style: AppTextStyles.heading3,
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Rating
              Text('별점', style: AppTextStyles.bodyLarge),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: RatingBar.builder(
                  initialRating: _rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (_, __) => const Icon(
                    Icons.star,
                    color: AppColors.star,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating.toInt();
                    });
                  },
                ),
              ),
              Center(
                child: Text(
                  _getRatingText(_rating),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.star,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Review content
              Text('리뷰 내용', style: AppTextStyles.bodyLarge),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                maxLength: AppConstants.maxReviewLength,
                decoration: const InputDecoration(
                  hintText: '이 꽃집은 어떠셨나요? 경험을 공유해주세요.',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '리뷰 내용을 입력해주세요';
                  }
                  if (value.trim().length < AppConstants.minReviewLength) {
                    return '최소 ${AppConstants.minReviewLength}자 이상 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Photos
              Text('사진 추가 (선택)', style: AppTextStyles.bodyLarge),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Add photo button
                    GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: AppSpacing.sm),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.divider),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_selectedPhotos.length}/${AppConstants.maxPhotosPerReview}',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Selected photos
                    ..._selectedPhotos.asMap().entries.map((entry) {
                      return Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(right: AppSpacing.sm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(entry.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 12,
                            child: GestureDetector(
                              onTap: () => _removePhoto(entry.key),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Submit button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReview,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('리뷰 등록하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return '별로예요';
      case 2:
        return '그저 그래요';
      case 3:
        return '보통이에요';
      case 4:
        return '좋아요';
      case 5:
        return '최고예요!';
      default:
        return '';
    }
  }
}
