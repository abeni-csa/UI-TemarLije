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
          child: Row(
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
        ),
      ),
    );
  }
}
