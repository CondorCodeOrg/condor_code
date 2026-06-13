import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/contact.dart';

abstract class ContactsRepository {
  Future<DataResult<Contact>> getContact();
}
