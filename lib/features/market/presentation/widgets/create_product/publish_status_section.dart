import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublishStatusSection extends StatelessWidget {
  const PublishStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colora.scaffold,
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.1),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLabel('منتشر شود'),
              Expanded(
                child: RadioListTile<PublishStatusEnum>(
                  value: PublishStatusEnum.published,
                  groupValue: state.publishStatus,
                  onChanged: (value) {
                    context.read<AddProductBloc>().add(
                      UpdatePublishStatusEvent(publishStatus: value!),
                    );
                  },
                  title: const SizedBox.shrink(),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  fillColor: WidgetStateProperty.all(Colora.primaryColor),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              _buildLabel('عدم انتشار'),
              Expanded(
                child: RadioListTile<PublishStatusEnum>(
                  value: PublishStatusEnum.notPublished,
                  groupValue: state.publishStatus,
                  onChanged: (value) {
                    context.read<AddProductBloc>().add(
                      UpdatePublishStatusEvent(publishStatus: value!),
                    );
                  },
                  title: const SizedBox.shrink(),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  fillColor: WidgetStateProperty.all(Colora.primaryColor),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colora.primaryColor,
          fontSize: Dimensions.width * 0.035,
        ),
      ),
    );
  }
}
