// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'workspace_bloc.dart';

sealed class WorkspaceEvent {
  const WorkspaceEvent();
}

class ChangeTabView extends WorkspaceEvent {
  final int activeTabIndex;
  const ChangeTabView({required this.activeTabIndex});
}

//invoice
class ShowInvoice extends WorkspaceEvent {
  final bool isShow;
  const ShowInvoice({required this.isShow});
}

class InvoiceOption extends WorkspaceEvent {
  final int option;
  const InvoiceOption({required this.option});
}

class InvoiceConfirm extends WorkspaceEvent {
  final bool isConfirm;
  const InvoiceConfirm({required this.isConfirm});
}

class LoadStores extends WorkspaceEvent {}

class SelectMarket extends WorkspaceEvent {
  final int marketId;
  const SelectMarket({required this.marketId});
}

class CreateWorkspace extends WorkspaceEvent {}

class UpdateWorkspace extends WorkspaceEvent {}

class DeleteWorkspace extends WorkspaceEvent {}

class GetStoreProducts extends WorkspaceEvent {}

class GetProducts extends WorkspaceEvent {}

class GetSpecialProducts extends WorkspaceEvent {}

class GetComments extends WorkspaceEvent {}

class ContactUs extends WorkspaceEvent {}

class CreateDiscount extends WorkspaceEvent {
  final String title;
  final String des;
  final double percentage;
  final int count;
  const CreateDiscount({
    required this.title,
    required this.des,
    required this.percentage,
    required this.count,
  });
}

class GetDiscounts extends WorkspaceEvent {}

class DeleteDiscount extends WorkspaceEvent {}

class ChangeColorAndFont extends WorkspaceEvent {
  final String font;
  final String fontColor;
  const ChangeColorAndFont({required this.font, required this.fontColor});
}

class ChangeThemeColors extends WorkspaceEvent {
  final String? topColor;
  final String? bottomColor;
  const ChangeThemeColors({this.topColor, this.bottomColor});
}

class ChangeProductTheme extends WorkspaceEvent {
  final int themeId;
  const ChangeProductTheme({required this.themeId});
}

class EditeWorkSpaceInfo extends WorkspaceEvent {}
