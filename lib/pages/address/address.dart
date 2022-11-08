import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jgarden/pages/services/address_services.dart';
import 'package:jgarden/utils/snackbar.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:jgarden/providers/user_provider.dart';
import 'package:jgarden/widgets/big_text.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

enum Address { saved, notSaved }

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  Address _isSaved = Address.saved;
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _stateController =
      TextEditingController(text: 'Kerala');

  List<PaymentItem> paymentItems = [];

  String addressToBeUsed = '';

  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _houseController.dispose();
    _areaController.dispose();
    _townController.dispose();
    _pinController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAdress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));

    Navigator.pop(context);
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAdress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';
    bool isForm = _nameController.text.isNotEmpty ||
        _houseController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _townController.text.isNotEmpty ||
        _pinController.text.isNotEmpty;

    if (isForm) {
      print('hello0');
      if (_addressFormKey.currentState!.validate()) {
        print('hello');
        addressToBeUsed =
            '${_houseController.text}, ${_areaController.text}, ${_townController.text}, ${_stateController.text} - ${_pinController.text}';
      } else {
        throw Exception('Please enter all values.');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        title: const Text(
          'Select an address',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  ListTile(
                    title: Text(address),
                    leading: Radio(
                      activeColor: AppColors.mainColor,
                      value: Address.saved,
                      groupValue: _isSaved,
                      onChanged: (Address? val) {
                        setState(() {
                          _isSaved = val!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: BigText(
                        text: 'OR',
                      ),
                    ),
                  ),
                ],
              ),
            Form(
              key: _addressFormKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomTextFeild(
                      controller: _nameController,
                      hintText: 'Reciever\'s Name',
                      icon: Icon(
                        CupertinoIcons.person,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    CustomTextFeild(
                      controller: _houseController,
                      hintText: 'Flat, House no., Building',
                      icon: Icon(
                        CupertinoIcons.house_alt,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    CustomTextFeild(
                      controller: _areaController,
                      hintText: 'Area, Street',
                      icon: Icon(
                        Ionicons.trail_sign_outline,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    CustomTextFeild(
                      controller: _townController,
                      hintText: 'Town, City',
                      icon: Icon(
                        Ionicons.business_outline,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    CustomTextFeild(
                      controller: _pinController,
                      hintText: 'Pincode',
                      icon: Icon(
                        CupertinoIcons.map_pin_ellipse,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    CustomTextFeild(
                      isEnabled: false,
                      controller: _stateController,
                      hintText: 'State',
                      icon: Icon(
                        CupertinoIcons.map_pin_ellipse,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    ApplePayButton(
                      height: Dimensions.height45,
                      margin: EdgeInsets.only(top: Dimensions.height10),
                      width: double.infinity,
                      style: ApplePayButtonStyle.black,
                      type: ApplePayButtonType.checkout,
                      paymentConfigurationAsset: 'applepay.json',
                      onPaymentResult: onApplePayResult,
                      paymentItems: paymentItems,
                      onPressed: () => payPressed(address),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GooglePayButton(
                      width: double.infinity,
                      height: Dimensions.height55,
                      style: GooglePayButtonStyle.flat,
                      type: GooglePayButtonType.checkout,
                      paymentConfigurationAsset: 'gpay.json',
                      onPaymentResult: onGooglePayResult,
                      paymentItems: paymentItems,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      onPressed: () => payPressed(address),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
