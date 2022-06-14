import 'package:auto_route/auto_route.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/pages/sign_up_page.dart';
import 'package:life_app/routes/router.dart';
import 'package:life_app/themes/custom_theme.dart';

import '../core/provider/authentication_provider.dart';
import '../utils.dart';
import '../widgets/custom_text_field.dart';

class SigInPage extends StatefulHookConsumerWidget {
  const SigInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigInPageState();
}

class _SigInPageState extends ConsumerState<SigInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscureText = useState<bool>(true);

    final colors = context.colors;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              54.verticalSpace,
              Image.asset(
                'assets/app_logo.png',
                width: 150.w,
                height: 150.w,
              ),
              60.verticalSpace,
              TextButton(
                onPressed: () {
                  pushLoginGoogle(ref);
                },
                style: TextButton.styleFrom(
                  backgroundColor: colors.snow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  textStyle: textTheme.body.withColor(colors.black),
                  padding: EdgeInsets.all(10.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/google_logo.svg'),
                    8.horizontalSpace,
                    Text(
                      "Login With Google",
                      style: textTheme.body
                          .withColor(const Color(0xFF1F3757))
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Text(
                "OR",
                style: textTheme.button.withColor(colors.white),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextInput(
                      controller: emailController,
                      title: "Email",
                      hintText: "Enter your email",
                    ),
                    20.verticalSpace,
                    CustomTextInput(
                      controller: passwordController,
                      title: "Password",
                      hintText: "********",
                      obscureText: obscureText.value,
                      suffix: GestureDetector(
                        onTap: () {
                          obscureText.value = !obscureText.value;
                        },
                        child: Icon(
                          Icons.lock,
                          color: colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password?",
                  style: textTheme.body.withColor(colors.white),
                  textAlign: TextAlign.right,
                ),
              ),
              20.verticalSpace,
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF14B786),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                ),
                child: const Text("Login"),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have account yet?",
                    style: textTheme.caption.withColor(colors.white),
                  ),
                  5.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      context.pushRoute(const SignUpRoute());
                    },
                    child: Text(
                      "Sign Up",
                      style: textTheme.caption.withColor(
                        const Color(0xFF14B786),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  pushLoginGoogle(WidgetRef ref) async {
    EasyLoading.show(status: 'Loading...');

    try {
      final authentication = ref.read(authenticationProvider.notifier);
      await authentication.loginWithGoogle();

      context.router.replaceAll([
        const MyHomeRoute(),
      ]);
    } on PlatformException catch (e) {
      logger.e(e.toString());
      if (e.code != "sign_in_canceled") {
        showErrorLogin();
      }
    } catch (e) {
      logger.e(e);
      showErrorLogin();
      // logToCrashlytics(e, stacktrace);
    } finally {
      EasyLoading.dismiss();
    }
  }

  showErrorLogin() {
    EasyLoading.dismiss();

    CoolAlert.show(
      backgroundColor: AppColors.of(context).snow,
      context: context,
      type: CoolAlertType.error,
      text:
          "Failed to authenticate using your Google Accounts. Please try again.",
    );
  }
}
