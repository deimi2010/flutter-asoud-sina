part of 'create_workspace_bloc.dart';

class CreateWorkSpaceEvent {
  const CreateWorkSpaceEvent();
}

//first View Event
class CreateMarket extends CreateWorkSpaceEvent {
  final String marketType;
  final String businessId;
  final String name;
  final String description;
  final String subCategory;
  final String slogan;
  final String idCode;

  const CreateMarket({
    required this.marketType,
    required this.businessId,
    required this.idCode,
    required this.name,
    required this.description,
    required this.subCategory,
    required this.slogan,
  });
}

//second View Event
class MarketContact extends CreateWorkSpaceEvent {
  final String marketId;
  final String phoneNumber1;
  final String phoneNumber2;
  final String telephone;
  final String fax;
  final String email;
  final String websiteUrl;
  final MessengerIds messengerIds;
  // final bool hasWorkTime;
  // final WorkHours workHours;

  const MarketContact({
    required this.marketId,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.telephone,
    required this.fax,
    required this.email,
    required this.websiteUrl,
    required this.messengerIds,
  });
}

//third View Event
class SaveMarketLocationEvent extends CreateWorkSpaceEvent {
  const SaveMarketLocationEvent();
}

/// update user social ids
class UpdateMessengerIds extends CreateWorkSpaceEvent {
  final MessengerIds messengerIds;

  UpdateMessengerIds(this.messengerIds);
}

// change locationInfo
class ChangeLocDataEvent extends CreateWorkSpaceEvent {
  final String? country;
  final String? countryId;
  final String? province;
  final String? provinceId;
  final String? city;
  final String? cityId;
  final String? latitude;
  final String? longitude;
  final String? postalCode;
  final String? workAddress;

  const ChangeLocDataEvent({
    this.country,
    this.countryId,
    this.cityId,
    this.workAddress,
    this.province,
    this.provinceId,
    this.city,
    this.latitude,
    this.longitude,
    this.postalCode,
  });
}

//change tabview
class ChangeWorkspaceTabView extends CreateWorkSpaceEvent {
  final int activeTabIndex;
  const ChangeWorkspaceTabView({required this.activeTabIndex});
}

//set market type
class SetMarketType extends CreateWorkSpaceEvent {
  final String marketType;
  const SetMarketType({required this.marketType});
}

//has workHours
class ChangeHasWorkTime extends CreateWorkSpaceEvent {
  final bool hasWorkTime;
  const ChangeHasWorkTime({required this.hasWorkTime});
}

//change selected category
class ChangeSelectedCategory extends CreateWorkSpaceEvent {
  final String selectedCategoryName;
  final String activeCategoryId;
  const ChangeSelectedCategory({
    required this.selectedCategoryName,
    required this.activeCategoryId,
  });
}

class CalPrice extends CreateWorkSpaceEvent {}

class SetDiscount extends CreateWorkSpaceEvent {
  final String discountCode;
  const SetDiscount({required this.discountCode});
}

class PayPrice extends CreateWorkSpaceEvent {}

//region
class LoadCountry extends CreateWorkSpaceEvent {}

class LoadProvince extends CreateWorkSpaceEvent {
  final String countryId;
  const LoadProvince({required this.countryId});
}

class LoadCity extends CreateWorkSpaceEvent {
  final String provinceId;
  const LoadCity({required this.provinceId});
}

class SetMarketScheduleEvent extends CreateWorkSpaceEvent {
  final MarketScheduleModel scheduleModel;
  const SetMarketScheduleEvent({required this.scheduleModel});
}
