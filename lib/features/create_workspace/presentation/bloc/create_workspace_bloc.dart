import 'dart:async';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/models/market_model.dart';
import 'package:asood/features/create_workspace/data/models/market_contact.dart';
import 'package:asood/features/create_workspace/data/models/market_schedule.dart';
import 'package:asood/features/create_workspace/domain/repositories/create_market_repository.dart';
import 'package:asood/features/create_workspace/domain/repositories/region_repository.dart';
import 'package:asood/features/create_workspace/domain/entities/workspace_draft.dart';
import 'package:asood/features/create_workspace/domain/repositories/workspace_draft_repository.dart';
import 'package:asood/features/vendor/data/models/country_model.dart';
import 'package:asood/features/vendor/data/models/market_location_model.dart';
import 'package:asood/features/vendor/data/models/work_hours_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_workspace_event.dart';
part 'create_workspace_state.dart';

class CreateWorkSpaceBloc
    extends Bloc<CreateWorkSpaceEvent, CreateWorkSpaceState> {
  CreateMarketRepository marketRepo;

  final RegionRepository regionRepo;
  final WorkspaceDraftRepository draftRepository;
  Timer? _draftSaveTimer;
  String? _draftMarketId;

  CreateWorkSpaceBloc(this.marketRepo, this.regionRepo, this.draftRepository)
    : super(CreateWorkSpaceState.initial()) {
    on<LoadWorkspaceDraft>(_loadDraft);
    on<InitializeWorkspace>(_initializeWorkspace);
    on<PersistWorkspaceDraft>(_persistDraft);
    on<PreviousWorkspaceStep>((event, emit) {
      emit(
        state.copyWith(activeTabIndex: (state.activeTabIndex - 1).clamp(0, 2)),
      );
      _scheduleDraftSave();
    });
    on<UpdateWorkspaceDraft>((event, emit) {
      final dirtySteps = {...state.dirtySteps};
      if (state.isEditing) {
        if (event.businessId != null ||
            event.name != null ||
            event.description != null ||
            event.slogan != null ||
            event.idCode != null) {
          dirtySteps.add(0);
        }
        if (event.phoneNumber1 != null ||
            event.phoneNumber2 != null ||
            event.telephone != null ||
            event.fax != null ||
            event.email != null ||
            event.websiteUrl != null) {
          dirtySteps.add(1);
        }
        if (event.address != null || event.postalCode != null) {
          dirtySteps.add(2);
        }
      }
      emit(
        state.copyWith(
          businessId: event.businessId,
          name: event.name,
          description: event.description,
          slogan: event.slogan,
          idCode: event.idCode,
          phoneNumber1: event.phoneNumber1,
          phoneNumber2: event.phoneNumber2,
          telephone: event.telephone,
          fax: event.fax,
          email: event.email,
          websiteUrl: event.websiteUrl,
          address: event.address,
          postalCode: event.postalCode,
          dirtySteps: dirtySteps,
        ),
      );
      _scheduleDraftSave();
    });
    //on ChangeTabView change active index
    on<ChangeWorkspaceTabView>((event, emit) {
      final furthestAllowed = state.completedSteps.isEmpty
          ? 0
          : state.completedSteps.reduce((a, b) => a > b ? a : b) + 1;
      emit(
        state.copyWith(
          activeTabIndex: event.activeTabIndex.clamp(
            0,
            furthestAllowed.clamp(0, 2),
          ),
        ),
      );
      _scheduleDraftSave();
    });

    on<UpdateMessengerIds>((event, emit) {
      emit(
        state.copyWith(
          messengerIds: event.messengerIds,
          dirtySteps: _markDirty(1),
        ),
      );
      _scheduleDraftSave();
    });
    on<SetMarketScheduleEvent>((event, emit) {
      final existingIndex = state.marketSchedules.indexWhere(
        (s) =>
            s.market == event.scheduleModel.market &&
            s.day == event.scheduleModel.day &&
            s.intervalIndex == event.scheduleModel.intervalIndex,
      );

      final updatedSchedules = List<MarketScheduleModel>.from(
        state.marketSchedules,
      );

      if (existingIndex != -1) {
        updatedSchedules[existingIndex] = event.scheduleModel;
      } else {
        updatedSchedules.add(event.scheduleModel);
      }

      emit(
        state.copyWith(
          marketSchedules: updatedSchedules,
          dirtySteps: _markDirty(1),
        ),
      );
      _scheduleDraftSave();
    });

    on<RemoveMarketScheduleEvent>((event, emit) {
      emit(
        state.copyWith(
          marketSchedules: state.marketSchedules
              .where(
                (item) =>
                    item.day != event.day ||
                    item.intervalIndex != event.intervalIndex,
              )
              .toList(growable: false),
          dirtySteps: _markDirty(1),
        ),
      );
      _scheduleDraftSave();
    });

    //set market type
    on<SetMarketType>((event, emit) {
      emit(
        state.copyWith(
          marketType: event.marketType,
          dirtySteps: _markDirty(0),
        ),
      );
      _scheduleDraftSave();
    });

    on<CreateMarket>(_createOrUpdateMarketDraft);

    on<ChangeHasWorkTime>((event, emit) {
      emit(
        state.copyWith(
          hasWorkTime: event.hasWorkTime,
          dirtySteps: _markDirty(1),
        ),
      );
      _scheduleDraftSave();
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
          provinceList: event.countryId != null ? const <CountryModel>[] : null,
          cityList: event.countryId != null || event.provinceId != null
              ? const <CountryModel>[]
              : null,
          dirtySteps: _markDirty(2),
        ),
      );
      _scheduleDraftSave();
    });

    on<CalPrice>(_calPrice);

    on<SetDiscount>(_setDiscount);

    on<PayPrice>(_payPrice);
    on<StartSubscriptionPayment>(_startSubscriptionPayment);

    on<ChangeSelectedCategory>((event, emit) {
      emit(
        state.copyWith(
          activeCategoryId: event.activeCategoryId,
          selectedCategoryName: event.selectedCategoryName,
          dirtySteps: _markDirty(0),
        ),
      );
      _scheduleDraftSave();
    });

    //region
    on<LoadCountry>(_getCountries);
    on<LoadProvince>(_getProvinces);
    on<LoadCity>(_getCities);
  }

  Future<void> _initializeWorkspace(
    InitializeWorkspace event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    final market = event.market;
    final marketId = market?.id?.trim() ?? '';
    final isEditing = marketId.isNotEmpty;
    _draftMarketId = isEditing ? marketId : null;

    var nextState = CreateWorkSpaceState.initial().copyWith(
      sessionToken: event.sessionToken,
      formMode: isEditing ? WorkspaceFormMode.edit : WorkspaceFormMode.create,
      marketId: marketId,
      businessId: market?.businessId ?? '',
      name: market?.name ?? '',
      subCategory: market?.subCategory ?? '0',
      activeCategoryId: market?.subCategory ?? '',
      selectedCategoryName:
          market?.subCategoryTitle ??
          CreateWorkSpaceState.initial().selectedCategoryName,
      syncStatus: isEditing
          ? WorkspaceSyncStatus.syncing
          : WorkspaceSyncStatus.localOnly,
    );
    emit(nextState);

    final localDraft = await draftRepository.load(marketId: _draftMarketId);
    if (state.sessionToken != event.sessionToken) return;
    if (localDraft != null) {
      nextState = _stateFromDraft(nextState, localDraft).copyWith(
        formMode: isEditing ? WorkspaceFormMode.edit : WorkspaceFormMode.create,
        marketId: isEditing ? marketId : null,
        isDraftLoaded: false,
      );
      emit(nextState);
    }

    if (!isEditing) {
      emit(nextState.copyWith(isDraftLoaded: true));
      return;
    }

    final results = await Future.wait<dynamic>([
      marketRepo.getMarketBase(marketId),
      marketRepo.getMarketContact(marketId),
      marketRepo.getMarketLocation(marketId),
      marketRepo.getMarketSchedules(marketId),
    ]).timeout(
      const Duration(seconds: 6),
      onTimeout: () => List<dynamic>.filled(
        4,
        Failure(code: 301, errorResponse: 'Server unavailable'),
      ),
    );
    final baseResult = results[0];
    if (state.sessionToken != event.sessionToken) return;
    final contactResult = results[1];
    final locationResult = results[2];
    final schedulesResult = results[3];

    var loadedFromServer = false;
    var contactExists = nextState.contactExists;
    var locationExists = nextState.locationExists;
    Map<String, dynamic>? pendingContact;
    Map<String, dynamic>? pendingLocation;

    if (baseResult is Success && baseResult.response is Map) {
      loadedFromServer = true;
      final base = Map<String, dynamic>.from(baseResult.response as Map);
      final pending = base['pending_revision'];
      if (pending is Map && pending['payload'] is Map) {
        base.addAll(Map<String, dynamic>.from(pending['payload'] as Map));
      }
      if (!nextState.dirtySteps.contains(0)) {
        nextState = nextState.copyWith(
          marketType: _mapString(base, 'type', nextState.marketType),
          businessId: _mapString(base, 'business_id', nextState.businessId),
          name: _mapString(base, 'name', nextState.name),
          description: _mapString(base, 'description', nextState.description),
          subCategory: _mapString(base, 'sub_category', nextState.subCategory),
          activeCategoryId: _mapString(
            base,
            'sub_category',
            nextState.activeCategoryId,
          ),
          slogan: _mapString(base, 'slogan', nextState.slogan),
          idCode: _mapString(base, 'national_code', nextState.idCode),
        );
      }

      final pendingPayload = pending is Map ? pending['payload'] : null;
      if (pendingPayload is Map && pendingPayload['contact'] is Map) {
        pendingContact = Map<String, dynamic>.from(
          pendingPayload['contact'] as Map,
        );
      }
      if (pendingPayload is Map && pendingPayload['location'] is Map) {
        pendingLocation = Map<String, dynamic>.from(
          pendingPayload['location'] as Map,
        );
      }
    }

    if (contactResult is Success && contactResult.response is Map) {
      loadedFromServer = true;
      contactExists = true;
      if (!nextState.dirtySteps.contains(1)) {
        nextState = _applyContact(
          nextState,
          Map<String, dynamic>.from(contactResult.response as Map),
        );
      }
    } else if (contactResult is Failure && contactResult.code == 404) {
      contactExists = false;
    }

    if (locationResult is Success && locationResult.response is Map) {
      loadedFromServer = true;
      locationExists = true;
      if (!nextState.dirtySteps.contains(2)) {
        nextState = _applyLocation(
          nextState,
          Map<String, dynamic>.from(locationResult.response as Map),
        );
      }
    } else if (locationResult is Failure && locationResult.code == 404) {
      locationExists = false;
    }

    if (schedulesResult is Success && schedulesResult.response is List) {
      loadedFromServer = true;
      if (!nextState.dirtySteps.contains(1)) {
        final schedules = (schedulesResult.response as List)
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .map(MarketScheduleModel.fromJson)
            .toList(growable: false);
        nextState = nextState.copyWith(
          marketSchedules: schedules,
          hasWorkTime: schedules.isNotEmpty,
        );
      }
    }

    if (pendingContact != null && !nextState.dirtySteps.contains(1)) {
      nextState = _applyContact(nextState, pendingContact);
    }
    if (pendingLocation != null && !nextState.dirtySteps.contains(2)) {
      nextState = _applyLocation(nextState, pendingLocation);
    }

    emit(
      nextState.copyWith(
        formMode: WorkspaceFormMode.edit,
        marketId: marketId,
        activeTabIndex: 0,
        completedSteps: const {0, 1, 2},
        isDraftComplete: true,
        isDraftLoaded: true,
        paymentStatus: SubscriptionPaymentStatus.unpaid,
        paymentRedirectUrl: '',
        contactExists: contactExists,
        locationExists: locationExists,
        syncStatus: loadedFromServer && nextState.dirtySteps.isEmpty
            ? WorkspaceSyncStatus.synced
            : WorkspaceSyncStatus.localOnly,
      ),
    );
    _scheduleDraftSave();
  }

  String _mapString(
    Map<String, dynamic> values,
    String key,
    String fallback,
  ) {
    if (!values.containsKey(key)) return fallback;
    return values[key]?.toString() ?? '';
  }

  Set<int> _markDirty(int step) {
    return state.isEditing ? {...state.dirtySteps, step} : state.dirtySteps;
  }

  Set<int> _clearDirty(int step) {
    return {...state.dirtySteps}..remove(step);
  }

  CreateWorkSpaceState _applyContact(
    CreateWorkSpaceState current,
    Map<String, dynamic> contact,
  ) {
    final messengerIds = contact['messenger_ids'];
    return current.copyWith(
      phoneNumber1: _mapString(
        contact,
        'first_mobile_number',
        current.phoneNumber1,
      ),
      phoneNumber2: _mapString(
        contact,
        'second_mobile_number',
        current.phoneNumber2,
      ),
      telephone: _mapString(contact, 'telephone', current.telephone),
      fax: _mapString(contact, 'fax', current.fax),
      email: _mapString(contact, 'email', current.email),
      websiteUrl: _mapString(contact, 'website_url', current.websiteUrl),
      messengerIds: messengerIds is Map
          ? MessengerIds.fromJson(Map<String, dynamic>.from(messengerIds))
          : current.messengerIds,
    );
  }

  CreateWorkSpaceState _applyLocation(
    CreateWorkSpaceState current,
    Map<String, dynamic> location,
  ) {
    return current.copyWith(
      country: _mapString(location, 'country_name', current.country),
      countryId: _mapString(location, 'country', current.countryId),
      province: _mapString(location, 'province_name', current.province),
      provinceId: _mapString(location, 'province', current.provinceId),
      city: _mapString(location, 'city_name', current.city),
      cityId: _mapString(location, 'city', current.cityId),
      address: _mapString(location, 'address', current.address),
      postalCode: _mapString(location, 'zip_code', current.postalCode),
      latitude: _mapString(location, 'latitude', current.latitude),
      longitude: _mapString(location, 'longitude', current.longitude),
    );
  }

  //market contact
  Future<void> _setMarketContact(
    MarketContact event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    emit(
      state.copyWith(
        phoneNumber1: event.phoneNumber1,
        phoneNumber2: event.phoneNumber2,
        telephone: event.telephone,
        fax: event.fax,
        email: event.email,
        websiteUrl: event.websiteUrl,
        messengerIds: event.messengerIds,
        syncStatus: state.marketId?.isNotEmpty == true
            ? WorkspaceSyncStatus.syncing
            : WorkspaceSyncStatus.localOnly,
      ),
    );

    final marketId = state.marketId ?? '';
    if (marketId.isNotEmpty) {
      final contact = MarketContactModel(
        market: marketId,
        firstMobileNumber: event.phoneNumber1,
        secondMobileNumber: event.phoneNumber2,
        telephone: event.telephone,
        fax: event.fax,
        email: event.email,
        websiteUrl: event.websiteUrl,
        messengerIds: event.messengerIds,
      );
      final result = state.contactExists
          ? await marketRepo.updateMarketContact(contact)
          : await marketRepo.createMarketContact(contact);
      if (result is! Success && !(result is Failure && result.code == 301)) {
        emit(
          state.copyWith(
            syncStatus: WorkspaceSyncStatus.failure,
            error: result is Failure
                ? result.errorResponse.toString()
                : 'Unable to save contact information.',
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          contactExists: result is Success || state.contactExists,
          syncStatus: result is Success
              ? WorkspaceSyncStatus.synced
              : WorkspaceSyncStatus.localOnly,
        ),
      );
    }
    emit(
      state.copyWith(
        activeTabIndex: 2,
        completedSteps: {...state.completedSteps, 1},
      ),
    );
    _scheduleDraftSave();
  }

  //market location
  Future<void> _setMarketLocation(
    SaveMarketLocationEvent event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    final contactSectionSynced =
        state.syncStatus == WorkspaceSyncStatus.synced;
    emit(
      state.copyWith(
        address: event.address,
        postalCode: event.postalCode,
        submitStatus: WorkspaceSubmitStatus.submitting,
        syncStatus: state.marketId?.isNotEmpty == true
            ? WorkspaceSyncStatus.syncing
            : WorkspaceSyncStatus.localOnly,
      ),
    );

    final marketId = state.marketId ?? '';
    if (marketId.isNotEmpty) {
      final location = MarketLocationModel(
        market: marketId,
        city: state.cityId,
        address: event.address,
        zipCode: event.postalCode,
        latitude: state.latitude,
        longitude: state.longitude,
      );
      final locationResult = state.locationExists
          ? await marketRepo.updateMarketLocation(location)
          : await marketRepo.createMarketLocation(location);
      var savedLocally =
          locationResult is Failure && locationResult.code == 301;
      final remainingDirty = {...state.dirtySteps};
      if (locationResult is Success) {
        remainingDirty.remove(2);
      }
      if (locationResult is! Success &&
          !(locationResult is Failure && locationResult.code == 301)) {
        emit(
          state.copyWith(
            syncStatus: WorkspaceSyncStatus.failure,
            submitStatus: WorkspaceSubmitStatus.failure,
            error: locationResult is Failure
                ? locationResult.errorResponse.toString()
                : 'Unable to save store location.',
          ),
        );
        return;
      }

      if (locationResult is Success) {
        final result = await marketRepo.replaceSchedules(
          marketId,
          state.marketSchedules
              .map(
                (schedule) => {
                  'day': schedule.day,
                  'interval_index': schedule.intervalIndex,
                  'start': schedule.start,
                  'end': schedule.end,
                },
              )
              .toList(),
        );
        if (result is! Success) {
          if (result is Failure && result.code == 301) {
            savedLocally = true;
          }
          emit(
            state.copyWith(
              syncStatus: result is Failure && result.code == 301
                  ? WorkspaceSyncStatus.localOnly
                  : WorkspaceSyncStatus.failure,
              submitStatus: result is Failure && result.code == 301
                  ? WorkspaceSubmitStatus.submitting
                  : WorkspaceSubmitStatus.failure,
              error: result is Failure
                  ? result.errorResponse.toString()
                  : 'Unable to save working hours.',
            ),
          );
          if (result is! Failure || result.code != 301) return;
        } else if (contactSectionSynced) {
          remainingDirty.remove(1);
        }
      }
      emit(
        state.copyWith(
          locationExists: locationResult is Success || state.locationExists,
          dirtySteps: remainingDirty,
          syncStatus: savedLocally || remainingDirty.isNotEmpty
              ? WorkspaceSyncStatus.localOnly
              : WorkspaceSyncStatus.synced,
        ),
      );
    }
    emit(
      state.copyWith(
        isDraftComplete: true,
        submitStatus: WorkspaceSubmitStatus.success,
        completedSteps: {...state.completedSteps, 2},
      ),
    );
    _scheduleDraftSave();
  }

  _calPrice(CalPrice event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(submitStatus: WorkspaceSubmitStatus.idle));
  }

  _setDiscount(SetDiscount event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(submitStatus: WorkspaceSubmitStatus.idle));
  }

  _payPrice(PayPrice event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(submitStatus: WorkspaceSubmitStatus.idle));
  }

  Future<void> _createOrUpdateMarketDraft(
    CreateMarket event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    emit(
      state.copyWith(
        marketType: event.marketType,
        businessId: event.businessId,
        name: event.name,
        description: event.description,
        subCategory: event.subCategory,
        slogan: event.slogan,
        idCode: event.idCode,
        syncStatus: WorkspaceSyncStatus.syncing,
        error: '',
      ),
    );

    final result = state.marketId == null || state.marketId!.isEmpty
        ? await marketRepo.createMarketBase(
            event.marketType,
            event.businessId,
            event.name,
            event.description,
            event.subCategory,
            event.slogan,
            event.idCode,
          )
        : await marketRepo.updateMarketBase(
            state.marketId!,
            event.marketType,
            event.businessId,
            event.name,
            event.description,
            event.subCategory,
            event.slogan,
            event.idCode,
          );

    if (result is Success) {
      final response = result.response;
      final serverId = response is Map
          ? (response['market'] ?? response['id'])?.toString()
          : null;
      emit(
        state.copyWith(
          marketId: serverId ?? state.marketId,
          dirtySteps: _clearDirty(0),
          syncStatus: WorkspaceSyncStatus.synced,
          activeTabIndex: 1,
          completedSteps: {...state.completedSteps, 0},
        ),
      );
    } else if (result is Failure && result.code == 301) {
      emit(
        state.copyWith(
          syncStatus: WorkspaceSyncStatus.localOnly,
          activeTabIndex: 1,
          completedSteps: {...state.completedSteps, 0},
        ),
      );
    } else {
      emit(
        state.copyWith(
          syncStatus: WorkspaceSyncStatus.failure,
          error: result is Failure
              ? result.errorResponse.toString()
              : 'Unable to save store draft.',
        ),
      );
    }
    _scheduleDraftSave();
  }

  Future<void> _startSubscriptionPayment(
    StartSubscriptionPayment event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    final marketId = state.marketId;
    if (marketId == null || marketId.isEmpty || !state.isDraftComplete) {
      emit(
        state.copyWith(
          paymentStatus: SubscriptionPaymentStatus.failure,
          error: 'Store draft must be synced and completed before payment.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        paymentStatus: SubscriptionPaymentStatus.creatingSession,
        error: '',
      ),
    );
    final result = await marketRepo.createSubscriptionPayment(marketId);
    if (result is Success && result.response is Map) {
      final sessionId = (result.response as Map)['id']?.toString() ?? '';
      if (sessionId.isNotEmpty) {
        emit(
          state.copyWith(
            paymentStatus: SubscriptionPaymentStatus.pending,
            paymentRedirectUrl: Endpoints.paymentRedirect(sessionId),
          ),
        );
        _scheduleDraftSave();
        return;
      }
    }
    emit(
      state.copyWith(
        paymentStatus: SubscriptionPaymentStatus.failure,
        error: result is Failure
            ? result.errorResponse.toString()
            : 'Unable to create payment session.',
      ),
    );
  }

  Future<void> _loadDraft(
    LoadWorkspaceDraft event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    final draft = await draftRepository.load(marketId: _draftMarketId);
    if (draft == null) {
      emit(state.copyWith(isDraftLoaded: true));
      return;
    }

    emit(_stateFromDraft(state, draft));
  }

  CreateWorkSpaceState _stateFromDraft(
    CreateWorkSpaceState current,
    WorkspaceDraft draft,
  ) {
    final values = draft.values;
    return current.copyWith(
      isDraftLoaded: true,
      activeTabIndex: draft.currentStep.clamp(0, 2).toInt(),
      completedSteps: draft.completedSteps,
      dirtySteps: (values['dirtySteps'] ?? '')
          .split(',')
          .map(int.tryParse)
          .whereType<int>()
          .toSet(),
      marketId: values['marketId'],
      marketType: values['marketType'],
      businessId: values['businessId'],
      name: values['name'],
      description: values['description'],
      subCategory: values['subCategory'],
      slogan: values['slogan'],
      idCode: values['idCode'],
      phoneNumber1: values['phoneNumber1'],
      phoneNumber2: values['phoneNumber2'],
      telephone: values['telephone'],
      fax: values['fax'],
      email: values['email'],
      websiteUrl: values['websiteUrl'],
      messengerIds: MessengerIds.fromJson(draft.socialLinks),
      hasWorkTime: values['hasWorkTime'] == 'true',
      country: values['country'],
      countryId: values['countryId'],
      province: values['province'],
      provinceId: values['provinceId'],
      city: values['city'],
      cityId: values['cityId'],
      address: values['address'],
      postalCode: values['postalCode'],
      latitude: values['latitude'],
      longitude: values['longitude'],
      activeCategoryId: values['activeCategoryId'],
      selectedCategoryName: values['selectedCategoryName'],
      syncStatus: values['syncStatus'] == WorkspaceSyncStatus.synced.name
          ? WorkspaceSyncStatus.synced
          : WorkspaceSyncStatus.localOnly,
      paymentStatus:
          values['paymentStatus'] == SubscriptionPaymentStatus.pending.name
          ? SubscriptionPaymentStatus.pending
          : SubscriptionPaymentStatus.unpaid,
      paymentRedirectUrl: values['paymentRedirectUrl'],
      contactExists: values['contactExists'] == 'true',
      locationExists: values['locationExists'] == 'true',
      marketSchedules: draft.schedules
          .map(
            (item) => MarketScheduleModel(
              market: values['marketId'] ?? '',
              day: item.day,
              intervalIndex: item.intervalIndex,
              start: item.start,
              end: item.end,
            ),
          )
          .toList(growable: false),
    );
  }

  void _scheduleDraftSave() {
    _draftSaveTimer?.cancel();
    _draftSaveTimer = Timer(const Duration(milliseconds: 400), () {
      if (!isClosed) add(const PersistWorkspaceDraft());
    });
  }

  Future<void> _persistDraft(
    PersistWorkspaceDraft event,
    Emitter<CreateWorkSpaceState> emit,
  ) async {
    emit(state.copyWith(draftSaveStatus: DraftSaveStatus.saving));
    try {
      await draftRepository.save(_createDraft(), marketId: _draftMarketId);
      emit(state.copyWith(draftSaveStatus: DraftSaveStatus.saved));
    } catch (error) {
      emit(
        state.copyWith(
          draftSaveStatus: DraftSaveStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  WorkspaceDraft _createDraft() {
    final socialLinks = <String, String>{};
    state.messengerIds.toJson().forEach((key, value) {
      if (value is String && value.isNotEmpty) socialLinks[key] = value;
    });

    return WorkspaceDraft(
      currentStep: state.activeTabIndex,
      completedSteps: state.completedSteps,
      values: {
        'marketId': state.marketId ?? '',
        'marketType': state.marketType,
        'businessId': state.businessId,
        'name': state.name,
        'description': state.description,
        'subCategory': state.subCategory,
        'slogan': state.slogan,
        'idCode': state.idCode,
        'phoneNumber1': state.phoneNumber1,
        'phoneNumber2': state.phoneNumber2,
        'telephone': state.telephone,
        'fax': state.fax,
        'email': state.email,
        'websiteUrl': state.websiteUrl,
        'hasWorkTime': state.hasWorkTime.toString(),
        'country': state.country,
        'countryId': state.countryId,
        'province': state.province,
        'provinceId': state.provinceId,
        'city': state.city,
        'cityId': state.cityId,
        'address': state.address,
        'postalCode': state.postalCode,
        'latitude': state.latitude,
        'longitude': state.longitude,
        'activeCategoryId': state.activeCategoryId,
        'selectedCategoryName': state.selectedCategoryName,
        'syncStatus': state.syncStatus.name,
        'paymentStatus': state.paymentStatus.name,
        'paymentRedirectUrl': state.paymentRedirectUrl,
        'contactExists': state.contactExists.toString(),
        'locationExists': state.locationExists.toString(),
        'dirtySteps': state.dirtySteps.join(','),
      },
      socialLinks: socialLinks,
      schedules: state.marketSchedules
          .map(
            (item) => WorkspaceSchedule(
              day: item.day,
              intervalIndex: item.intervalIndex,
              start: item.start,
              end: item.end,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> close() async {
    _draftSaveTimer?.cancel();
    await draftRepository.save(_createDraft(), marketId: _draftMarketId);
    return super.close();
  }

  //--------------- Region ----------
  //list of countries
  _getCountries(LoadCountry event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(regionLoadStatus: RegionLoadStatus.loadingCountries));
    try {
      final res = await regionRepo.getCountryList();

      if (res is Success) {
        var resp = res.response as List;
        final countryList = resp.map((e) => CountryModel.fromJson(e)).toList();

        emit(
          state.copyWith(
            regionLoadStatus: RegionLoadStatus.success,
            countryList: countryList,
          ),
        );
      } else {
        emit(state.copyWith(regionLoadStatus: RegionLoadStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(regionLoadStatus: RegionLoadStatus.failure));
    }
  }

  //list of provinces
  _getProvinces(LoadProvince event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(regionLoadStatus: RegionLoadStatus.loadingProvinces));
    try {
      final res = await regionRepo.getProvinceList(event.countryId);
      if (res is Success) {
        var resp = res.response as List;
        final provinceList = resp.map((e) => CountryModel.fromJson(e)).toList();

        emit(
          state.copyWith(
            regionLoadStatus: RegionLoadStatus.success,
            provinceList: provinceList,
          ),
        );
      } else {
        emit(state.copyWith(regionLoadStatus: RegionLoadStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(regionLoadStatus: RegionLoadStatus.failure));
    }
  }

  //list of cities
  _getCities(LoadCity event, Emitter<CreateWorkSpaceState> emit) async {
    emit(state.copyWith(regionLoadStatus: RegionLoadStatus.loadingCities));
    try {
      final res = await regionRepo.getCityList(event.provinceId);
      if (res is Success) {
        var resp = res.response as List;
        final cityList = resp.map((e) => CountryModel.fromJson(e)).toList();

        emit(
          state.copyWith(
            regionLoadStatus: RegionLoadStatus.success,
            cityList: cityList,
          ),
        );
      } else {
        emit(state.copyWith(regionLoadStatus: RegionLoadStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(regionLoadStatus: RegionLoadStatus.failure));
    }
  }
}
