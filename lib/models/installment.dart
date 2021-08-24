class Installment {
  late String plotId, amount, received, remaining, paid, date;

  Installment({
    required this.plotId,
    required this.amount,
    required this.received,
    required this.remaining,
    required this.paid,
    required this.date,
  });

  factory Installment.fromJson(Map<String, dynamic> json) {
    return new Installment(
      plotId: json['PlotId'].toString(),
      amount: json['Amount'].toString(),
      received: json['Received'].toString(),
      remaining: json['Remaining'].toString(),
      paid: json['Paid'].toString(),
      date: json['Date'].toString(),
    );
  }
}
