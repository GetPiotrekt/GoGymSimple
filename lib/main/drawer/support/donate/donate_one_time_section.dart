import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import 'donate.dart';

class DonateOneTimeSection extends StatefulWidget {
  const DonateOneTimeSection({super.key});

  @override
  State<DonateOneTimeSection> createState() => _DonateOneTimeSectionState();
}

class _DonateOneTimeSectionState extends State<DonateOneTimeSection> {
  final List<String> _productIds = [
    '1onetimedonation',
    '2onetimedonation',
    '3onetimedonation',
    '4onetimedonation',
    '5onetimedonation',
    '6onetimedonation',
  ];

  Map<String, ProductDetails> _productsById = {};
  String? selectedProductId;
  bool _isLoading = true;
  bool _isStoreAvailable = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      setState(() {
        _isStoreAvailable = false;
        _isLoading = false;
      });
      return;
    }

    final ProductDetailsResponse response = await InAppPurchase.instance
        .queryProductDetails(_productIds.toSet());

    if (response.error != null || response.productDetails.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _productsById = {
        for (var p in response.productDetails) p.id: p,
      };
      _isLoading = false;
    });
  }

  void _buyProduct(ProductDetails productDetails) {
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<ColorProvider>();

    return DonateShared(
      icon: Icons.attach_money,
      title: AppLocalizations.of(context)!.donateSections_oneTimeTitle,
      colorProvider: c,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_isStoreAvailable
          ? Text(
        AppLocalizations.of(context)!
            .donateSections_storeUnavailableMessage,
        style: TextStyle(color: c.accent.withOpacity(0.7)),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!
                .donateSections_oneTimeDesc,
            style: TextStyle(color: c.accent.withOpacity(0.7)),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.8,
            children: _productsById.entries.map((entry) {
              final id = entry.key;
              final product = entry.value;
              final label = product.price;

              return _amountChip(
                context,
                id,
                label,
                selected: selectedProductId == id,
                onSelected: () {
                  setState(() {
                    selectedProductId =
                    selectedProductId == id ? null : id;
                  });
                },
              );
            }).toList(),
          ),
          if (selectedProductId != null) const SizedBox(height: 8),
          if (selectedProductId != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final product = _productsById[selectedProductId];
                  if (product != null) {
                    _buyProduct(product);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: c.accent,
                  foregroundColor: c.secondary,
                ),
                child: Text(
                  AppLocalizations.of(context)!
                      .donateSections_oneTimeButton,
                  style: TextStyle(color: c.secondary),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _amountChip(
      BuildContext context,
      String id,
      String label, {
        required bool selected,
        required VoidCallback onSelected,
      }) {
    final cp = context.read<ColorProvider>();

    return SizedBox(
      width: 95,
      height: 36,
      child: FilterChip(
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Center(child: Text(label)),
        ),
        selected: selected,
        onSelected: (_) => onSelected(),
        checkmarkColor: cp.secondary,
        selectedColor: cp.accent,
        backgroundColor: cp.secondary,
        side: BorderSide(color: cp.accent.withOpacity(0.5), width: 1.5),
        labelStyle: TextStyle(
          color: selected ? cp.secondary : cp.accent.withOpacity(0.5),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
