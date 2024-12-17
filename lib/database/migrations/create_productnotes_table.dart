import 'package:vania/vania.dart';

class CreateProductnotesTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('productnotes', () {
      id();
      bigInt('prod_id', unsigned: true);
      date('date');
      text('text');
      timeStamps();
      foreign('prod_id', 'products', 'id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('productnotes');
  }
}
