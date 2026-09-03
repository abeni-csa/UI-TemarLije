enum AppRole { admin, user }

enum Role {
  admin,
  manager,
  operator,
  fleetOwner,
  fleetManager,
  fleetOperator,
  driver,
  user,
  unknown,
}

enum ChatType { support }

enum ChatMessageStatus { sending, sent, delivered, read, failed }

enum VerificationStatus {
  unknown,
  pending,
  submitted,
  underReview,
  approved,
  rejected,
}

enum TextSizes { small, medium, large }

enum TransactionType { buy, sell }

enum ProductType { single, variable }

enum ProductVisibility { published, hidden }

enum ImageType { asset, network, memory, file }

enum MediaCategory { folders, banners, brands, categories, products, users }

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm,
}

// ignore: constant_identifier_names
enum EmploymentType { PartTime, Permanent, Contract, Internship }

// ignore: constant_identifier_names
enum RoomType { Regular, Laboratory, ComputerLab, SportsField }

enum EducationLevel {
  // ignore: constant_identifier_names
  KG1,
  // ignore: constant_identifier_names
  KG2,
  // ignore: constant_identifier_names
  KG3,
  // ignore: constant_identifier_names
  Primary,
  // ignore: constant_identifier_names
  Middle,
  // ignore: constant_identifier_names
  Secondary9_10,
  // ignore: constant_identifier_names
  Secondary11_12,
}

enum SubjectTypeStream {
  // ignore: constant_identifier_names
  SchoolSpecific,
  // ignore: constant_identifier_names
  FieldBased,
  // ignore: constant_identifier_names
  Core,
  // ignore: constant_identifier_names
  NaturalScience,
  // ignore: constant_identifier_names
  SocialScience,
  // ignore: constant_identifier_names
  Business,
  // ignore: constant_identifier_names
  Arts,
  // ignore: constant_identifier_names
  Technology,
  // ignore: constant_identifier_names
  Agriculture,
  // ignore: constant_identifier_names
  HealthScience,
  // ignore: constant_identifier_names
  General, // For levels without streams
}

enum RegionalStatesAndCities {
  // ignore: constant_identifier_names
  AddisAbaba,
  // ignore: constant_identifier_names
  DireDawa,
  // ignore: constant_identifier_names
  AfarRegion,
  // ignore: constant_identifier_names
  AmharaRegion,
  // ignore: constant_identifier_names
  BenishangulGumuzRegion,
  // ignore: constant_identifier_names
  CentralEthiopiaRegionalState,
  // ignore: constant_identifier_names
  GambelaRegion,
  // ignore: constant_identifier_names
  HarariRegion,
  // ignore: constant_identifier_names
  OromiaRegion,
  // ignore: constant_identifier_names
  SidamaRegion,
  // ignore: constant_identifier_names
  SomaliRegion,
  // ignore: constant_identifier_names
  SouthEthiopiaRegion,
  // ignore: constant_identifier_names
  SouthWestEthiopiaPeoplesRegion,
  // ignore: constant_identifier_names
  TigrayRegion,
}

extension CamelToTitleCase on String {
  String toTitleCase() {
    if (isEmpty) return this;

    String spaced = replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (Match match) => ' ${match.group(0)}',
    );

    return spaced[0].toUpperCase() + spaced.substring(1);
  }
}
