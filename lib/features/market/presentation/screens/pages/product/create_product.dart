import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:asood/features/market/presentation/blocs/bloc/market_bloc.dart';
import 'package:asood/features/market/presentation/widgets/create_product/active_broadcast_widget.dart';
import 'package:asood/features/market/presentation/widgets/create_product/category_selection_section.dart';
import 'package:asood/features/market/presentation/widgets/create_product/discount_builder.dart';
import 'package:asood/features/market/presentation/widgets/create_product/keyword_builder_widget.dart';
import 'package:asood/features/market/presentation/widgets/create_product/price_widget.dart';
import 'package:asood/features/market/presentation/widgets/create_product/product_pic_section.dart';
import 'package:asood/features/market/presentation/widgets/create_product/product_type_widget.dart';
import 'package:asood/features/market/presentation/widgets/create_product/publish_status_section.dart';
import 'package:asood/features/market/presentation/widgets/create_product/select_gift_extra.dart';
import 'package:asood/features/market/presentation/widgets/create_product/select_sell_type_section.dart';
import 'package:asood/features/market/presentation/widgets/create_product/select_tag_section.dart';
import 'package:asood/features/market/presentation/widgets/create_product/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({
    super.key,
    required this.marketId,
    required this.themeId,
    required this.themeIndex,
  });

  final String marketId;
  final String themeId;
  final int themeIndex;
  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  late AddProductBloc bloc;

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController technicalDescription = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<AddProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            if (state.status == CWSStatus.success) {
              context.read<MarketBloc>().add(
                LoadTemplateEvent(marketId: widget.marketId),
              );
              context.pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colora.borderAvatar,
                  content: Text(
                    "کالا با موفقیت ثبت شد",
                    style: TextStyle(color: Colora.scaffold),
                  ),
                ),
              );
            }
            if (state.status == CWSStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colora.borderAvatar,
                  content: Text(
                    "خطا در برقراری ارتباط",
                    style: TextStyle(color: Colora.scaffold),
                  ),
                ),
              );
            }
          },
          builder:
              (context, state) => Scaffold(
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: Dimensions.height * 0.13),

                            // select produ
                            //ct or service
                            ProductTypeWidget(),

                            //is marketer
                            ActiveBroadcastWidget(),

                            Container(
                              width: Dimensions.width,
                              margin: EdgeInsets.only(
                                bottom: Dimensions.height * 0.03,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height * 0.03,
                                horizontal: Dimensions.width * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: Colora.primaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  //name
                                  CustomTextField(
                                    controller: name,
                                    isRequired: true,
                                    onChanged: (value) {
                                      bloc.add(
                                        UpdateProductDetailEvent(
                                          productName: value,
                                        ),
                                      );
                                    },
                                    text: "نام کالا",
                                  ),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //description
                                  CustomTextField(
                                    isRequired: false,
                                    controller: description,
                                    text: "توضیحات کالا",
                                    maxLine: 6,
                                    onChanged: (value) {
                                      bloc.add(
                                        UpdateProductDetailEvent(
                                          productDescription: value,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: Dimensions.height * 0.01),

                                  //technical description
                                  CustomTextField(
                                    isRequired: false,
                                    controller: technicalDescription,
                                    text: "مشخصات فنی کالا",
                                    maxLine: 6,
                                    onChanged: (value) {
                                      bloc.add(
                                        UpdateProductDetailEvent(
                                          productTechnicalDescription: value,
                                        ),
                                      );
                                    },
                                  ),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //category
                                  CategorySelectionSection(),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //keywords
                                  KeywordBuilderWidget(),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //stock
                                  StockWidget(),
                                  SizedBox(height: Dimensions.height * 0.01),

                                  //price
                                  SizedBox(height: Dimensions.height * 0.01),
                                  PriceWidget(),

                                  //discount
                                  DiscountBuilder(),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //gift and extra product
                                  SelectGiftExtraProductWidget(
                                    marketId: widget.marketId,
                                  ),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //tag section
                                  SelectTagSection(),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //sell section
                                  SelectSellTypeSection(),

                                  //post price
                                  if (state.productSendPrice ==
                                      SendPriceEnum.customer) ...[
                                    // CustomerPostpriceSection(),
                                  ],

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //pic
                                  ProductPicSection(),

                                  SizedBox(height: Dimensions.height * 0.01),

                                  //publish or not
                                  PublishStatusSection(),

                                  SizedBox(height: Dimensions.height * 0.02),

                                  //save
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      // height: Dimensions.height * 0.06,
                                      decoration: BoxDecoration(
                                        color: Colora.scaffold,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width * 0.015,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width * 0.05,
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (state.productName.isEmpty ||
                                              state
                                                  .productDescription
                                                  .isEmpty ||
                                              state
                                                  .productTechnicalDescription
                                                  .isEmpty ||
                                              state
                                                  .selectedCategoryId
                                                  .isEmpty ||
                                              state.keywords.isEmpty ||
                                              (state.productStockEnable ==
                                                      true &&
                                                  state.productStock == 0) ||
                                              state.selectedCategoryImage ==
                                                  null) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                backgroundColor:
                                                    Colora.borderAvatar,
                                                content: Text(
                                                  "لطفا فیلدهای مورد نظر را پر کنید",
                                                  style: TextStyle(
                                                    color: Colora.scaffold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if ((state.productGift ==
                                                      true &&
                                                  state.selectedProductGift ==
                                                      null) ||
                                              (state.productExtra == true &&
                                                  state.selectedProductExtra ==
                                                      null)) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                backgroundColor:
                                                    Colora.borderAvatar,
                                                content: Text(
                                                  "لطفا یک جنس هدیه یا اضافه انتخاب کنید",
                                                  style: TextStyle(
                                                    color: Colora.scaffold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            bloc.add(
                                              SubmitNewProductEvent(
                                                market: widget.marketId,
                                                name: name.text,
                                                description: description.text,
                                                technicalDetail:
                                                    technicalDescription.text,
                                                themeId: widget.themeId,
                                                themeIndex:
                                                    widget.themeIndex
                                                        .toString(),
                                              ),
                                            );
                                          }
                                        },
                                        child:
                                            state.status == CWSStatus.loading
                                                ? const CircularProgressIndicator(
                                                  color: Colora.primaryColor,
                                                )
                                                : Text(
                                                  'ثبت اطلاعات',
                                                  style: TextStyle(
                                                    color: Colora.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Dimensions.width *
                                                        0.036,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const NewAppBar(title: 'افزودن کالا و خدمات'),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
