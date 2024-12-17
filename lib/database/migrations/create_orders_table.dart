import 'package:vania/vania.dart';

class CreateOrdersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orders', () {
      id();
      date('date');
      bigInt('cust_id', unsigned: true);
      timeStamps();
      foreign('cust_id', 'customers', 'id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}
