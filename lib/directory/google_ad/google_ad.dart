import 'dart:developer';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class GoogleAd extends StatefulWidget {
  const GoogleAd({Key? key}) : super(key: key);

  @override
  State<GoogleAd> createState() => _GoogleAdState();
}

class _GoogleAdState extends State<GoogleAd> {
  late BannerAd _bannerAd;
  bool isBannerAdLoad = false;
  String bannerADId = "ca-app-pub-5433989628883724/4262768622";

  void Init() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerADId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {},
          onAdFailedToLoad: (ad, error) {
            log(error.message);
            ad.dispose();
          },
          onAdClosed: (ad) {
            _bannerAd.load();
          },
        ),
        request: AdRequest());
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    Init();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  final TextEditingController barcodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Container(
        height: _bannerAd.size.height.toDouble(),
        width: _bannerAd.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            height: 10,
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(1, 1), right: Radius.circular(10)),
            ),
          ),
          TextField(
            controller: barcodeController,
            onChanged: (v) {
              if (v.isNotEmpty) {
                setState(() {});
              }
            },
          ),
          // BarcodeWidget(
          //   data: barcodeController.text,
          //   barcode: Barcode.qrCode(),
          //   padding: EdgeInsets.all(20),
          //   drawText: false,
          // ),
          TextButton(
              onPressed: () {
                GooglePayButton(
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(defaultGooglePay),
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (result) {},
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              child: Text("GPay"))
        ],
      ),
    );
  }

  String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';
  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
}
