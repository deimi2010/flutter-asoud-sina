import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/create_workspace/data/model/market_contact.dart';
import 'package:asood/features/create_workspace/data/model/market_schedule.dart';
import 'package:asood/features/create_workspace/data/model/marketbase_model.dart';
import 'package:asood/features/create_workspace/domain/repository/create_market_repository.dart';
import 'package:asood/features/create_workspace/domain/repository/region_repository.dart';
import 'package:asood/features/vendor/data/model/country_model.dart';
import 'package:asood/features/vendor/data/model/market_location_model.dart';
import 'package:asood/features/vendor/data/model/work_hours_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_workspace_event.dart';
part 'create_workspace_state.dart';

class CreateWorkSpaceBloc
    extends Bloc<CreateWorkSpaceEvent, CreateWorkSpaceState> {
  CreateMarketRepository marketRepo;

  final RegionRepository regionRepo;

  CreateWorkSpaceBloc(this.marketRepo, this.regionRepo)
    : super(CreateWorkSpaceState.initial()) {
    //on ChangeTabView change active index
    on<ChangeWorkspaceTabView>((event, emit) {
      emit(state.copyWith(activeTabIndex: event.activeTabIndex));
    });

    on<UpdateMessengerIds>((event, emit) {
      emit(state.copyWith(messengerIds: event.messengerIds));
    });
    on<SetMarketScheduleEvent>((event, emit) async {
      emit(state.copyWith(status: CWSStatus.loading));

      try {
        var res = await marketRepo.createSchedule(event.scheduleModel);

        if (res is Success) {
          final existingIndex = state.marketSchedules.indexWhere(
            (s) =>
                s.market == event.scheduleModel.market &&
                s.day == event.scheduleModel.day,
          );

          List<MarketScheduleModel> updatedSchedules = List.from(
            state.marketSchedules,
          );

          if (existingIndex != -1) {
            // اگر قبلاً وجود داشت، جایگزین کن
            updatedSchedules[existingIndex] = event.scheduleModel;
          } else {
            // اگر نبود، اضافه کن
            updatedSchedules.add(event.scheduleModel);
          }

          emit(
            state.copyWith(
              marketSchedules: updatedSchedules,
              status: CWSStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: CWSStatus.failure,
              error: res.error.toString(),
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    });

    //set market type
    on<SetMarketType>((event, emit) {
      emit(state.copyWith(marketType: event.marketType));
    });

    on<CreateMarket>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: CWSStatus.loading,
            marketType: "shop",
            businessId: event.businessId,
            name: event.name,
            description: event.description,
            subCategory: event.subCategory,
            slogan: event.slogan,
          ),
        );

        var res = await marketRepo.createMarketBase(
          event.marketType,
          event.businessId,
          event.name,
          event.description,
          event.subCategory,
          event.slogan,
          event.idCode.isNotEmpty ? event.idCode : null,
        );

        if (res is Success) {
          final initList = res.response as Map<String, dynamic>;

          MarketBaseModel marketBaseModel = MarketBaseModel.fromJson(initList);

          emit(
            state.copyWith(
              activeTabIndex: 1,
              status: CWSStatus.success,
              marketId: marketBaseModel.market,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: CWSStatus.failure,
              error: res.error.toString(),
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    });

    on<ChangeHasWorkTime>((event, emit) {
      emit(state.copyWith(hasWorkTime: event.hasWorkTime));
      // ignore: avoid_print
      print(state.hasWorkTime);
    });

    on<MarketContact>(_setMarketContact);

    on<SaveMarketLocationEvent>(_setMarketLocation);
    on<ChangeLocDataEvent>((event, emit) {
      emit(
        state.copyWith(
          city: event.city,
          cityId: event.cityId,
          country: event.country,
          countryId: event.countryId,
          province: event.province,
          provinceId: event.provinceId,

          address: event.workAddress,
          postalCode: event.postalCode,
          latitude: event.latitude,
          longitude: event.longitude,
        ),
      );
    });

    on<CalPrice>(_calPrice);

    on<SetDiscount>(_setDiscount);

    on<PayPrice>(_payPrice);

    on<ChangeSelectedCategory>((event, emit) {
      emit(
        state.copyWith(
          activeCategoryId: event.activeCategoryId,
          selectedCategoryName: event.selectedCategoryName,
        ),
      );
    });

    //region
    on<LoadCountry>(_getCountries);
    on<LoadProvince>(_getProvinces);
    on<LoadCity>(_getCities);
  }

  //market contact
  _setMarketContact(
    MarketContact event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    emit(
      state.copyWith(
        phoneNumber1: event.phoneNumber1,
        phoneNumber2: event.phoneNumber2,
        telephone: event.telephone,
        status: CWSStatus.loading,
        fax: event.fax,
        email: event.email,
        websiteUrl: event.websiteUrl,
        messengerIds: event.messengerIds,
      ),
    );
    MarketContactModel marketContact = MarketContactModel(
      market: event.marketId,
      firstMobileNumber: event.phoneNumber1,
      secondMobileNumber: event.phoneNumber2,
      telephone: event.telephone,
      fax: event.fax,
      email: event.email,
      websiteUrl: event.websiteUrl,
      messengerIds: event.messengerIds,
    );
    try {
      var res = await marketRepo.createMarketContact(marketContact);
      if (res is Success) {
        emit(state.copyWith(status: CWSStatus.success, activeTabIndex: 2));
      } else {
        emit(
          state.copyWith(
            status: CWSStatus.failure,
            error: res.error.toString(),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  //market location
  _setMarketLocation(
    SaveMarketLocationEvent event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    emit(state.copyWith(status: CWSStatus.loading));
    MarketLocationModel marketLocation = MarketLocationModel(
      market: state.marketId,
      address: state.address,
      city: state.city,
      zipCode: state.postalCode,
      latitude: state.latitude,
      longitude: state.longitude,
    );

    try {
      var res = await marketRepo.createMarketLocation(marketLocation);
      if (res is Success) {
        emit(state.copyWith(status: CWSStatus.success));
      } else {
        emit(
          state.copyWith(
            status: CWSStatus.failure,
            error: res.error.toString(),
          ),
        );
      }
    } catch (e) {}
  }

  _calPrice(CalPrice event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {}
  }

  _setDiscount(SetDiscount event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {}
  }

  _payPrice(PayPrice event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {}
  }

  //--------------- Region ----------
  //list of countries
  _getCountries(LoadCountry event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = await regionRepo.getCountryList();

      if (res is Success) {
        var resp = res.response as List;
        final countryList = resp.map((e) => CountryModel.fromJson(e)).toList();

        emit(
          state.copyWith(status: CWSStatus.success, countryList: countryList),
        );
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  //list of provinces
  _getProvinces(LoadProvince event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = await regionRepo.getProvinceList(event.countryId);
      if (res is Success) {
        var resp = res.response as List;
        final provinceList = resp.map((e) => CountryModel.fromJson(e)).toList();

        emit(
          state.copyWith(status: CWSStatus.success, provinceList: provinceList),
        );
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  //list of cities
  _getCities(LoadCity event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = await regionRepo.getCityList(event.provinceId);
      if (res is Success) {
        var resp = res.response as List;
        final cityList = resp.map((e) => CountryModel.fromJson(e)).toList();

        emit(state.copyWith(status: CWSStatus.success, cityList: cityList));
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }
}
