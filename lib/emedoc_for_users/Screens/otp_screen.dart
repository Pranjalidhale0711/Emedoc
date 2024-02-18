
import 'package:emedoc/utils/colors.dart';
import 'package:emedoc/emedoc_for_users/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enter OTP'
         , style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
        ),
        backgroundColor: appBarColor,
        toolbarHeight: size.height / 12,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'An OTP was sent to you',
              style: TextStyle(
                color:textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(val.trim(), context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}