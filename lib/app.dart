import 'package:flutter/material.dart';
import 'package:ui_temarlije/common/widgets/custom_shapes/containers/rounded_container.dart';

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: LayoutBuilder(
            builder: (_, constrains) {
              if (constrains.maxWidth >= 1360) {
                return const Desktop();
              } else if (constrains.maxWidth < 1360 &&
                  constrains.maxWidth >= 768) {
                return const Tablet();
              } else {
                return const Mobile();
              }
            },
          ),
        ),
      ),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({Key? key}) : super(key: key);
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
          ],
        ),
      ],
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({Key? key}) : super(key: key);
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
  const Mobile({Key? key}) : super(key: key);
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
