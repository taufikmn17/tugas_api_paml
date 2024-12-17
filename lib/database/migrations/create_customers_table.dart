import 'package:vania/vania.dart';

class CreateCustomersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('customers', () {
      id(); // Primary key dengan panjang 5 karakter
      string('cust_name', length: 50); // Nama pelanggan
      string('cust_address', length: 50); // Alamat pelanggan
      string('cust_city', length: 20); // Kota pelanggan
      string('cust_state', length: 5); // Provinsi/Negara bagian
      string('cust_zip', length: 7); // Kode pos
      string('cust_country', length: 25); // Negara pelanggan
      string('cust_telp', length: 15); // Nomor telepon
      timeStamps(); // Kolom created_at dan updated_at
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('customers'); // Menghapus tabel jika ada
  }
}
