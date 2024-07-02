// controllers/client_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/sellers.dart';

import '../repository/sellers_repository.dart';

final clientRepositoryProvider = Provider((ref) => ClientRepository());

final clientsProvider =
    StateNotifierProvider<ClientsNotifier, List<Client>>((ref) {
  return ClientsNotifier(ref.read(clientRepositoryProvider));
});

class ClientsNotifier extends StateNotifier<List<Client>> {
  final ClientRepository _clientRepository;

  ClientsNotifier(this._clientRepository)
      : super(_clientRepository.getAllClients());

  void addClient(Client client) {
    _clientRepository.addClient(client);
    state = _clientRepository.getAllClients();
  }

  void updateClient(Client client) {
    _clientRepository.updateClient(client);
    state = _clientRepository.getAllClients();
  }

  void deleteClient(String id) {
    _clientRepository.deleteClient(id);
    state = _clientRepository.getAllClients();
  }
}
