class GiftCard {
  String caption;
  String captionLower;
  String code;
  String color;
  String currency;
  String data;
  String desc;
  String disclosures;
  num discount;
  String domain;
  String fee;
  String fontcolor;
  bool isVariable;
  String iso;
  String logo;
  num maxRange;
  num minRange;
  String sendcolor;
  String value;

  GiftCard(
      {this.caption,
      this.captionLower,
      this.code,
      this.color,
      this.currency,
      this.data,
      this.desc,
      this.disclosures,
      this.discount,
      this.domain,
      this.fee,
      this.fontcolor,
      this.isVariable,
      this.iso,
      this.logo,
      this.maxRange,
      this.minRange,
      this.sendcolor,
      this.value});

  GiftCard.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    captionLower = json['captionLower'];
    code = json['code'];
    color = json['color'];
    currency = json['currency'];
    data = json['data'];
    desc = json['desc'];
    disclosures = json['disclosures'];
    discount = json['discount'];
    domain = json['domain'];
    fee = json['fee'];
    fontcolor = json['fontcolor'];
    isVariable = json['is_variable'];
    iso = json['iso'];
    logo = json['logo'];
    maxRange = json['max_range'];
    minRange = json['min_range'];
    sendcolor = json['sendcolor'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['captionLower'] = this.captionLower;
    data['code'] = this.code;
    data['color'] = this.color;
    data['currency'] = this.currency;
    data['data'] = this.data;
    data['desc'] = this.desc;
    data['disclosures'] = this.disclosures;
    data['discount'] = this.discount;
    data['domain'] = this.domain;
    data['fee'] = this.fee;
    data['fontcolor'] = this.fontcolor;
    data['is_variable'] = this.isVariable;
    data['iso'] = this.iso;
    data['logo'] = this.logo;
    data['max_range'] = this.maxRange;
    data['min_range'] = this.minRange;
    data['sendcolor'] = this.sendcolor;
    data['value'] = this.value;
    return data;
  }
}
