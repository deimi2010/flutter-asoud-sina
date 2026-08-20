import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/market/presentation/widgets/gateway_connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void paymentDialog(BuildContext context) {
  final marketId = context.read<CreateWorkSpaceBloc>().state.marketId;
  showGatewayConnectionDialog(context, marketId: marketId ?? '');
}
