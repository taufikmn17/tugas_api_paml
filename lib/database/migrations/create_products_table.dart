import 'package:vania/vania.dart';

class CreateProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      id();
      bigInt('vend_id', unsigned: true);
      string('prod_name');
      integer('prod_price');
      text('prod_desc');
      timeStamps();
      foreign('vend_id', 'vendors', 'id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
