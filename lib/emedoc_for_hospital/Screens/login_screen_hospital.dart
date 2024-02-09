import 'package:country_picker/country_picker.dart';
import 'package:emedoc/utils/colors.dart';
import 'package:emedoc/utils/custom_button.dart';
import 'package:emedoc/emedoc_for_hospital/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginScreenHospital extends StatefulWidget {
  const LoginScreenHospital({Key? key}) : super(key: key);

  @override
  State<LoginScreenHospital> createState() => _LoginScreenHospitalState();
}

class _LoginScreenHospitalState extends State<LoginScreenHospital> {
  String countrycode = '';
  final textcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showCountryPicker2(BuildContext context) {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          countrycode = country.phoneCode;
        });
      },
    );
  }

  void _send() {
    if (_formKey.currentState!.validate()) {
      String ph = '+' + countrycode + textcontroller.text;
      sendPhoneNumberHospital(ph, context);
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    } else if (!(value.length == 10)) {
      return 'Please enter a valid phone number';
    } else if (countrycode == '') {
      return 'Please select a Country Code';
    }
    return null; // Return null if the input is valid
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Hospital login'),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                text: '📍  Pick Country',
                onPressed: () => showCountryPicker2(context),
                width: size.width * 0.6),
            SizedBox(
              height: size.height * 0.012,
            ),
            Row(
              children: [
                Text('+$countrycode'),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: _validatePhoneNumber,
                        controller: textcontroller,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _send,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
