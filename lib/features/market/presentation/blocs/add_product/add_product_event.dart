part of 'add_product_bloc.dart';

sealed class AddProductEvent {
  const AddProductEvent();
}

class ProductTypeEvent extends AddProductEvent {
  final ProductType type;

  const ProductTypeEvent({required this.type});
}

class SetIsMarketerEvent extends AddProductEvent {
  final bool isMarketer;

  const SetIsMarketerEvent({required this.isMarketer});
}

class SetIsRequirementEvent extends AddProductEvent {
  final bool isRequirement;

  const SetIsRequirementEvent({required this.isRequirement});
}

class SetCategoryEvent extends AddProductEvent {
  final String selectedCategoryName;
  final String selectedCategoryId;

  const SetCategoryEvent({
    required this.selectedCategoryName,
    required this.selectedCategoryId,
  });
}

class AddTagsEvent extends AddProductEvent {
  final String tag;

  const AddTagsEvent({required this.tag});
}

class AddKeywordsEvent extends AddProductEvent {
  final String keyword;

  const AddKeywordsEvent({required this.keyword});
}

class RemoveKeywordsEvent extends AddProductEvent {
  final String keyword;

  const RemoveKeywordsEvent({required this.keyword});
}

class ChangeProductStockEvent extends AddProductEvent {
  final int stock;

  const ChangeProductStockEvent({required this.stock});
}

class ChangeProductPriceEvent extends AddProductEvent {
  final int price;

  const ChangeProductPriceEvent({required this.price});
}

class ProductPriceStockEvent extends AddProductEvent {
  final bool? priceEnable;
  final bool? stockEnable;

  const ProductPriceStockEvent({this.priceEnable, this.stockEnable});
}

/// discount settings
class DiscountTypeEvent extends AddProductEvent {
  final DiscountType type;

  const DiscountTypeEvent({required this.type});
}

class DiscountValuesEvent extends AddProductEvent {
  final int? percentage;
  final int? peopleNumber;
  final int? daysNumber;
  final PositionEnum? position;

  const DiscountValuesEvent({
    this.percentage,
    this.peopleNumber,
    this.daysNumber,
    this.position,
  });
}

class ProductTagSaleEvent extends AddProductEvent {
  final TagEnum? tag;
  final PositionEnum? position;
  final SellTypeEnum? sellType;
  final SendPriceEnum? sendPrice;

  const ProductTagSaleEvent({
    this.tag,
    this.position,
    this.sellType,
    this.sendPrice,
  });
}

class SubmitNewProductEvent extends AddProductEvent {
  final String market;
  final String name;
  final String description;
  final String technicalDetail;
  final String themeId;
  final String themeIndex;

  const SubmitNewProductEvent({
    required this.market,
    required this.name,
    required this.description,
    required this.technicalDetail,
    required this.themeId,
    required this.themeIndex,
  });
}

class SubmitThemeWithProductEvent extends AddProductEvent {
  const SubmitThemeWithProductEvent();
}

class ProductExtraEvent extends AddProductEvent {
  final bool? gift;
  final bool? extra;

  const ProductExtraEvent({this.gift, this.extra});
}

/// load product for gift and required
class LoadProductListEvent extends AddProductEvent {
  final String marketId;
  LoadProductListEvent({required this.marketId});
}

class ChangeProductGiftAndRequiredEvent extends AddProductEvent {
  final ThemeProductModel? selectedProductGift;
  final ThemeProductModel? selectedProductExtra;

  const ChangeProductGiftAndRequiredEvent({
    this.selectedProductGift,
    this.selectedProductExtra,
  });
}

class UpdatePublishStatusEvent extends AddProductEvent {
  final PublishStatusEnum publishStatus;

  const UpdatePublishStatusEvent({required this.publishStatus});
}

class ResetDataEvent extends AddProductEvent {
  const ResetDataEvent();
}

class UpdateProductDetailEvent extends AddProductEvent {
  final String? productName;
  final String? productDescription;
  final String? productTechnicalDescription;

  const UpdateProductDetailEvent({
    this.productName,
    this.productDescription,
    this.productTechnicalDescription,
  });
}

class UpdateCategoryImageEvent extends AddProductEvent {
  final String selectedCategoryImage;
  final XFile? selectedCategoryImageFile;

  const UpdateCategoryImageEvent({
    required this.selectedCategoryImage,
    required this.selectedCategoryImageFile,
  });
}
