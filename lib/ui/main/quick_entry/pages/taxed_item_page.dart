import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../../../../models/taxed_nontaxed_item.dart';
import '../../../widgets/fm_dialog.dart';
import '../../../widgets/non_tax_item_dialog.dart';
import '../../../widgets/tax_item_dialog.dart';
import '../quick_entry_controller.dart';

class TaxedItemPage extends StatelessWidget {
  TaxedItemPage({Key? key}) : super(key: key);

  final controller = Get.find<QuickEntryController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<QuickEntryController>(builder: (ctrl) {
        return Column(
          children: [
            Row(
              children: [
                "Taxed Items".text(fontSize: 18),
              ],
            ).paddingOnly(
              left: screenWPadding16.sw(),
              bottom: screenHPadding8.sh(),
            ),
            _taxedItemTable(context, ctrl),
            Row(
              children: [
                "Non-Tax Items".text(fontSize: 18),
              ],
            ).paddingOnly(
              left: screenWPadding16.sw(),
              bottom: screenHPadding8.sh(),
              top: screenHPadding16.sh(),
            ),
            _nonTaxedItems(context, ctrl),
            FmButton(
              ontap: () {
                controller.finishButtonClick(context);
              },
              name: finish,
            )
                .paddingOnly(
                  left: screenWPadding16.sw(),
                  right: screenWPadding16.sw(),
                )
                .paddingOnly(top: 60)
          ],
        );
      }),
    );
  }

  void showNonTaxItems(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
      child: NonTaxItemDialog(
        onAddClick: (item) {
          controller.nonTaxedItems.add(item);
          controller.update();
        },
      ),
    ).whenComplete(() {
      Get.find<NonTaxItemDialogController>().whenDialogClose();
    });
  }

  void showTaxedItems(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
      child: TaxItemDialog(
        onAddClick: (TaxedNonTaxedModel model) {
          controller.taxedItems.add(model);
          controller.update();
        },
      ),
    ).whenComplete(() {
      Get.find<TaxedItemDialogController>().whenDialogClose();
    });
  }

  Widget _nonTaxedItems(BuildContext context, QuickEntryController ctrl) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _titleItem(),
              Container(
                width: Get.width,
                height: 1,
                color: Colors.black,
              ),
              ListView.builder(
                itemCount: ctrl.nonTaxedItems.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = ctrl.nonTaxedItems[index];
                  return _childItem(
                    item.type,
                    item.amount,
                    item.timeId.toString(),
                  );
                },
              ),
              Row(
                children: [
                  FmImage.assetImage(
                    path: Assets.iconsPlusicon,
                    height: 20.sh(),
                    width: 20.sw(),
                  ),
                  "Add Non-Taxed Item"
                      .text(
                        fontSize: 16,
                      )
                      .paddingOnly(
                        left: 10,
                      ),
                ],
              ).onTap(() {
                showNonTaxItems(context);
              }).paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding16.sh(),
                bottom: screenHPadding16.sh(),
              )
            ],
          ),
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
        ),
        Row(
          children: [
            ctrl.nonTaxedItemError != null
                ? ctrl.nonTaxedItemError.text(fontColor: redColor)
                : Container(),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: 4.sh(),
        )
      ],
    );
  }

  Widget _taxedItemTable(
    BuildContext context,
    QuickEntryController ctrl,
  ) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _titleItem(),
              Container(
                width: Get.width,
                height: 1,
                color: Colors.black,
              ),
              ListView.builder(
                itemCount: ctrl.taxedItems.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = ctrl.taxedItems[index];
                  return _childItem(
                    item.type,
                    item.amount,
                    item.timeId.toString(),
                  );
                },
              ),
              Row(
                children: [
                  FmImage.assetImage(
                    path: Assets.iconsPlusicon,
                    height: 20.sh(),
                    width: 20.sw(),
                  ),
                  "Taxed Item"
                      .text(
                        fontSize: 16,
                      )
                      .paddingOnly(
                        left: 10,
                      ),
                ],
              ).onTap(() {
                showTaxedItems(context);
              }).paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding16.sh(),
                bottom: screenHPadding16.sh(),
              )
            ],
          ),
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
        ),
        Row(
          children: [
            ctrl.taxedItemError != null
                ? ctrl.taxedItemError.text(fontColor: redColor)
                : Container(),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: 4.sh(),
        )
      ],
    );
  }

  Widget _childItem(
    String? type,
    String? amount,
    String? per, {
    bool showBottomLine = true,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            type.text(
              fontSize: 16,
            ),
            amount.text(
              fontSize: 16,
            ),
            per.text(
              fontSize: 16,
            ),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: screenHPadding16.sw(),
          bottom: screenHPadding16.sw(),
        ),
        showBottomLine
            ? Container(
                width: Get.width,
                height: 1,
                color: borderGreyColor,
              )
            : Container()
      ],
    );
  }

  Widget _titleItem() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            type.text(fontSize: 16, weight: FontWeight.w500),
            amount.text(fontSize: 16, weight: FontWeight.w500),
            per.text(fontSize: 16, weight: FontWeight.w500),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: screenHPadding16.sw(),
          bottom: screenHPadding16.sw(),
        )
      ],
    );
  }
}
