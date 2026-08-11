part of 'add_product_bloc.dart';

enum ProductType { good, service }

enum DiscountType { none, percent, timed, group }

enum PositionEnum { topLeft, topRight, bottomLeft, bottomRight }

enum TagEnum { newProduct, specialOffer, comingSoon, none }

enum SellTypeEnum { online, person, both }

enum SendPriceEnum { market, customer, free }

enum PublishStatusEnum {
  draft,
  queue,
  notPublished,
  published,
  needsEditing,
  inactive,
}

class AddProductState {
  final CWSStatus status;
  final CWSStatus giftStatus;

  final String productName;
  final String productDescription;
  final String productTechnicalDescription;

  final ProductType productType;

  final bool isMarketer;
  final bool isRequirement;

  final String selectedCategoryName;
  final String selectedCategoryId;
  final List<String>? selectedCategoryImage;
  final List<XFile>? selectedCategoryImageFile;

  final List<String> tags;
  final List<String> keywords;

  final int productStock;
  final bool productStockEnable;
  final int productPrice;
  final bool productPriceEnable;

  final int discountPercentage;
  final int discountPeople;
  final int discountDays;
  final DiscountType discountType;
  final PositionEnum discountPosition;

  final bool productGift;
  final ThemeProductModel? selectedProductGift;
  final bool productExtra;
  final ThemeProductModel? selectedProductExtra;
  final List<ThemeProductModel> productList;

  final TagEnum productTag;
  final PositionEnum productPosition;

  final SellTypeEnum productSellType;
  final SendPriceEnum productSendPrice;

  final List productImages;

  final PublishStatusEnum publishStatus;
  final String? productId;
  const AddProductState({
    required this.status,
    required this.giftStatus,

    required this.productName,
    required this.productDescription,
    required this.productTechnicalDescription,

    required this.productType,

    required this.isMarketer,
    required this.isRequirement,

    required this.selectedCategoryName,
    required this.selectedCategoryId,

    required this.tags,
    required this.keywords,

    required this.productStock,
    required this.productStockEnable,
    required this.productPrice,
    required this.productPriceEnable,

    required this.discountType,
    required this.discountPercentage,
    required this.discountPeople,
    required this.discountDays,
    required this.discountPosition,

    required this.productGift,
    required this.selectedProductGift,
    required this.productExtra,
    required this.selectedProductExtra,
    required this.productList,

    required this.productTag,
    required this.productPosition,

    required this.productSellType,
    required this.productSendPrice,

    required this.productImages,

    required this.publishStatus,

    required this.selectedCategoryImage,
    required this.selectedCategoryImageFile,
    this.productId,
  });

  factory AddProductState.initial() {
    return const AddProductState(
      status: CWSStatus.initial,
      giftStatus: CWSStatus.initial,

      productName: '',
      productDescription: '',
      productTechnicalDescription: '',

      productType: ProductType.good,

      isMarketer: false,
      isRequirement: false,

      selectedCategoryName: '',
      selectedCategoryId: '',

      tags: [],
      keywords: [],

      productStock: 0,
      productStockEnable: false,
      productPrice: 0,
      productPriceEnable: false,

      discountType: DiscountType.none,
      discountPercentage: 50,
      discountPeople: 0,
      discountDays: 0,
      discountPosition: PositionEnum.topLeft,

      productGift: false,
      productExtra: false,
      selectedProductGift: null,
      selectedProductExtra: null,
      productList: [],

      productTag: TagEnum.newProduct,
      productPosition: PositionEnum.topLeft,

      productSellType: SellTypeEnum.online,
      productSendPrice: SendPriceEnum.market,

      productImages: [],

      publishStatus: PublishStatusEnum.published,

      selectedCategoryImage: null,
      selectedCategoryImageFile: null,
      productId: null,
    );
  }

  AddProductState copyWith({
    CWSStatus? status,
    CWSStatus? giftStatus,

    String? productName,
    String? productDescription,
    String? productTechnicalDescription,

    ProductType? productType,

    bool? isMarketer,
    bool? isRequirement,

    String? selectedCategoryName,
    String? selectedCategoryId,

    List<String>? tags,
    List<String>? keywords,

    int? productStock,
    bool? productStockEnable,
    int? productPrice,
    bool? productPriceEnable,

    DiscountType? discountType,
    int? discountPercentage,
    int? discountPeople,
    int? discountDays,
    PositionEnum? discountPosition,

    bool? productGift,
    ThemeProductModel? selectedProductGift,
    bool? productExtra,
    ThemeProductModel? selectedProductExtra,
    List<ThemeProductModel>? productList,

    TagEnum? productTag,
    PositionEnum? productPosition,

    SellTypeEnum? productSellType,
    SendPriceEnum? productSendPrice,

    List? productImages,

    PublishStatusEnum? publishStatus,

    List<String>? selectedCategoryImage,
    List<XFile>? selectedCategoryImageFile,

    // this is loaded product id
    String? productId,
  }) {
    return AddProductState(
      status: status ?? this.status,
      giftStatus: giftStatus ?? this.giftStatus,

      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productTechnicalDescription:
          productTechnicalDescription ?? this.productTechnicalDescription,

      productType: productType ?? this.productType,

      isMarketer: isMarketer ?? this.isMarketer,
      isRequirement: isRequirement ?? this.isRequirement,

      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,

      tags: tags ?? this.tags,
      keywords: keywords ?? this.keywords,

      productStock: productStock ?? this.productStock,
      productStockEnable: productStockEnable ?? this.productStockEnable,
      productPrice: productPrice ?? this.productPrice,
      productPriceEnable: productPriceEnable ?? this.productPriceEnable,

      discountType: discountType ?? this.discountType,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountPeople: discountPeople ?? this.discountPeople,
      discountDays: discountDays ?? this.discountDays,
      discountPosition: discountPosition ?? this.discountPosition,

      productGift: productGift ?? this.productGift,
      selectedProductGift: selectedProductGift ?? this.selectedProductGift,
      productExtra: productExtra ?? this.productExtra,
      selectedProductExtra: selectedProductExtra ?? this.selectedProductExtra,
      productList: productList ?? this.productList,

      productTag: productTag ?? this.productTag,
      productPosition: productPosition ?? this.productPosition,

      productSellType: productSellType ?? this.productSellType,
      productSendPrice: productSendPrice ?? this.productSendPrice,

      productImages: productImages ?? this.productImages,

      publishStatus: publishStatus ?? this.publishStatus,

      selectedCategoryImage:
          selectedCategoryImage ?? this.selectedCategoryImage,
      selectedCategoryImageFile:
          selectedCategoryImageFile ?? this.selectedCategoryImageFile,
      productId: productId ?? this.productId,
    );
  }
}
