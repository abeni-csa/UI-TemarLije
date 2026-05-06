import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:ui_temarlije/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemarLijeSiteTemplate(
      desktop: Desktop(),
      tablet: Tablet(),
      mobile: Mobile(),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TemarLijeRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.shade50,
                child: const Center(child: Text("BOX 1")),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: TemarLijeRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.shade50,
                child: const Center(child: Text("BOX 2")),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TemarLijeRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.shade50,
                child: const Center(child: Text("BOX 3")),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/mark-list');
                },
                child: const Center(child: Text("Go to MarkList")),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// FIST ROW
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TemarLijeRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.shade50,
                child: const Center(child: Text("BOX 1")),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TemarLijeRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.shade50,
                child: const Center(child: Text("BOX 3")),
              ),
            ),
          ],
        ),

        const SizedBox(width: 20),

        /// Second
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 20),
            TemarLijeRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.yellow.shade50,
              child: const Center(child: Text("BOX 4")),
            ),
            const SizedBox(width: 20),
            TemarLijeRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.red.shade50,
              child: const Center(child: Text("BOX 5")),
            ),
          ],
        ),
      ],
    );
  }
}

class Mobile extends StatelessWidget {
  const Mobile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Second
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TemarLijeRoundedContainer(
              height: 450,
              backgroundColor: Colors.blue.shade50,
              child: const Center(child: Text("BOX 1")),
            ),
            const SizedBox(width: 20),
            TemarLijeRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.yellow.shade50,
              child: const Center(child: Text("BOX 2")),
            ),
            const SizedBox(width: 20),
            TemarLijeRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.red.shade50,
              child: const Center(child: Text("BOX 3")),
            ),
            const SizedBox(width: 20),
            TemarLijeRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.yellow.shade50,
              child: const Center(child: Text("BOX 4")),
            ),
            const SizedBox(width: 20),
            TemarLijeRoundedContainer(
              height: 190,
              width: double.infinity,
              backgroundColor: Colors.red.shade50,
              child: const Center(child: Text("BOX 5")),
            ),
          ],
        ),
      ],
    );
  }
}
