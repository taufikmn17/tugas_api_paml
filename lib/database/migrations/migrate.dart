import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'create_customers_table.dart';
import 'create_orders_table.dart';
import 'create_orderitems_table.dart';
import 'create_vendors_table.dart';
import 'create_products_table.dart';
import 'create_productnotes_table.dart';
import 'create_personal_access_tokens_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
    await CreatePersonalAccessTokensTable().up();
    await CreateVendorsTable().up();
    await CreateCustomersTable().up();
    await CreateOrdersTable().up();
    await CreateProductsTable().up();
    await CreateOrderitemsTable().up();
    await CreateProductnotesTable().up();
    await CreateUserTable().up();
  }

  dropTables() async {
    await CreateUserTable().down();
    await CreateProductnotesTable().down();
    await CreateOrderitemsTable().down();
    await CreateProductsTable().down();
    await CreateOrdersTable().down();
    await CreateCustomersTable().down();
    await CreateVendorsTable().down();
  }
}
