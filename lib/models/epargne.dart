import 'package:finance/models/client.dart';

class Epargne {
  String id;
  double balance;
  String acc_num;
  Client client;
  String creator_id;
  String account_type_id;
  bool state;
  double amount_blocked;
  double nanti;
  int block_period;
  DateTime block_end_date;
  double mise;
  DateTime created_at1608833432;
  DateTime updated_at1609961024;

  Epargne({
    this.id,
    this.balance,
    this.acc_num,
    this.client,
    this.creator_id,
    this.account_type_id,
    this.state,
    this.amount_blocked,
    this.nanti,
    this.block_period,
    this.block_end_date,
    this.mise,
    this.created_at1608833432,
    this.updated_at1609961024,
  });
}
