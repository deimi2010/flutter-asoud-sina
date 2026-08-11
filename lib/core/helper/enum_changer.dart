import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';

String tagEnumChanger(TagEnum? tag) {
  switch (tag) {
    case TagEnum.newProduct:
      return 'new';
    case TagEnum.specialOffer:
      return 'special_offer';
    case TagEnum.comingSoon:
      return 'coming_soon';
    case TagEnum.none:
      return 'none';
    default:
      return 'new';
  }
}

String sellTypeEnumChanger(SellTypeEnum? sellType) {
  switch (sellType) {
    case SellTypeEnum.online:
      return 'online';
    case SellTypeEnum.person:
      return 'person';
    case SellTypeEnum.both:
      return 'both';
    default:
      return 'online';
  }
}

String publishStatusEnumChanger(PublishStatusEnum? publishStatus) {
  switch (publishStatus) {
    case PublishStatusEnum.published:
      return 'published';
    case PublishStatusEnum.draft:
      return 'draft';
    case PublishStatusEnum.queue:
      return 'queue';
    case PublishStatusEnum.notPublished:
      return 'not_published';
    case PublishStatusEnum.needsEditing:
      return 'needs_editing';
    case PublishStatusEnum.inactive:
      return 'inactive';
    default:
      return 'published';
  }
}

String tagPositionEnumChanger(PositionEnum? tagPosition) {
  switch (tagPosition) {
    case PositionEnum.topLeft:
      return 'top_left';
    case PositionEnum.topRight:
      return 'top_right';
    case PositionEnum.bottomLeft:
      return 'bottom_left';
    case PositionEnum.bottomRight:
      return 'bottom_right';
    default:
      return 'top_left';
  }
}
