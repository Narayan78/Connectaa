

import 'package:connectaa/features/select_contact/repository/select_contact_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactControllerProvider = FutureProvider((ref){
   final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
   return selectContactRepository.getContact();
}); 