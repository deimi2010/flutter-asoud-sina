import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';

class KeywordBuilderWidget extends StatefulWidget {
  const KeywordBuilderWidget({super.key});

  @override
  State<KeywordBuilderWidget> createState() => _KeywordBuilderWidgetState();
}

class _KeywordBuilderWidgetState extends State<KeywordBuilderWidget> {
  final TextEditingController tagSearch = TextEditingController();

  onSubmit(BuildContext context) {
    if (context.read<AddProductBloc>().state.keywords.contains(
      tagSearch.text,
    )) {
      showSnackBar(context, "این کلمه قبلا اضافه شده است");
    } else {
      context.read<AddProductBloc>().add(
        AddKeywordsEvent(keyword: tagSearch.text),
      );
      tagSearch.clear();
    }
  }

  @override
  void dispose() {
    tagSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: Dimensions.width,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.06),
          decoration: BoxDecoration(
            color: Colora.scaffold,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tagSearch,
                      onSubmitted: (value) {
                        onSubmit(context);
                      },
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 5,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colora.primaryColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colora.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.01,
                      horizontal: Dimensions.width * 0.03,
                    ),
                    child: InkWell(
                      onTap: () => onSubmit(context),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'افزودن به کلمات',
                          style: TextStyle(
                            color: Colora.scaffold,
                            fontSize: Dimensions.width * 0.033,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: state.keywords.isEmpty ? 0 : Dimensions.height * 0.06,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.keywords.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:
                      (context, index) => Container(
                        margin: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.01,
                          horizontal: Dimensions.width * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            context.read<AddProductBloc>().add(
                              RemoveKeywordsEvent(
                                keyword: state.keywords[index],
                              ),
                            );
                          },
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(
                                Icons.close,
                                color: Colora.scaffold,
                                size: Dimensions.width * 0.05,
                              ),
                              Text(
                                state.keywords[index],
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontSize: Dimensions.width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
