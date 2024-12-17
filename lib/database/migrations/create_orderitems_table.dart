import 'package:vania/vania.dart';

class CreateOrderitemsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orderitems', () {
      id();
      bigInt('order_num', unsigned: true);
      bigInt('prod_id', unsigned: true);
      integer('quantity');
      integer('size');
      timeStamps();
      foreign('prod_id', 'products', 'id');
      foreign('order_num', 'orders', 'id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}
