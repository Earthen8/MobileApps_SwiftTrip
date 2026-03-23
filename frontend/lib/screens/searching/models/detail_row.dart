class DetailRow {
  final String label;
  final String amount;

  const DetailRow({required this.label, required this.amount});

  factory DetailRow.fromJson(Map<String, dynamic> json) => DetailRow(
        label: json['label'] as String,
        amount: json['amount'] as String,
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'amount': amount,
      };
}

