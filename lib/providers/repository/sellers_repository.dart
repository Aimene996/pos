// repositories/client_repository.dart
import 'package:hive/hive.dart';

import '../../models/sellers.dart';

class ClientRepository {
  final Box<Client> _clientBox = Hive.box<Client>('clients');

  List<Client> getAllClients() => _clientBox.values.toList();

  void addClient(Client client) => _clientBox.put(client.id, client);

  Client? getClient(String id) => _clientBox.get(id);

  void deleteClient(String id) => _clientBox.delete(id);

  void updateClient(Client client) => _clientBox.put(client.id, client);
}
