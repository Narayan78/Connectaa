import 'package:connectaa/features/select_contact/repository/select_contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactRepository.getContact();
});



final selectContactControllerProvider = Provider((ref){
  final selectedContactRepository = ref.watch(selectContactsRepositoryProvider);
return SelectContactController(ref: ref, selectContactRepository: selectedContactRepository);
});


class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContactController(
      {required this.ref, required this.selectContactRepository});

  void selectContact(Contact contact, BuildContext context) {
    selectContactRepository.selectContact(contact, context);
  }
}
