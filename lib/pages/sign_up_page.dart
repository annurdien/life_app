import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_app/themes/custom_theme.dart';
import 'package:life_app/widgets/custom_text_field.dart';

class SignUpPage extends StatefulHookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;

    final fullnameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final passwordObscure = useState<bool>(true);
    final confirmPasswordObscure = useState<bool>(true);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20.w),
            children: [
              20.verticalSpace,
              Text(
                "Registration",
                style: textTheme.title.withColor(colors.snow),
                textAlign: TextAlign.center,
              ),
              20.verticalSpace,
              CustomTextInput(
                controller: fullnameController,
                title: "Full Name",
                hintText: "Enter your fullname",
              ),
              20.verticalSpace,
              CustomTextInput(
                controller: phoneController,
                title: "Phone",
                hintText: "Enter your phone number",
              ),
              20.verticalSpace,
              CustomTextInput(
                controller: emailController,
                title: "Email",
                hintText: "Enter your email",
              ),
              20.verticalSpace,
              CustomTextInput(
                obscureText: passwordObscure.value,
                controller: passwordController,
                title: "Password",
                hintText: "********",
                suffix: GestureDetector(
                  onTap: () {
                    passwordObscure.value = !passwordObscure.value;
                  },
                  child: Icon(
                    Icons.lock,
                    color: colors.white,
                  ),
                ),
              ),
              20.verticalSpace,
              CustomTextInput(
                obscureText: confirmPasswordObscure.value,
                controller: confirmPasswordController,
                title: "Confirm Password",
                hintText: "********",
                suffix: GestureDetector(
                  onTap: () {
                    confirmPasswordObscure.value =
                        !confirmPasswordObscure.value;
                  },
                  child: Icon(
                    Icons.lock,
                    color: colors.white,
                  ),
                ),
              ),
              40.verticalSpace,
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF14B786),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                ),
                child: const Text("Register"),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You have an account?",
                    style: textTheme.caption.withColor(colors.white),
                  ),
                  5.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    child: Text(
                      "Login",
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
}
