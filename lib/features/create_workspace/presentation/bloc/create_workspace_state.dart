part of 'create_workspace_bloc.dart';

class CreateWorkSpaceState {
  final String? marketId;
  final String businessId;
  final String idCode;
  final String name;
  final String description;
  final String subCategory;
  final String slogan;
  final CWSStatus status;
  final String message;
  final String marketType;
  final String error;

  final int activeTabIndex;

  //second view
  final String phoneNumber1;
  final String phoneNumber2;
  final String telephone;
  final String fax;
  final String email;
  final String websiteUrl;
  final MessengerIds messengerIds;
  final bool hasWorkTime;
  final WorkHours workHours;

  final Color phoneBorder;
  final Color emailBorder;

  //third view
  final String country;
  final String countryId;
  final String city;
  final String cityId;
  final String province;
  final String provinceId;
  final String address;
  final String postalCode;
  final String latitude;
  final String longitude;

  final String activeCategoryId;
  final String selectedCategoryName;

  final List<CountryModel> countryList;
  final List<CountryModel> provinceList;
  final List<CountryModel> cityList;

  final List<MarketScheduleModel> marketSchedules;

  const CreateWorkSpaceState({
    required this.marketId,
    required this.idCode,
    required this.phoneBorder,
    required this.emailBorder,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.telephone,
    required this.fax,
    required this.email,
    required this.websiteUrl,
    required this.messengerIds,
    required this.workHours,
    required this.businessId,
    required this.name,
    required this.description,
    required this.subCategory,
    required this.slogan,
    required this.hasWorkTime,
    required this.marketType,
    required this.status,
    required this.message,
    required this.error,
    required this.activeTabIndex,

    required this.country,
    required this.countryId,
    required this.city,
    required this.cityId,
    required this.province,
    required this.provinceId,
    required this.address,
    required this.postalCode,
    required this.latitude,
    required this.longitude,

    required this.activeCategoryId,
    required this.selectedCategoryName,

    required this.countryList,
    required this.provinceList,
    required this.cityList,
    required this.marketSchedules,
  });

  factory CreateWorkSpaceState.initial() {
    return CreateWorkSpaceState(
      marketId: "",
      idCode: "",
      phoneBorder: Colora.borderTag,
      emailBorder: Colora.borderTag,
      phoneNumber1: '',
      phoneNumber2: '',
      telephone: '',

      fax: '',
      email: '',
      websiteUrl: '',
      messengerIds: MessengerIds(),
      workHours: WorkHours(
        fromSat: '',
        toSat: '',
        fromSun: '',
        toSun: '',
        fromMon: '',
        toMon: '',
        fromTue: '',
        toTue: '',
        fromWed: '',
        toWed: '',
        fromThu: '',
        toThu: '',
        fromFri: '',
        toFri: '',
      ),
      businessId: '',
      name: '',
      description: '',
      subCategory: "0",
      slogan: '',
      activeTabIndex: 0,
      hasWorkTime: false,
      status: CWSStatus.initial,
      message: '',
      marketType: 'shop',
      error: '',
      country: '',
      countryId: '',
      city: "",
      cityId: "",
      province: '',
      provinceId: '',
      address: '',
      postalCode: '',
      latitude: '',
      longitude: '',

      activeCategoryId: "",
      selectedCategoryName: 'انتخاب شغل',

      countryList: const [],
      provinceList: const [],
      cityList: const [],
      marketSchedules: [],
    );
  }

  CreateWorkSpaceState copyWith({
    String? marketId,
    String? idCode,
    String? phoneNumber1,
    String? phoneNumber2,
    String? telephone,
    String? businessId,
    String? fax,
    String? email,
    String? websiteUrl,
    MessengerIds? messengerIds,
    WorkHours? workHours,
    String? name,
    String? description,
    String? subCategory,
    String? slogan,
    CWSStatus? status,
    String? message,
    String? marketType,
    String? error,
    bool? hasWorkTime,
    int? activeTabIndex,
    Color? phoneBorder,
    Color? emailBorder,

    String? country,
    String? countryId,
    String? city,
    String? cityId,
    String? province,
    String? provinceId,
    String? address,
    String? postalCode,
    String? latitude,
    String? longitude,

    String? activeCategoryId,
    String? selectedCategoryName,

    List<CountryModel>? countryList,
    List<CountryModel>? provinceList,
    List<CountryModel>? cityList,

    List<MarketScheduleModel>? marketSchedules,
  }) {
    return CreateWorkSpaceState(
      marketId: marketId ?? this.marketId,
      idCode: idCode ?? this.idCode,
      phoneBorder: phoneBorder ?? this.phoneBorder,
      emailBorder: emailBorder ?? this.emailBorder,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      telephone: telephone ?? this.telephone,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      messengerIds: messengerIds ?? this.messengerIds,
      workHours: workHours ?? this.workHours,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      description: description ?? this.description,
      subCategory: subCategory ?? this.subCategory,
      slogan: slogan ?? this.slogan,
      status: status ?? this.status,
      message: message ?? this.message,
      marketType: marketType ?? this.marketType,
      error: error ?? this.error,
      hasWorkTime: hasWorkTime ?? this.hasWorkTime,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      country: country ?? this.country,
      countryId: countryId ?? this.countryId,
      city: city ?? this.city,
      cityId: cityId ?? this.cityId,
      province: province ?? this.province,
      provinceId: provinceId ?? this.provinceId,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,

      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,

      countryList: countryList ?? this.countryList,
      provinceList: provinceList ?? this.provinceList,
      cityList: cityList ?? this.cityList,
      marketSchedules: marketSchedules ?? this.marketSchedules,
    );
  }
}
