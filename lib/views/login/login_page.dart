import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // return AuthFlowBuilder<PhoneAuthController>(
    //   listener: (oldState, newState, controller) {
    //     if (newState is PhoneVerified) {
    //       debugPrint('Phone number verified.');
    //       Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(
    //           builder: (context) => const HomePage(),
    //         ),
    //       );
    //     }
    //   },
    //   builder: (context, state, ctrl, child) {
    //     if (state is AwaitingPhoneNumber || state is SMSCodeRequested) {
    //       return PhoneInput(
    //         initialCountryCode: 'IN',
    //         onSubmit: (phoneNumber) {
    //           ctrl.acceptPhoneNumber(phoneNumber);
    //         },
    //       );
    //     } else if (state is SMSCodeSent) {
    //       debugPrint('Confirmation Result: ${state.confirmationResult}');
    //       return SMSCodeInput(onSubmit: (smsCode) {
    //         ctrl.verifySMSCode(
    //           smsCode,
    //           verificationId: state.verificationId,
    //           confirmationResult: state.confirmationResult,
    //         );
    //       });
    //     } else if (state is SigningIn) {
    //       return const CircularProgressIndicator();
    //     } else if (state is AuthFailed) {
    //       return ErrorText(exception: state.exception);
    //     } else {
    //       return Text('Unknown state $state');
    //     }
    //   },
    // );
    return const Placeholder();
  }
}
