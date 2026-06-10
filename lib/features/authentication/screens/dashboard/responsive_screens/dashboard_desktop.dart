import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ui_temarlije/common/widgets/card/dashboard_card.dart';
import 'package:ui_temarlije/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ui_temarlije/data/dummey/dashbord_controller.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';
import 'package:ui_temarlije/utils/device/device_utility.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashbordCartController controller = Get.put(DashbordCartController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TemarLijeSizes.spaceBtwItems),
            // Use Expanded or flexible layouts for responsive cards
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  dragStartBehavior: DragStartBehavior.start,
                  child: Wrap(
                    spacing: TemarLijeSizes.spaceBtwItems,
                    runSpacing: TemarLijeSizes.spaceBtwItems,
                    children: const [
                      TemarLijeDashboardCard(
                        title: "Students",
                        value: "2,500",
                        percentage: "+0.5%",
                        isPositive: true,
                        icon: Iconsax.people,
                      ),
                      TemarLijeDashboardCard(
                        title: "Teachers",
                        value: "46",
                        percentage: "-10%",
                        isPositive: false,
                        icon: Iconsax.unlimited,
                      ),
                      TemarLijeDashboardCard(
                        title: "Students",
                        value: "2,500",
                        percentage: "+0.5%",
                        isPositive: true,
                        icon: Iconsax.people,
                      ),
                      TemarLijeDashboardCard(
                        title: "Teachers",
                        value: "46",
                        percentage: "-10%",
                        isPositive: false,
                        icon: Iconsax.unlimited,
                      ),
                      TemarLijeDashboardCard(
                        title: "Staff",
                        value: "9",
                        percentage: "+10%",
                        isPositive: true,
                        icon: Iconsax.shopping_cart,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: TemarLijeSizes.spaceBtwItems),

            /// GRAPH
            Row(
              children: [
                const SizedBox(height: TemarLijeSizes.spaceBtwItems),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      /// Bar Graph
                      TemarLijeRoundedContainer(
                        child: Column(
                          children: [
                            Text(
                              "Weekly Sales",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),

                            const SizedBox(
                              height: TemarLijeSizes.spaceBtwItems,
                            ),
                            // Grap
                            SizedBox(
                              height: 400,
                              child: BarChart(
                                BarChartData(
                                  titlesData: buildFlTitlesData(),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(
                                      top: BorderSide.none,
                                      right: BorderSide.none,
                                    ),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: true,
                                    drawVerticalLine: true,
                                    horizontalInterval: 200,
                                  ),
                                  barGroups: controller.weeklySales
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => BarChartGroupData(
                                          x: e.key,
                                          barRods: [
                                            BarChartRodData(
                                              toY: e.value,
                                              width: 30,
                                              color: TemarLijeColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    TemarLijeSizes.sm,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                  groupsSpace: TemarLijeSizes.spaceBtwItems,

                                  barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipColor: (_) =>
                                          TemarLijeColors.secondary,
                                    ),
                                    touchCallback:
                                        TemarLijeDeviceUtils.isDesktopScreen(
                                          context,
                                        )
                                        ? (barTouchEvent, barTouchResponse) {}
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                      /// Order
                      TemarLijeRoundedContainer(),
                    ],
                  ),
                ),

                const SizedBox(height: TemarLijeSizes.spaceBtwItems),

                /// Pie Chart
                Expanded(child: TemarLijeRoundedContainer()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      show: true,

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            //map Index to the Diser Days of the week
            final days = ["Mon", "Tue", "Wen", "Thu", "Fir", "Sat", "Sun"];
            //calualate thie idnex ensure it wrap fo the correct day
            final index = value.toInt() % days.length;

            // get the data / croponding to the calucated index
            final day = days[index];
            return SideTitleWidget(
              child: Text(day),
              meta: TitleMeta(
                rotationQuarterTurns: 0,
                axisSide: AxisSide.bottom,
                axisPosition: 1.0,
                min: 0.0,
                max: double.infinity,
                sideTitles: SideTitles(showTitles: false),
                appliedInterval: 200,
                parentAxisSize: 1.0,
                formattedValue: "",
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          interval: 200,
          reservedSize: 50,
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
