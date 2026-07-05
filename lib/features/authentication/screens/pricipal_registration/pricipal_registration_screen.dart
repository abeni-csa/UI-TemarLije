import 'package:flutter/material.dart';

import 'package:ui_temarlije/common/widgets/layouts/template/site_layout.dart';
import 'package:ui_temarlije/features/authentication/screens/pricipal_registration/responsive_screens/pricipal_registration_desktop_tablet.dart';
import 'package:ui_temarlije/features/authentication/screens/pricipal_registration/responsive_screens/pricipal_registration_mobile.dart';

class PricipalRegistrationScreen extends StatelessWidget {
  const PricipalRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemarLijeSiteTemplate(
      useLayout: false,
      desktop: PricipalRegistrationDesktopTablet(),
      tablet: PricipalRegistrationDesktopTablet(),
      mobile: PricipalRegistrationMobile(),
    );
  }
}
