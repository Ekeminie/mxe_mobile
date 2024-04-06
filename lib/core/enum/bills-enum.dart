import 'dart:ui';

enum BillsEnum {
  airtime(
      title: "Airtime",
      image: "airtime",
      sub: "1.5% cash back",
      code: 'airtime'),
  data(title: "Data", image: "data", sub: "0.75% cash back", code: 'data'),
  electricity(
      title: "Electricity",
      sub: "1.5% cash back",
      image: 'electricity',
      code: 'electricity'),
  cable(
      title: "Cable/TV", image: 'cable', sub: "1.5% cash back", code: 'cable'),
  games(title: "Games", image: 'games', sub: '1.5% cash back', code: 'betting');

  final String? title;
  final String? sub;
  final String? image;
  final String? code;

  const BillsEnum({this.title, this.image, this.sub, this.code});
}

enum NetworkProviderEnum {
  none(),
  mtn(title: "Mtn", image: "mtn", color: Color(0xffF8C000)),
  airtel(title: "Airtel", image: "airtel", color: Color(0xffE20010)),
  glo(title: "Glo", image: 'glo', color: Color(0xff50B651)),
  etisalat(title: "Etisalat", image: 'etisalat', color: Color(0xff006E53));

  final String? title;
  final String? image;
  final Color? color;

  const NetworkProviderEnum({this.title, this.image, this.color});
}

enum ElectricityProviderEnum {
  ikedc(
    title: "Ikeja Electricity (IKEDC)",
    image: "ikedc",
  ),
  ekedc(
    title: "Eko Electric",
    image: "ekedc",
  ),
  ibedc(
    title: "Ibadan Electricity (IBEDC)",
    image: "ikedc",
  ),
  aedc(
    title: "Abuja Electricity (AEDC)",
    image: "aedc",
  ),
  jedc(
    title: "Jos Electricity (JED)",
    image: "jedc",
  ),
  phedc(
    title: "Port Harcourt Electricity (PHED)",
    image: "phedc",
  );

  final String? title;
  final String? image;

  const ElectricityProviderEnum({
    this.title,
    this.image,
  });
}

enum CableProviderEnum {
  dstv(title: "DSTV", image: "dstv", color: Color(0xff019ADD)),
  gotv(title: "GOTV", image: "gotv", color: Color(0xff192939)),
  startimes(title: "Startimes", image: 'startimes', color: Color(0xffF39205));

  final String? title;
  final String? image;
  final Color? color;

  const CableProviderEnum({this.title, this.image, this.color});
}

enum BettingProviderEnum {
  bet9ja(title: "Bet9ja", image: "bet9ja", color: Color(0xffF7F9FC)),
  sportybet(title: "SportyBet", image: "sportybet", color: Color(0xffFF5226)),
  nairabet(title: "Nairabet", image: "nairabet", color: Color(0xffF7F9FC)),
  betway(title: "Betway", image: 'betway', color: Color(0xff272726));

  final String? title;
  final String? image;
  final Color? color;

  const BettingProviderEnum({this.title, this.image, this.color});
}
