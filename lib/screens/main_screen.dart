import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qr_auth/extensions/string_extensions.dart';
import 'package:qr_auth/routes/app_router.routes.dart';
import 'package:qr_auth/screens/controllers/main_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

StreamController<DatabaseEvent> sessionsController = StreamController<DatabaseEvent>.broadcast();

class MainScreen extends StatefulHookConsumerWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    sessionsController.stream.listen((value) {
      final data = value.snapshot.value as Map<String, dynamic>?;

      if (data != null || data!.containsKey("token") == true) {
        final token = (data['token'] as String?)?.decrypt();

        if (token != null) {
          ref.read(signInWithGoogleProvider.notifier).signInWithToken(token: token);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton.icon(
            onPressed: () {
              launchUrl(Uri.parse("https://github.com/TamilKannanCV/qr_auth"));
            },
            icon: const Icon(Icons.code),
            label: "Source Code".text.make(),
          ),
          const SizedBox(width: 10.0),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Builder(builder: (context) {
            final provider = ref.watch(signInWithGoogleProvider);
            if (provider.isLoading) {
              return const LinearProgressIndicator();
            }
            return const VxNone();
          }),
        ),
      ),
      body: [
        [
          "User Details".text.xl2.bold.make(),
          Builder(
            builder: (context) {
              final provider = ref.watch(signInWithGoogleProvider);
              return provider.when(
                data: (user) {
                  if (user == null) {
                    return "User not signed in".text.make();
                  }

                  return [
                    [
                      TableRow(children: [
                        "Name".text.semiBold.make().p12(),
                        "${user.displayName}".text.make().p12(),
                      ]),
                      TableRow(children: [
                        "Email".text.semiBold.make().p12(),
                        "${user.email}".text.make().p12(),
                      ]),
                      TableRow(children: [
                        "Scan a QR code to sign in other users".text.semiBold.make().p12().box.alignCenterLeft.make(),
                        FilledButton.icon(
                          onPressed: () async {
                            ScanRoute().go(context);
                          },
                          label: "Scan".text.make(),
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            size: 15.0,
                          ),
                        ).centered().p12(),
                      ]),
                      TableRow(children: [
                        "Logout the user?".text.semiBold.make().p12().box.alignCenterLeft.make(),
                        FilledButton(
                          onPressed: () {
                            ref.read(signInWithGoogleProvider.notifier).signOut();
                          },
                          child: "Logout".text.make(),
                        ).centered().p12(),
                      ]),
                    ].table.gray400.roundedBorder.make(),
                    const SizedBox(height: 10.0),
                  ].column(axisSize: MainAxisSize.min).py12();
                },
                skipError: true,
                error: (error, stackTrace) => const VxNone(),
                loading: () => const VxNone(),
              );
            },
          ),
        ]
            .column(crossAlignment: CrossAxisAlignment.start, axisSize: MainAxisSize.min)
            .p12()
            .wFull(context)
            .constrainedBox(const BoxConstraints(maxWidth: 500.0))
            .box
            .border(color: Colors.grey)
            .rounded
            .make(),
        const SizedBox(height: 20.0),
        Builder(builder: (context) {
          final user = ref.watch(signInWithGoogleProvider).valueOrNull;
          if (user != null) {
            return const VxNone();
          }
          return [
            "Sign-in options".text.xl2.bold.make(),
            const SizedBox(height: 20.0),
            Builder(builder: (context) {
              final qrProvider = ref.watch(startQrSessionProvider);

              return qrProvider
                  .when(
                    data: (data) {
                      return [
                        QrImageView(
                          data: data,
                        ).box.square(180.0).make(),
                        "Scan QR to sign-in".text.gray500.make(),
                      ].column(axisSize: MainAxisSize.min);
                    },
                    error: (error, stackTrace) => const VxNone(),
                    loading: () => const CircularProgressIndicator.adaptive(),
                  )
                  .centered();
            }),
            const SizedBox(height: 20.0),
            [
              const Divider().p12().expand(),
              "Or".text.semiBold.make().centered(),
              const Divider().p12().expand(),
            ].row(),
            const SizedBox(height: 20.0),
            [
              Builder(builder: (context) {
                final provider = ref.watch(signInWithGoogleProvider);
                if (provider.isLoading) {
                  return const CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                  ).box.square(20.0).make().centered();
                }
                return FilledButton.icon(
                  onPressed: () {
                    ref.read(signInWithGoogleProvider.notifier).signIn();
                  },
                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFF2f88f0)),
                  icon: const Icon(
                    Iconsax.google_1_bold,
                    size: 20.0,
                  ),
                  label: "Sign-in with Google".text.make(),
                ).wFull(context);
              }),
            ].column(axisSize: MainAxisSize.min).p8(),
          ].column(crossAlignment: CrossAxisAlignment.start).p12().wFull(context).constrainedBox(const BoxConstraints(maxWidth: 500.0)).box.border(color: Colors.grey).rounded.make();
        }),
      ].column(axisSize: MainAxisSize.min).centered(),
      bottomNavigationBar: "Made with \u2764 by Tamil Kannan C V".text.make().centered().box.height(kToolbarHeight).make(),
    );
  }
}
