import 'package:asood/core/helper/enum_changer.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/market/data/model/product_model.dart';
import 'package:asood/features/market/data/model/theme_model_model.dart';
import 'package:asood/features/market/domain/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRepository productRepository;
  AddProductBloc(this.productRepository) : super(AddProductState.initial()) {
    on<ResetDataEvent>((event, emit) => emit(AddProductState.initial()));
    on<AddProductEvent>((event, emit) {});

    on<ProductTypeEvent>(_changeProductType);

    on<SetIsMarketerEvent>(_changeMarketerType);
    on<SetIsRequirementEvent>(_changeIsRequirementType);

    on<SetCategoryEvent>(_changeCategory);

    on<ProductPriceStockEvent>(_changeProductPriceStockExtra);
    on<ChangeProductStockEvent>(_changeProductStock);

    on<DiscountTypeEvent>(_changeDiscountType);
    on<DiscountValuesEvent>(_changeDiscountValues);

    on<ProductExtraEvent>(_changeProductExtra);
    on<LoadProductListEvent>(_loadProductList);
    on<ChangeProductGiftAndRequiredEvent>(_changeProductRequiredGifted);

    on<ProductTagSaleEvent>(_changeProductTgSale);

    on<AddTagsEvent>(_addTags);
    on<AddKeywordsEvent>(_addKeywords);
    on<RemoveKeywordsEvent>(_removeKeywords);

    on<SubmitNewProductEvent>(_submitNewProduct);
    on<UpdatePublishStatusEvent>(_updatePublishStatus);

    on<UpdateProductDetailEvent>(_updateProductDetail);

    on<UpdateCategoryImageEvent>(_updateCategoryImage);
    on<SubmitThemeWithProductEvent>(_submitAndUpdatewithProduct);
  }

  _changeProductType(ProductTypeEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(productType: event.type));
  }

  _changeMarketerType(SetIsMarketerEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(isMarketer: event.isMarketer));
  }

  _changeIsRequirementType(
    SetIsRequirementEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(isRequirement: event.isRequirement));
  }

  _changeCategory(SetCategoryEvent event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        selectedCategoryName: event.selectedCategoryName,
        selectedCategoryId: event.selectedCategoryId,
      ),
    );
  }

  _changeProductStock(
    ChangeProductStockEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(productStock: event.stock));
  }

  _changeProductPriceStockExtra(
    ProductPriceStockEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(
      state.copyWith(
        productStockEnable: event.stockEnable,
        productPriceEnable: event.priceEnable,
      ),
    );
  }

  _changeDiscountType(DiscountTypeEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(discountType: event.type));
  }

  _changeDiscountValues(
    DiscountValuesEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(
      state.copyWith(
        discountPercentage: event.percentage,
        discountPeople: event.peopleNumber,
        discountDays: event.daysNumber,
        discountPosition: event.position,
      ),
    );
  }

  _changeProductExtra(ProductExtraEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(productGift: event.gift, productExtra: event.extra));
  }

  _changeProductRequiredGifted(
    ChangeProductGiftAndRequiredEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(
      state.copyWith(
        selectedProductGift: event.selectedProductGift,
        selectedProductExtra: event.selectedProductExtra,
      ),
    );
  }

  _changeProductTgSale(
    ProductTagSaleEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(
      state.copyWith(
        productTag: event.tag,
        productPosition: event.position,
        productSellType: event.sellType,
        productSendPrice: event.sendPrice,
      ),
    );
  }

  _addTags(AddTagsEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(tags: [...state.tags, event.tag]));
  }

  _addKeywords(AddKeywordsEvent event, Emitter<AddProductState> emit) {
    emit(state.copyWith(keywords: [...state.keywords, event.keyword]));
  }

  _removeKeywords(RemoveKeywordsEvent event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        keywords:
            state.keywords
                .where((element) => element != event.keyword)
                .toList(),
      ),
    );
  }

  _loadProductList(
    LoadProductListEvent event,
    Emitter<AddProductState> emit,
  ) async {
    emit(state.copyWith(giftStatus: CWSStatus.loading));
    var res = await productRepository.productList(event.marketId);
    if (res is Success) {
      List<ThemeProductModel> product =
          (res.response as List)
              .map((e) => ThemeProductModel.fromJson(e))
              .toList();

      emit(state.copyWith(giftStatus: CWSStatus.success, productList: product));
    } else if (res is Failure) {
      emit(state.copyWith(giftStatus: CWSStatus.failure));
    }
  }

  _updateCategoryImage(
    UpdateCategoryImageEvent event,
    Emitter<AddProductState> emit,
  ) {
    final currentImages = state.selectedCategoryImage ?? [];
    final currentImageFiles = state.selectedCategoryImageFile ?? [];

    emit(
      state.copyWith(
        selectedCategoryImage: [...currentImages, event.selectedCategoryImage],
        selectedCategoryImageFile: [
          ...currentImageFiles,
          event.selectedCategoryImageFile!,
        ],
      ),
    );
  }

  _updatePublishStatus(
    UpdatePublishStatusEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(publishStatus: event.publishStatus));
  }

  _updateProductDetail(
    UpdateProductDetailEvent event,
    Emitter<AddProductState> emit,
  ) {
    emit(
      state.copyWith(
        productName: event.productName ?? state.productName,
        productDescription:
            event.productDescription ?? state.productDescription,
        productTechnicalDescription:
            event.productTechnicalDescription ??
            state.productTechnicalDescription,
      ),
    );
  }

  _submitAndUpdatewithProduct(
    SubmitThemeWithProductEvent event,
    Emitter<AddProductState> emit,
  ) async {}
  _submitNewProduct(
    SubmitNewProductEvent event,
    Emitter<AddProductState> emit,
  ) async {
    emit(state.copyWith(status: CWSStatus.loading));

    try {
      // مرحله ۱: اگر تخفیف فعاله، اول تخفیف رو ایجاد کن
      if (state.discountType != DiscountType.none) {
        final discountRes = await productRepository.createProductDiscount(
          event.market,
          state.discountPosition,
          state.discountPercentage,
          state.discountDays,
        );

        if (discountRes is! Success) {
          throw Exception('Failed to create product discount');
        }
      }

      // مرحله ۲: ساخت مدل محصول
      final product = ProductModel(
        market: event.market,
        type: state.productType.name,
        name: event.name,
        description: event.description,
        technicalDetail: event.technicalDetail,
        stock: state.productStock,
        price: state.productPrice,
        requiredProduct: state.selectedProductGift?.id ?? "",
        giftProduct: state.selectedProductGift?.id ?? "",
        isMarketer: state.isMarketer,
        sellType: sellTypeEnumChanger(state.productSellType),
        shipCost: 2000, // TODO: Update ship cost from backend
        shipCostPayType: state.productSendPrice.name,
        publishStatus: publishStatusEnumChanger(state.publishStatus),
        subCategory: state.selectedCategoryId,
        keywords: state.keywords,
        tag: tagEnumChanger(state.productTag),
        tagPosition: tagPositionEnumChanger(state.productPosition),
        mainPrice: state.productPrice,
        colleaguePrice: state.productPrice,
        marketerPrice: state.productPrice,
        maximumSellPrice: state.productPrice,
        isRequirement: state.isRequirement,
        image: state.selectedCategoryImageFile,
      );

      // مرحله ۳: ساخت محصول
      final createProductRes = await productRepository.createProduct(product);
      if (createProductRes is Success) {
        final productModel = ProductModel.fromJson(
          createProductRes.response as Map<String, dynamic>,
        );

        // مرحله ۴: آپدیت تم مارکت
        final themeRes = await productRepository.updateMarketTheme(
          themeId: event.themeId,
          productId: productModel.product!,
          themeIndex: event.themeIndex,
        );

        if (themeRes is! Success) {
          throw Exception('Failed to update market theme');
        }

        emit(state.copyWith(status: CWSStatus.success));
      }
    } catch (e) {
      print('Add product error: $e');
      emit(state.copyWith(status: CWSStatus.failure));
    } finally {
      emit(state.copyWith(status: CWSStatus.initial));
    }
  }
}
